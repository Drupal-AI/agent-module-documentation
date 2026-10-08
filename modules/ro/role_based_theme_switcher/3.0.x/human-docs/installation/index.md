# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- At least one extra theme installed besides your default, so you have something to
  assign per role. Install themes under **Appearance** as usual.

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/role_based_theme_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_based_theme_switcher -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_based_theme_switcher -y
```

After enabling, go to **Configuration → System → Role Based Theme Switcher →
Settings** to map roles to themes — see [Configuration](../configuration/index.md).
Nothing changes for visitors until you assign at least one role a theme and save.
