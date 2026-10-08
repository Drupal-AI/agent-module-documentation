# Installation

## Requirements

Configuration Partial Export is a small developer tool with minimal requirements:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on the module.
- **Drush** if you want to use the `config-partial-export` (`cpex`) command. The
  UI export tab works without Drush, but the CLI export needs it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_partial_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_partial_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_partial_export -y
```

## After enabling

There's nothing to configure. The module adds:

- A **Partial Export** tab under **Configuration → Development → Configuration
  synchronization → Export**, available to users with core's **Export
  configuration** permission. Grant that permission under **People →
  Permissions** to whoever needs to download partial exports.
- The **`config-partial-export`** Drush command (alias **`cpex`**).

See the [overview](../index.md#how-to-use-it) for how to use both.
