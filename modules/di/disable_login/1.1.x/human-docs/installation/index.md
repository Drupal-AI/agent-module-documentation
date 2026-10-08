# Installation

## Requirements

Disable Login Page is self-contained:

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- No third-party Composer or PHP library requirements, and no other contrib
  modules. It only adds an access check to core's login routes.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/disable_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_login -y
```

**Important:** enabling the module does *not* block anything yet. It ships no
default configuration, so protection stays **off** until you visit the settings
form, turn it on, and set a secret. Go to
[Configuration](../configuration/index.md) to do that.

## Verify it worked

Log in as an administrator and open **Configuration → Security → Disable Login
Page** (`/admin/config/security/disable-login`). If the settings form loads, the
module is installed and ready to configure.
