# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Token** module (`token`) — Drupal will pull it in as a dependency.
- A reachable **Mautic** instance and, for API integration, its credentials
  (served over HTTPS).

> **Note:** the current release is a **beta** (`1.0.0-beta2`).

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_mautic_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in Token.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_mautic_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_mautic_integration -y
```

## Before you configure it

- Grant the module's permission on **People → Permissions** to the roles that
  should manage the integration.
- Have your Mautic **base URL** and **credentials** ready, and plan to store the
  credentials as **secrets** (environment variables / Key), not in committed
  config. See [Configuration](../configuration/index.md).
