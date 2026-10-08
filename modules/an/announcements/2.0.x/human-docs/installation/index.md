# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Two module dependencies, which Composer pulls in for you:
  - **JS Cookie** (`js_cookie`) — provides the JavaScript cookie library used for
    remembering dismissals.
  - **Condition Field** (`condition_field`) — provides the display‑condition rules.

## Install with Composer

From the project root:

```bash
composer require drupal/announcements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in JS Cookie and Condition Field.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/announcements -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en announcements -y
```

Drupal enables the JS Cookie and Condition Field dependencies at the same time.
Once enabled, create your first announcement and set its display conditions (see
the [overview](../index.md#how-to-use-it)).
