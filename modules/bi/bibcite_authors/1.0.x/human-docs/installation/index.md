# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Bibliography & Citation (Bibcite)** suite, since this formatter renders
  Bibcite reference author fields. Install and enable Bibcite first if you have
  not already (`composer require drupal/bibcite`).

There are no PHP library or additional Composer requirements declared by this
module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite_authors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite_authors -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibcite_authors -y
```

There is no configuration page. Once enabled, select the Bibcite Authors
formatter for the author field under **Manage display** — see the
[main guide](../index.md).
