# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.0 or newer**.
- Core's **User** and **System** modules (always present; enabled as dependencies).
- To add fields to your types you'll want core's **Field UI** module enabled (part
  of Drupal core). It isn't a hard dependency, but without it you cannot manage
  fields through the admin UI.

Two optional integrations, each only active if the other module is present:

- **Entity Browser** — the module ships an optional Entity Browser and browser View
  for selecting micro-content items.
- **Backfill Formatter** (`drupal/backfill_formatter`) — lets a reference field show
  a fallback/backfill value when a micro-content reference is empty.

## Install with Composer

From the project root:

```bash
composer require drupal/microcontent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/microcontent -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en microcontent -y
```

Once enabled, head to **Structure → Micro-content types** to create your first type.
See [Configuration](../configuration/index.md).

## Optional add-ons

To use the fallback-value integration, also install the Backfill Formatter module:

```bash
composer require drupal/backfill_formatter -W
drush en backfill_formatter -y
```
