# Installation

## Requirements

- **Drupal 9.3+, 10.1+, or 11** (`core_version_requirement: ^9.3 || ^10.1 ||
  ^11`).
- The **Translation Management Tool** (`drupal/tmgmt`, `~1.14`) — this module
  extends it.
- TMGMT's **File translator** submodule (`tmgmt_file`) and core's
  **Serialization** (`serialization`) module — both are dependencies.

There are no third-party PHP library requirements, and the module defines no
permissions of its own (it uses TMGMT's **Administer tmgmt**).

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_extension_suit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install TMGMT and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tmgmt_extension_suit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_extension_suit -y
```

This enables `tmgmt`, `tmgmt_file`, and `serialization` if they are not already
on.

> The project also ships a hidden test submodule
> (`tmgmt_extension_suit_test`). It exists only for automated tests — do not
> enable it on a real site.

## After enabling

- Make sure Drupal **cron** runs regularly — the bulk upload and download queues
  are processed on cron.
- Set up at least one TMGMT translator. The queue and track-changes features only
  apply to translators whose plugin implements the extended interface (see the
  [`agent/`](../agent/start.md) docs on the translator plugin).
- Visit the settings form to turn on track changes — see
  [Configuration](../configuration/index.md).
