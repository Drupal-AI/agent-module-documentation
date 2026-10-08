# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- **PHP 8.0 or newer** (`php_requirement: 8.0`).
- The **Metatag** module (`metatag`) — this is a hard dependency, since AGLS adds
  its tags to Metatag's system. Composer will pull it in for you.

There are no other third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/agls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Metatag — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/agls -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en agls -y
```

Enabling AGLS also enables Metatag if it is not already on. From there you
configure the AGLS tags through Metatag — see
[How to use it](../index.md#how-to-use-it) on the overview page.
