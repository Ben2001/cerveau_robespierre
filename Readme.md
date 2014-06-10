Cerveau du Robo Robespierre
===========================

Pour configurer le client Twitter, créer un fichier `.env` à la racine de l'appli en renseignant ces variables.
`cp dotenv.sample .env`

Ensuite, lancer le serveur `shotgun`

Il faut aussi installer espeak et mbrola
`apt-get install espeak mbrola`

Il faut ensuite ajouter la voix fr dans le repertoire mbrola:
`sudo mkdir /usr/share/mbrola/voices`
`sudo cp fr1 /usr/share/mbrola/voices/`

Le fichier /public/script_demarrage est à mettre dans /etc/rc.local et permet de lancer le serveur au démarrage de la machine
