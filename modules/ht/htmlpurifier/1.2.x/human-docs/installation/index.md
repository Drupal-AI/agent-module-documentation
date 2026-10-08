# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 7.1 or newer** (`php: >=7.1`).
- Core's **Filter** module (`filter`) — part of any standard install, enabled
  automatically as a dependency.
- The **`ezyang/htmlpurifier`** PHP library (`^4.10`) — the actual sanitizer. It is
  a Composer requirement of the module, so Composer installs it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/htmlpurifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`ezyang/htmlpurifier` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htmlpurifier -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmlpurifier -y
```

Enabling the module makes the **HTML Purifier** filter available, but it is **off by
default** — it does nothing until you turn it on for a specific text format. See
[Configuration](../configuration/index.md) for enabling it, ordering it correctly,
and writing its directives.
