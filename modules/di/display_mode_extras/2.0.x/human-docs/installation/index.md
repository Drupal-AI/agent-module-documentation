# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No module dependencies, and no third‑party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/display_mode_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/display_mode_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en display_mode_extras -y
```

## Verify it worked

After enabling, go to **Structure → Display modes**
(`/admin/structure/display-modes/settings`) and confirm the settings form for
opting form modes into role‑based governance loads. Once you have marked a mode as
managed and cleared caches, its generated permission should appear on the
**People → Permissions** page.
