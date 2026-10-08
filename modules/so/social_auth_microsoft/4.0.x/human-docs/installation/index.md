# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- **Social Auth** (`social_auth ^4.1`) — the framework this plugin extends.
- The third-party library **`stevenmaguire/oauth2-microsoft ^2.0`**, which
  Composer installs for you.
- A **Microsoft / Azure** account where you can register an application and create
  a client secret.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_microsoft -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth and the OAuth2 Microsoft
library for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_microsoft -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_microsoft -y
```

The Composer package name (`drupal/social_auth_microsoft`) and the module machine
name (`social_auth_microsoft`) match.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to register the
Azure application and enter your credentials. Then place the Social Auth login
block (**Structure → Block Layout**) and confirm a **Microsoft** button appears on
the login page.
