# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Domain** module (`domain`) — this is what defines the domains that each
  menu set is scoped to. Drupal enables it as a dependency.
- Core's **Menu UI** module (`menu_ui`), also enabled as a dependency.
- To make the **Edit assigned / active domain menus** permissions actually do
  anything, you need the **Domain Access** submodule (`domain_access`) enabled —
  that is what assigns domains to users. Without it, those permissions grant
  nothing beyond what "administer menus" already allows.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_menus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Domain module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_menus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_menus -y
```

## Submodule — Domain Menus Superfish

Domain Menus ships one optional submodule, **Domain Menus Superfish**
(`domain_menus_superfish`), which adds a Superfish-based drop-down block that
renders the active domain's menu. Enable it only if you want that Superfish
version (it requires the Superfish module):

```bash
drush en domain_menus_superfish -y
```

Once enabled, head to [Configuration](../configuration/index.md) to define your
menu names and create the per-domain menus.
