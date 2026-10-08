# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (`system`) — part of core, always present.
- A **KonfHub account** and API credentials for the events you want to sync.
- The **Views** module (core) if you want to build reports over the ticket data —
  Views ships with core and is usually already enabled.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/konfhub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/konfhub -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en konfhub -y
```

## Verify it worked

Log in as an administrator and open the module's settings form (under
**Configuration**). If it loads and asks for your KonfHub credentials, the module
is installed — continue to [Configuration](../configuration/index.md) to enter
them and connect the webhook.
