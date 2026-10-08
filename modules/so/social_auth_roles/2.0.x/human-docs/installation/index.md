# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Social Auth** (`social_auth`) — this module extends its registration flow.
  Composer installs it automatically.
- At least one configured Social Auth provider, so that accounts actually get
  created through the social path.

There are no third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_roles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_roles -y
```

The Composer package name (`drupal/social_auth_roles`) and the module machine name
(`social_auth_roles`) match.

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) and choose the
roles to assign. To confirm the behaviour, complete a social signup with a test
account and check that the new user has the roles you selected — while a normally
registered account does not.
