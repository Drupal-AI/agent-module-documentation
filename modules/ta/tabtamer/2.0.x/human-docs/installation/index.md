# Installation

## Requirements

Tab Tamer is self‑contained:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tabtamer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tabtamer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tabtamer -y
```

There are no submodules. After enabling, grant the **Administer Tab Tamer**
permission to any role that should manage tabs (at **People → Permissions**).

## Verify it worked

Go to **Structure → Tab tamer** (`/admin/structure/tab-tamer`) — you should see the
Tab Tamer collection page. You should also notice an **Add tabtamer** tab appear on
pages as you browse the site (for users with the permission). Next, see
[Configuration](../configuration/index.md).
