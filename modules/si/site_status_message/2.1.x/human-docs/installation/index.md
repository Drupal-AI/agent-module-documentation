# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required. The **Token** module is optional — install it if you
  want to use tokens in the banner text; without it the message is plain (but still
  configurable) text.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/site_status_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_status_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_status_message -y
```

## Verify it worked

Grant the **`administer site status message`** permission to the roles that should
manage the banner, then go to **Configuration → System → Site status message**
(`/admin/config/system/site-status-message`). Enter some text, tick **Enable message**,
choose a display scope, and save — then load a page in that scope to see the banner
appear at the top. See [Configuration](../configuration/index.md) for each option.
