# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules are required. It works with core's theme system and the
  standard Appearance page.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/theme_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/theme_permission -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en theme_permission -y
```

There are no submodules. As soon as it is enabled, the module generates a pair of
per-theme permissions for every installed theme and takes over the Appearance
page. Nothing changes for roles until you assign those new permissions — see
[Configuration](../configuration/index.md).

> **Note:** granting someone the ability to install a theme is inherently powerful,
> since a theme can run its own code through templates and preprocess functions.
> Assign per-theme install rights only to trusted roles.
