# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`picqer/exact-php-client`** library, which does the actual talking to the Exact
  Online API. It is a Composer dependency and is installed automatically when you
  require the module.
- An Exact Online account and an Exact Online **application** (for the Client ID and
  Secret — see [Configuration](../configuration/index.md)).
- Outbound HTTPS access from your web server to the Exact Online API.

This project is an early release (1.0.0-alpha1) and is **not covered by Drupal's
security advisory policy** — evaluate it accordingly before using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/exact_online -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer install
the `picqer/exact-php-client` library and any shared dependencies at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exact_online -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exact_online -y
```

## Verify it worked

Log in as an administrator and open
**/admin/config/services/exact-online/settings**. If the settings form loads and asks
for a Client ID and Client Secret, the module (and the picqer library) installed
correctly. Continue to [Configuration](../configuration/index.md) to set up the
connection.
