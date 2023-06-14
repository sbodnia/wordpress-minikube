#!/bin/bash
PASSWORD=secretpw
NAMESPACE=wordpress

echo "Start deploying to $NAMESPACE namespace"
echo "......................................."
echo
kubectl create namespace $NAMESPACE
kubectl create secret generic mysql-secrets --from-literal=rootpw=$PASSWORD --namespace $NAMESPACE
echo "Creating MySQL resources..."
echo "..........................."
kubectl create --file mysql_vol.yaml --namespace $NAMESPACE
kubectl create --file mysql.yaml --namespace $NAMESPACE
echo "..........................."
echo "Done!"
echo
echo "Creating Redis resources..."
echo "..........................."
kubectl create --file redis_vol.yaml --namespace $NAMESPACE
kubectl create --file redis.yaml --namespace $NAMESPACE
echo "..........................."
echo "Done!"
echo
echo "Creating NFS resources..."
echo "..........................."
kubectl create --file nfs_server_vol.yaml --namespace $NAMESPACE
kubectl create --file nfs_server.yaml --namespace $NAMESPACE 
IP=$(kubectl get svc nfs-service --template '{{.spec.clusterIP}}' -n $NAMESPACE)
if [[ "server: " != "" && $IP != "" ]]; then
  sed -i "s/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$/$IP/" nfs_pv.yaml
fi
kubectl create --file nfs_pv.yaml --namespace $NAMESPACE
kubectl create --file nfs_pvc.yaml --namespace $NAMESPACE
echo "..........................."
echo "Done!"
echo
echo "Creating Wordpress resources..."
echo "..........................."
kubectl create --file wordpress.yaml --namespace $NAMESPACE
echo "..........................."
echo "Done!"
echo
echo "Creating Nginx resources..."
echo "..........................."
kubectl create --file nginx.yaml --namespace $NAMESPACE
echo "..........................."
echo "Done!"
echo
echo
echo "All has been deployed."