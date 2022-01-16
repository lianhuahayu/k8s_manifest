# k8s_manifest

```
kubectl delete-f ./k8s/ic-webapp/.
kubectl delete-f ./k8s/pgadmin/.
kubectl delete-f ./k8s/odoo/.
kubectl delete-f ./k8s/db/.
kubectl delete-f ./k8s/namespace/.

rm rf -R k8s

mkdir k8s
git clone https://github.com/Yellow-carpet/k8s_manifest.git ./k8s

kubectl apply -f ./k8s/namespace/.
kubectl apply -f ./k8s/db/.
kubectl apply -f ./k8s/odoo/.
kubectl apply -f ./k8s/pgadmin/.
kubectl apply -f ./k8s/ic-webapp/.
```
