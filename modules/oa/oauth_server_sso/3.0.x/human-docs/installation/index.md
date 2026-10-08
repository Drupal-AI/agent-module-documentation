# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements are declared by the module.
- A site served over **HTTPS**. Because this module issues login tokens for other
  applications, everything it does should travel over TLS in any real deployment.

## Install with Composer

From the project root:

```bash
composer require drupal/oauth_server_sso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oauth_server_sso -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oauth_server_sso -y
```

## Verify it worked

Log in as an administrator and open the module's setup screen (the
`oauth_server_sso.setup` route). If the OAuth Server configuration page loads, the
module is active and ready for you to register your first client application.
Continue with [Configuration](../configuration/index.md).

> **Keep it updated.** This module is your authorization server, so security fixes
> here are high‑impact. Make it part of your regular update routine.
