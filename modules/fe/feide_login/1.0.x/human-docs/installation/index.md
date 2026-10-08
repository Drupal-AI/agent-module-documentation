# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **External Authentication** module (`externalauth`) — used to map Feide
  users to Drupal accounts.
- The **Key** module (`key`) — used to hold your Feide client secret in an
  environment variable rather than in plain configuration.
- A registered **Feide application** (client ID and client secret) that you obtain
  from Feide/Dataporten. See [Configuration](../configuration/index.md).

Both module dependencies are pulled in automatically when you install with
Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/feide_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in `externalauth` and `key`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feide_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feide_login -y
```

This also enables `externalauth` and `key` if they are not already on.

## Verify it worked

Confirm the modules are enabled with `drush pm:list --status=enabled | grep -E
'feide_login|externalauth|key'`. The module is installed at this point, but users
cannot log in with Feide until you register a Feide application and enter its
credentials — continue to [Configuration](../configuration/index.md).
