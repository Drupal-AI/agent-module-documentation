# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Language** module (`language`) — the only dependency. It is required for
  the multilingual front-page handling and is enabled automatically as a dependency.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/trailing_slash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/trailing_slash -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en trailing_slash -y
```

The module does nothing until you turn it on and choose which URLs to slash. See
[How to use it](../index.md#how-to-use-it) on the overview page for the settings
form, the path patterns, and the per-bundle options.
