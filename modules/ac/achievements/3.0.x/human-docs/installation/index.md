# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- The module uses the jQuery UI **effects** and **dialog** libraries for its
  unlock animations and dialogs. On recent Drupal versions jQuery UI is no longer in
  core, so if you hit missing-library errors you may need the relevant jQuery UI
  contrib module(s) on your site.

## Install with Composer

From the project root:

```bash
composer require drupal/achievements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/achievements -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en achievements -y
```

Once enabled, open the settings form and start defining achievements — see
[Configuration](../configuration/index.md).
