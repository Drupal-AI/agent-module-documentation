# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- A valid **Conword customer ID**, which requires a contract with Conword GmbH —
  the integration cannot run without it.

There are no additional module dependencies or third‑party PHP/JavaScript library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/conword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conword -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conword -y
```

## Verify it worked

Go to **Configuration → Web services → Conword**
(`/admin/config/services/conword`). If you can open the settings form, the module
is installed. It is not active until you enter your customer ID — continue to
[Configuration](../configuration/index.md).
