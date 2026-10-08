# Installation

## Requirements

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Shortcut** module (`shortcut`) — this is the only dependency, and
  Drupal enables it automatically when you turn on Shortcut per Role.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/shortcutperrole -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/shortcutperrole -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shortcutperrole -y
```

Enabling it also pulls in core's Shortcut module if it is not already on. The
module ships no submodules.

## Verify it worked

Log in as an administrator and go to **Configuration → User interface →
Shortcuts → Shortcuts Per Role** (`/admin/config/user-interface/shortcut/roles`).
You should see a form listing every role with a shortcut‑set drop‑down. If you
have not created any shortcut sets yet, do that first under **Shortcuts**, then
return here to map them — see [Configuration](../configuration/index.md).
