# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** module (`filter`) — Drupal enables it automatically as a
  dependency.
- The **`scrivo/highlight.php`** PHP library (`^9.17`), which is the PHP port of
  highlight.js. Installing the module with Composer pulls this in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/highlight_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and install the `scrivo/highlight.php` library alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/highlight_php -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en highlight_php -y
```

Enabling the module registers the filter and the Twig `|highlight` filter, but no
content is highlighted until you turn the filter on for a text format. See
[How to use it](../index.md#how-to-use-it) for the two-minute setup.
