# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Contextual** module (`contextual`) — Drupal enables it automatically as
  a dependency when you turn this module on.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/configure_contextual_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/configure_contextual_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en configure_contextual_links -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → User interface → Configure
Contextual Links** (`/admin/config/user-interface/configure-contextual-links`).
You should see a form listing the available contextual link plugins with
checkboxes to disable them. See [Configuration](../configuration/index.md) for how
to use it.
