# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- A long‑lived **Instagram API access token** for the account you want to import.
  You generate this through the Instagram API — see the module's configuration
  page and Instagram's developer documentation.
- Your server must be able to make outbound HTTPS requests to Instagram/Meta.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_sync -y
```

## Verify it worked

Go to **Configuration** and look for the **Instagram Sync** settings form. If it
opens, the module is installed. Continue to
[Configuration](../configuration/index.md) to paste your access token and run the
first import.
