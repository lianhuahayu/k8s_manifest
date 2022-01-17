 #!/bin/bash
 
#ajout optionnel namespace et changement de context
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/0_namespace/*
kubectl config set-context --current --namespace=icgroup

#set le bon dns public
public_dns=`dig -x $(dig +short myip.opendns.com @resolver1.opendns.com) +short | sed 's/.$//'`
sed -i "s/<my_public_dns>/$public_dns/g" /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG//6_ingress/ingress-ic-webapp.yml 
sed -i "s/<my_public_dns>/$public_dns/g" /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG//5_deploy_pods/deploy-ic-webapp.yaml 

#application des secrets
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/1_secrets

#application des configmap
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/2_configmaps

#applications des pv puis pvc
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/3_pv_pvc

#application des service
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/4_services

#application des deployements et pods
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/5_deploy_pods

#deploiements de l'ingress
kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/6_ingress

exit 0
