# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- **Social Auth** (`social_auth`) — the framework this plugin builds on. Composer
  installs it (and Social API) automatically.
- A reachable **Nextcloud** instance where you can register an OAuth client and
  obtain a client ID and secret.

There are no extra PHP library requirements listed for this module.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_nextcloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_nextcloud -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_nextcloud -y
```

The Composer package name (`drupal/social_auth_nextcloud`) and the module machine
name (`social_auth_nextcloud`) match.

## Verify it worked

After enabling, register an OAuth client on your Nextcloud instance and enter its
client ID and secret through Social Auth's network settings. Then place the Social
Auth login block (**Structure → Block Layout**) and confirm a **Nextcloud** button
appears on the login page and redirects you to your Nextcloud instance to sign in.
