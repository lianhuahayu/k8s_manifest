 #!/bin/bash
 
#ajout optionnel namespace et changement de context
kubectl apply -f 0_namespace/*
kubectl config set-context --current --namespace=icgroup

#application des secrets
kubectl apply -f ./1_secrets

#application des configmap
kubectl apply -f ./2_configmaps

#applications des pv puis pvc
kubectl apply -f ./3_pv_pvc

#application des service
kubectl apply -f ./4_services

#application des deployements et pods
kubectl apply -f ./5_deploy_pods

#deploiements de l'ingress
kubectl apply -f ./6_ingress

exit 0
