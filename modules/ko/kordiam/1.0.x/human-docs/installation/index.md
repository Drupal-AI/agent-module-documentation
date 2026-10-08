# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Pathauto** (`pathauto`) — a contrib dependency — and core **Path** (`path`).
- A **Kordiam account** and API credentials.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/kordiam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pathauto and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kordiam -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kordiam -y
```

Enabling Kordiam will also enable Pathauto and core Path if they are not already
on.

## Verify it worked

Log in as an administrator and open the module's settings form (under
**Configuration**). If it loads and asks for your Kordiam API credentials, the
module is installed — continue to [Configuration](../configuration/index.md) to
enter them and grant the API permission.
