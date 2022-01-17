 #!/bin/bash
 
#ajout optionnel namespace et changement de context
kubectl apply -f namespace/*
kubectl config set-context --current --namespace=icgroup

#application des secrets
kubectl apply -f ./secrets

#application des configmap
kubectl apply -f ./configmap

#applications des pv puis pvc
kubectl apply -f ./pv_pvc

#application des service
kubectl apply -f ./service

#application des deployements et pods
kubectl apply -f ./deploy_pods

#deploiements de l'ingress
kubectl apply -f ./ingress

exit 0
