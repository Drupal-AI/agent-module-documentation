# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Two Composer libraries, pulled in automatically:
  - **symfony/dotenv** (`^5.4 || ^6.0 || ^7.0`) — the component that parses `.env`.
  - **webflo/drupal-finder** (`^1.2`) — used to locate the Composer project root.

This module has no Drupal module dependencies of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/dotenv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Symfony
component and drupal‑finder and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dotenv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dotenv -y
```

There are no submodules. After enabling, run `drush dotenv:init` to scaffold the
`.env` integration, then read variables from `$_ENV` — see the
[main page](../index.md) for the full walkthrough.
