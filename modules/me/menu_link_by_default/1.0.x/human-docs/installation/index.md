# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Menu UI** (`menu_ui`) and **Node** (`node`) modules — enabled
  automatically as dependencies when you turn this module on.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_by_default -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_by_default -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_by_default -y
```

## Verify it worked

Edit any content type at **Structure → Content types → *(type)* → Edit** and open
the **Menu settings** tab — you should see a new **Provide a menu link by default**
option. Tick it, save, then create a node of that type and confirm the "Provide a
menu link" checkbox starts out already ticked.
