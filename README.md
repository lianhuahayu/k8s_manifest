# Description
## Partie Kubernetes:
Les dossiers de ce repo représentent l'ensemble des manifests utilisés pour le déploiement de notre application.\
### Namespace:
Avant de commencer la rédactions des autres manifests, il falait créer un namespace pour regroupre nos ressources.
````
apiVersion: v1
kind: Namespace
metadata:
  labels:
    createur: CAPGEMINI
  name: icgroup 
  ````
### BDD:
La base de donnée est crée à l'aide d'une image postgres, notre conteneur est rataché à un pvc au niveau de son répertoire où sont stockés les données (/var/lib/postgresql/data).\
Le conteneur est lancé dans un pod qui lui même est relié à un service de type "clusterIP", vu que c'est un service qui n'est pas exposé à l'extérieur du cluster.
### Odoo:
Pour Odoo nous avons créé un service de type node "NodePort" afin qu'il soit consommé depuis l'exterieur, ce service est relié à la ressource déploiement de odoo. Cependant, il faudra tout de même donner le nom du service de la bdd au niveau de la variable d'environnement "HOST" lors de la création du conteneur.
```
 .....   
    spec:
      containers:
      - name: odoo 
        image: odoo:13
        env:
          - name: HOST
            value: db-service
          - name: PASSWORD
            value: odoo
          - name: USER
            value: odoo 
        ports:
          - name: http
            containerPort: 8069
 ````
### PgAdmin:
Comme pour odoo le type du service sera un "NodePort". Par contre, ici pour se connecter à la bdd nous n'avons pas varaible d'environnement pour le conteneur mais nou Devons passer par un autre moyen. La solution est de créer un server.json dans un configMap qui sera "monté" dans le dossier pgadmin4 du conteneur, comme ça lors de la création du pods de pgadmin il sera automatiqument connécté à la bdd.\
Pour revenir à notre fichier servers.json, les éléments important à préciser sont : le Username, le port et le nom du service de notre bdd.

```
{
    "Servers": {
      "1": {
        "Name": "pg",
        "Group": "Servers",
        "Port": 5432,
        "Username": "odoo",
        "Host": "db-service",
        "PassFile": "/pgpass",
        "SSLMode": "prefer",
        "MaintenanceDB": "postgres"
      }
    }
  }
 ```
### IC-WebApp (site vitrine) :
Pour cette partie, un Ingress est utilisé pour gèrer l'accès externe aux services précédement cités. Dans le manifest de l'ingress, au niveau du "host" dans les "rules", le dns publique d'une instances aws déjà créer est reseignée (c'est dans cette instances que sont exécuté l'ensemble des manifests).\
Pour la ressources "Deploy", deux replicas sont créés, les conteneurs sont crées à partir de l'image docker demandé en début de projet, et cette dernière à deux variables d'environnements (ODOO_URL, PGADMIN_URL) qui auront pour valeur <nom_dns_public>:<node_du_service>.

## Utilisation Jenkins :
Ce readme contient aussi les commandes kubernetes qui vont être lancés sur jenkins afin de créer l'ensemble de nos ressources pour acceder à notre site web.\
Ces commandes representent des commandes de nétoyage d'environnement ou bien de création de ressources sur kubernetes.
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
