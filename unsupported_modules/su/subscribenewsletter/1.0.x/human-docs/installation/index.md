# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- No module dependencies, and no PHP or third-party library requirements.

You will also need, from your email service provider, the **API endpoint URL** and
an **API key** to point the form at — configured after install.

## Install with Composer

From the project root:

```bash
composer require drupal/subscribenewsletter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subscribenewsletter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subscribenewsletter -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Newsletter → API**
(`/admin/config/newsletter/api`). You should reach the Subscribe Newsletter
settings form. The form is not useful yet — it needs your endpoint URL and API key
— so continue with [Configuration](../configuration/index.md).
