# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **User** module (`user`) — always present on a Drupal site; this is the only
  dependency.

There are no third-party Composer or PHP library requirements. This module is part of
the **LocalGov Drupal** distribution but works on any site.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_login_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_login_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_login_redirect -y
```

## Verify it worked

Go to **Configuration → System → LocalGov Login Redirect**
(`/admin/config/system/localgov_login_redirect`) and confirm the settings form is
present. Set your destination (see [Configuration](../configuration/index.md)), then
log out and log back in — you should land on the page you chose rather than your user
profile.
