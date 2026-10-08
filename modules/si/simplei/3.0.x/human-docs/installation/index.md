# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No dependencies beyond Drupal core, and no third‑party PHP libraries.
- To actually see the indicator, the user must be able to view Drupal's admin
  navigation: either core's **Navigation** module (the top bar) or the classic
  **Toolbar** module must be enabled, and the user must have permission to use it.

## Install with Composer

From the project root:

```bash
composer require drupal/simplei -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simplei -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplei -y
```

The module ships no submodules.

## Configure it (required to see anything)

Enabling the module alone shows nothing — you must add a line to `settings.php`.
For example:

```php
$settings['simple_environment_indicator'] = '@production';
```

See [Configuration](../configuration/index.md) for all the available formats and
options.

## Verify it worked

After adding the setting, log in as a user who can see the toolbar or navigation
and reload any page. You should see a colored environment badge in the top bar or
toolbar.
