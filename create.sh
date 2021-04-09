#!/bin/bash
# set -x #echo on

UNAMECHK=`uname`
KIND_PATH="/usr/local/bin"
EXTERNAL_IP=""
K3D_FILE=$(which k3d)

sp="/-\|"
sc=0
spin() {
  printf "\b${sp:sc++:1}"
  ((sc==${#sp})) && sc=0
}
endspin() {
  printf "\r%s\n" "$@"
}

#Host IP Check
if [[ $EXTERNAL_IP == "" ]]; then
	if [[ $UNAMECHK == "Darwin" ]]; then
		EXTERNAL_IP=$(ifconfig | grep "inet " | grep -v  "127.0.0.1" | awk -F " " '{print $2}'|head -n1)
    # echo $EXTERNAL_IP
	else
		EXTERNAL_IP=$(ip a | grep "inet " | grep -v  "127.0.0.1" | awk -F " " '{print $2}'|awk -F "/" '{print $1}'|head -n1)
    # echo $EXTERNAL_IP
	fi
fi

# Install K3d
if [[ -f "$K3D_FILE" ]]; then
  echo "$K3D_FILE exists."
else
  echo "Downloading & Installing k3d"
  curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
fi

# Copy Temporary File
cp k3d.yml external_ip.yml

# Change API Endpoint
sed -i 's/\"127.0.0.1\"/\"'$EXTERNAL_IP'\"/g' external_ip.yml

# Create Cluster
k3d cluster create --config external_ip.yml

rm external_ip.yml

# Check Cluster Ready
echo "Starting K3d Cluster"
until [[ $(kubectl get pods -A -o jsonpath='{range .items[*]}{.status.conditions[?(@.type=="Ready")].status}{"\t"}{.status.containerStatuses[*].name}{"\n"}{end}' | grep traefik | awk -F " " '{print $1}' ) = 'True' ]]; do 
  spin
done
endspin

echo "All Resources Ready State!"