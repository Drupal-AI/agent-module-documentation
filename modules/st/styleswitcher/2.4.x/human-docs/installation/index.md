# Installation

## Requirements

Style Switcher is self-contained:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No other modules are required, and there are no PHP or third-party library
  dependencies.

(For reference, the release still carries the legacy `8.x-2.4` packaging string in
its `.info.yml`, which is normal for a project on this branch and does not affect
its Drupal 9/10/11 compatibility.)

## Install with Composer

From the project root:

```bash
composer require drupal/styleswitcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/styleswitcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en styleswitcher -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → User interface → Style
Switcher** (`/admin/config/user-interface/styleswitcher`). You should reach the
Style Switcher admin page, where you can begin defining alternate styles. Nothing
is shown to visitors yet — continue with [Configuration](../configuration/index.md)
to add styles and place the switcher block.
