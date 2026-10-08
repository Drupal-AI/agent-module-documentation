# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1 or newer**.
- The **Social Auth** module (`drupal/social_auth`, `^4.1`) and, through it, the
  **Social API** framework — these provide the login flow and account handling.
- The **`league/oauth2-google`** PHP library (`^4.0`), which the OAuth handshake
  uses.
- A **Google account** with access to the Google Cloud console, so you can
  create OAuth credentials.

Composer pulls in Social Auth and the `league/oauth2-google` library as
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_google -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Social Auth and the OAuth library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_google -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_google -y
```

This also enables the base Social Auth and Social API modules if they are not
already on.

## Next step

Before the Google login button will work, you need OAuth credentials from Google
and must enter them in the settings form — see
[Configuration](../configuration/index.md).
