# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1||^10||^11`).
- **Social API** (`social_api`) and **Social Auth** (`social_auth`) — the framework
  this plugin builds on. Composer installs both automatically as dependencies.
- A reachable **Keycloak** realm where you can register an OAuth client and obtain
  a client ID and secret.

There are no extra PHP library requirements listed for this module.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_keycloak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social API and Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_keycloak -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_keycloak -y
```

The Composer package name (`drupal/social_auth_keycloak`) and the module machine
name (`social_auth_keycloak`) match, so this is the name to use everywhere.

## Verify it worked

After enabling, add your Keycloak client ID and secret through Social Auth's
network settings, then visit the site's login page — a **Keycloak** button should
appear in the Social Auth login block (place that block if you have not already).
Clicking it should redirect you to your Keycloak realm to sign in.
