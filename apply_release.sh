 #!/bin/bash
 
#ajout optionnel namespace et changement de context
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/0_namespace/*
sudo kubectl config set-context --current --namespace=icgroup

#set le bon dns public
public_dns=`dig -x $(dig +short myip.opendns.com @resolver1.opendns.com) +short | sed 's/.$//'`
sudo sed -i "s/<my_public_dns>/$public_dns/g" /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/6_ingress/ingress-ic-webapp.yml 
sudo sed -i "s/<my_public_dns>/$public_dns/g" /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/5_deploy_pods/deploy-ic-webapp.yaml 

#application des secrets
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/1_secrets

#application des configmap
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/2_configmaps

#applications des pv puis pvc
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/3_pv_pvc

#application des service
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/4_services

#application des deployements et pods
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/5_deploy_pods

#deploiements de l'ingress
sudo kubectl apply -f /home/$NUSER/prod/deploy/ic-webapp/$IMAGE_TAG/6_ingress

exit 0
