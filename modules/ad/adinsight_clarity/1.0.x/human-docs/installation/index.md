# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other modules are required — AdInsight / Clarity has no dependencies.
- A **Microsoft Clarity / AdInsight account** with a project set up, so you have a
  tracking (project) key to enter.

## Install with Composer

From the project root:

```bash
composer require drupal/adinsight_clarity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adinsight_clarity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adinsight_clarity -y
```

There are no submodules. Nothing is tracked until you enter your Clarity project
key on the module's settings form — see [Configuration](../configuration/index.md).
Make sure you have addressed consent and disclosure before you switch tracking on.
