# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- An **OAuth 2.0 / OpenID Connect** identity provider you can register an
  application with (Entra ID / Azure AD, Keycloak, Okta, Google, Cognito, or any
  compliant server).
- Your site should be served over **HTTPS** so the OAuth callback is secure.

There are no module dependencies, no third-party Composer packages, and no
submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/oauth_login_oauth2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oauth_login_oauth2 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oauth_login_oauth2 -y
```

There are no module-specific permissions — the admin pages use core's *Administer
site configuration* permission, so administrators can reach them immediately.
Continue with [Configuration](../configuration/index.md).
