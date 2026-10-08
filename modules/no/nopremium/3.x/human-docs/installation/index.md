# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Node** module (`node`) — the only dependency.
- **Do not** install this module alongside the old *Premium* module; they overlap
  and should not be run together.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nopremium -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nopremium -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nopremium -y
```

## Verify it worked

Edit any node and look in the **Publishing options** — you should see a new
**Premium content** checkbox. Then visit **People → Permissions**
(`/admin/people/permissions`) and search for "premium"; you should see the
per‑content‑type *view full … premium content* and *override premium option*
permissions. Continue to [Configuration](../configuration/index.md) to set those
up.
