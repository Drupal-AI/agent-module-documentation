# Installation

## Requirements

AT Tool is a companion to the Adaptivetheme theme system, so it has one real
dependency beyond core:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Adaptivetheme** base theme (`drupal/adaptivetheme` `^7.0`), pulled in as a
  Composer requirement. AT Tool's features only come to life under an Adaptivetheme
  sub-theme.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/at_tool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in `drupal/adaptivetheme` if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/at_tool -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en at_tool -y
```

AT Tool has no submodules and no configuration of its own. After enabling it, make
sure your site is using an Adaptivetheme sub-theme (install the base theme with
Composer and build a sub-theme, or use one of the AT starterkits) and set the
sub-theme's developer/LiveReload/layout settings — that is what actually switches
AT Tool's features on. See [the overview](../index.md#how-to-use-it) for the theme
settings it reads.
