# k8s_manifest
Les dossiers de ce repo représentes l'ensemble des manifests utilisés pour le déploiement de notre application.\

Ce readme contient aussi les commandes kubernetes qui vont être lancés sur jenkins afin de créer l'ensemble de nos ressources pour acceder à notre site web.\
Ces commandes representent des commandes de nétoyage d'environnement ou bien de création de ressources.
```
kubectl delete -f ./k8s/ic-webapp/.
kubectl delete -f ./k8s/pgadmin/.
kubectl delete -f ./k8s/odoo/.
kubectl delete -f ./k8s/db/.
kubectl delete -f ./k8s/namespace/.

rm -rf k8s

mkdir k8s
git clone https://github.com/Yellow-carpet/k8s_manifest.git ./k8s

kubectl apply -f ./k8s/namespace/.
kubectl apply -f ./k8s/db/.
kubectl apply -f ./k8s/odoo/.
kubectl apply -f ./k8s/pgadmin/.
kubectl apply -f ./k8s/ic-webapp/.

docker rmi dpage/pgadmin4:latest
docker rmi lianhuahayu/ic-webapp:1.0
docker rmi odoo:13
docker rmi postgres:13
 
```
