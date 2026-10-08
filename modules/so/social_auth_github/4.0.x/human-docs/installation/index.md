# Installation

## Requirements

Social Auth GitHub needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- The **Social Auth** module (`social_auth`), which builds on the Social API
  framework. Composer pulls this in for you.
- The **`league/oauth2-github`** OAuth2 client library, which Composer installs
  as a dependency of the module.

There are no PHP extension requirements beyond a standard Drupal install.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_github -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Social
Auth, Social API, and the `league/oauth2-github` library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_github -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_github -y
```

Drupal enables the Social Auth and Social API dependencies at the same time if
they are not already on.

## Next step

Login will not work until you register a GitHub OAuth application and enter its
credentials — continue to [Configuration](../configuration/index.md).
