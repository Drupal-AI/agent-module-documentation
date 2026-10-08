# Installation

## Requirements

Config import single is a Drush‑only helper. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drush 11.3 or newer** (`drush/drush: >=11.3`) — the command is provided through
  Drush, so this is a hard requirement.

There are no other module dependencies and no PHP library requirements beyond
Drush.

## Install with Composer

From the project root:

```bash
composer require drupal/config_import_single -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Drush, if your project is on an older version.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_import_single -W`, `ddev drush
> cis …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_import_single -y
```

Once enabled, the `cis` (`config_import_single:single-import`) command is
available. Confirm it's registered with:

```bash
drush cis --help
```

There is no configuration to set — see the module's
[overview page](../index.md#how-to-use-it) for how to run the command.
