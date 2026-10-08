# Installation

## Requirements

- **Drupal 11.3 or later** (`core_version_requirement: ^11.3`).
- No module dependencies beyond Drupal core, and no third‑party Composer packages
  or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/display_mode_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/display_mode_switcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en display_mode_switcher -y
```

No database updates are required — all configuration lives in YAML and can be
managed with Config Management (`drush config:export` / `config:import`).

## Verify it worked

After enabling, go to **Structure → Display modes → View modes → Switcher rules**
(`/admin/structure/display-modes/view/switcher`) and confirm the rules listing
loads with an **Add rule** button. From there, follow
[Configuration](../configuration/index.md) to build your first rule.
