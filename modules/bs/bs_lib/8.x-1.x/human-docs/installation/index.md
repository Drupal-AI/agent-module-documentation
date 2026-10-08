# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **`bs_base` theme installed first** — this is a hard prerequisite even though
  the module does not (and technically cannot) declare a theme dependency. Enabling
  BS Lib without `bs_base` breaks the entire Drush CLI (see the overview). Install
  and enable the theme before the module.
- No other module dependencies or third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/bs_lib -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bs_lib -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

**First** make sure the `bs_base` theme is installed and enabled. Then:

```bash
drush en bs_lib -y
```

Immediately verify the CLI still works:

```bash
drush status
```

If `drush status` fails with *"The theme bs_base does not exist."*, you enabled the
module without its theme. Because the uninstall command is itself a Drush command it
will also fail, so recover by installing/enabling `bs_base` — or, if necessary, by
removing `bs_lib` from `core.extension` with a direct database edit and clearing
caches. Do not install this module on a site that is not using the `bs_base` theme
family.
