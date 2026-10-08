# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Chargebee account** with a site name, an API key, and at least one plan
  defined.
- The **Chargebee PHP library** (`chargebee/chargebee-php`), which the module uses
  to talk to the Chargebee API.
- Your server must be able to make outbound HTTPS requests to Chargebee.

## Install with Composer

From the project root, require the module. Using `-W` lets Composer bring in the
Chargebee PHP library and any other shared dependencies:

```bash
composer require drupal/integration_chargebee -W
```

If your setup does not pull the Chargebee client automatically, add it explicitly:

```bash
composer require chargebee/chargebee-php
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/integration_chargebee -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en integration_chargebee -y
```

## Verify it worked

Go to **Configuration → System → Chargebee** (`/admin/config/system/chargebee`).
If the settings page opens, the module is installed. Continue to
[Configuration](../configuration/index.md) to enter your Chargebee credentials and
import your plans.
