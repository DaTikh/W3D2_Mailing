# Week n°3 on Day n°2 - THP by Team BDX - Scrapping & Mailing & Twitter

## Objet du projet

Ce projet rentre dans le cadre du travail demandé lors du jour n°2 de la semaine n°3 du cursus THP. Il a pour but de travailler avec le langage Ruby, de manipuler les Gems et ce en mode "projet".

## Pré-requis

Pour faire fonctionner ce programme, veuillez cloner ce repo sur votre machine avec la commande suivante :

```
  $ git clone https://github.com/DaTikh/W3D2_Mailing
```

Ensuite, pour être sur d'avoir tous les outils nécessaires au fonctionnement du programme, effectuer une installation des Gems requises :

```
  $ bundle install
```

Si vous souhaitez l'envoi des mails, assurez-vous de renseigner dans un fichier .env en local et à la racine du repo les identifiants de votre compte Gmail, tel que :

```
  USERNAME=alice@bob.fr
  PASSWORD=XXXXXXXXXXXXX
```

Si vous souhaitez le search, add & follow sur Twitter, assurez-vous de renseigner dans un fichier .env en local et à la racine du repo les identifiants de votre compte Twitter, tel que :

```
TWITTER_CONSUMER            = " "
TWITTER_CONSUMER_SECRET     = " "
TWITTER_TOKEN               = " "
TWITTER_TOKEN_SECRET        = " "
```

## Fonctionnement du programme

Le programme possède plusieurs fonctions, qui sont appelées par une générale. Toutes les fonctions sont exhaustivement et chronologiquement telles que :

  - Scrapping des e-mails des mairies des villes des 3 départements depuis http://annuaire-des-mairies.com : les Landes (40 alias pays natal de baaaaaab), le Nord (59 alias le pays natal de Massimooooo) et la Gironde (33 alias notre pays d'adoption).

  - Mailing ou l'envoi vers chacune de ces adresses e-mails d'un message de promotion de The Hacking Project (liens vers le site et facebook inclus)

  - Twittering de chaque mairie ou la 2ème passe dans les cerveaux ! Recherche des "Handle" (ouais les pseudos quoi...) Twitter des comptes de chaque ville des départements cités plus haut et les follow.

  - **Perform_global.rb** qui permet de lancer toute la machine à bourrage de crâne !
    Scrapping + Mailing + Twittering (search & add + follow) = entrée + plat + dessert !

## Conditions de test du programme pour les corrections

**Compte-tenu des restrictions du nombre de requêtes à l'API Twitter (et au serveur de l'annuaire des mairies en fin d'après-midi... OUPS! On a tout pêté ! ;D) nous avons choisi de restreindre celles-ci sur un plus petit échantillon. Comme ça vous ne corrigerez pas les exos en perdant 20 minutes par méthode, tout en vérifiant le bon fonctionnement de celles-ci. ;)**

## Contributeurs

@bab - Baptiste ROGEON

@massimo - Maxime FLEURY

<p align="center">
  <img src="THP_BDX.png"/>
</p>
