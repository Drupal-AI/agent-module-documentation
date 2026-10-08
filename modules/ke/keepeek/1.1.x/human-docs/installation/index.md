# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- These core modules, enabled as dependencies: **Media** (`media`), **Media
  Library** (`media_library`), and **Responsive Image** (`responsive_image`).
- A **Keepeek account**, and — importantly — your **Drupal module account enabled
  by the Keepeek team**. Contact Keepeek to have the integration activated before
  you configure it.
- **Keepeek API credentials** for the connection.

## Install with Composer

From the project root:

```bash
composer require drupal/keepeek -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/keepeek -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keepeek -y
```

Or enable **Keepeek** on the **Extend** page (`/admin/modules`).

## Verify it worked

Go to **Configuration → Keepeek**. If the settings form loads, the module is
installed. Enter your Keepeek connection details (see
[Configuration](../configuration/index.md)), then create a Keepeek media type and
confirm you can browse your Keepeek library from the Media Library.
