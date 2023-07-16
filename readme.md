# Configuration des gangs dans ESX

Ce projet vise à ajouter un système de gangs dans le cadre d'un serveur ESX (EssentialMode Extended) pour Grand Theft Auto V (GTA V). Il ajoute divers gangs tels que Pariah, Vagos, Cartel, Lost, Deadsec, Miami Boy, Ghost, Families, Ballas, Carjacker, et d'autres qui pourraient être ajoutés à l'avenir.

## Aperçu du contenu

- `client.lua`: Ce fichier contient la logique du côté client pour les interactions liées aux gangs, telles que l'ouverture des menus, les actions avec les joueurs et les véhicules, et bien d'autres choses.
- `server.lua`: Ce fichier contient la logique du côté serveur pour gérer les interactions des gangs, les actions des joueurs, les changements de grade, etc.
- `locales/`: Ce répertoire contient les fichiers de localisation pour les différentes langues prises en charge. Vous pouvez y ajouter les traductions nécessaires pour votre serveur.
- `sql.sql`: Ce fichier contient les requêtes SQL nécessaires pour créer les tables liées aux gangs dans la base de données.

## Configuration des sorties et entrées de véhicules

Il est important de noter que, dans les différentes configurations de gangs existantes (pariah, vagos, cartel, lost, etc.), rares sont ceux qui ont déjà une vraie position de sortie et d'entrée de véhicules définie dans leur fichier `config.lua` respectif. Vous devrez probablement ajouter ces positions manuellement en fonction des besoins spécifiques de votre serveur.

Pour ce faire, recherchez les fichiers de configuration de chaque gang dans votre serveur ESX (habituellement dans le dossier `esx_` correspondant au nom du gang). Cherchez des variables ou des tableaux qui ressemblent à ceci :

```lua
Config.GangStations = { -- Remplace 'GangStations' par la fonction qui ouvre le menu des actions du gang
  Gang = { -- Remplace 'Gang' par le nom du groupe criminel
    Vehicles = {
      {
        Spawner    = { x = 1117.752, y = -2277.266, z = 30.23565 },
        SpawnPoint = { x = 1112.389, y = -2286.195, z = 30.35929 },
        Heading    = 91.59446,
      }
    },
    VehicleDeleters = {
      { x = 1114.246, y = -2294.292, z = 30.54764 },
    }
  }
}
```

Modifiez les valeurs de `Spawner`, `SpawnPoint` et `Heading` pour définir la position d'apparition et de suppression des véhicules pour chaque gang.

## Crédits
Ce script a été créé par ChouCookieSan | Discord : .cookiesan / CookieSan#5805 pour CalicoCity. Vous pouvez me contacter pour toute question ou support supplémentaire.

N'hésitez pas à contribuer à ce projet en ouvrant des issues ou en proposant des pull requests pour améliorer la fonctionnalité des gangs dans ESX.