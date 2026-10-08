# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (always present) and core's **Media Library** module
  (`media_library`) — the only dependencies, both enabled automatically. Claro (core's
  admin theme) provides the styling the module borrows, and is present on every
  standard Drupal install.

There are no third‑party Composer or PHP library requirements.

> **Note:** the documented release is `2.0.0-beta1`, a **beta**. You may need to allow
> beta releases through your project's `minimum-stability` settings before Composer
> will install it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_theme_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_theme_reset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_theme_reset -y
```

That is the entire setup — there is no configuration, no permissions, and no
submodules. Open the Media Library in a front‑end context (for example inside Layout
Builder) and it should now render with proper Claro styling.
