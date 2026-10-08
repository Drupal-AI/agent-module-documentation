# Installation

## Requirements

Zammad for Helpdesk Integration is a plugin for the Helpdesk Integration framework:

- **Drupal 11.4 or 12** (`core_version_requirement: ^11.4 || ^12.0`).
- The **Helpdesk Integration** module
  ([`helpdesk_integration`](https://www.drupal.org/project/helpdesk_integration)) — a
  hard dependency that Composer pulls in for you.
- The **`zammad_api_client`** PHP library, which the module uses to talk to Zammad —
  Composer resolves it automatically as part of the require below.
- Access to a **Zammad instance** and an **API token** for it.

## Install with Composer

From the project root:

```bash
composer require drupal/helpdesk_zammad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies — including `helpdesk_integration` and the `zammad_api_client`
PHP library — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helpdesk_zammad -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helpdesk_zammad -y
```

Helpdesk Integration is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → Web services → Helpdesk**
(`/admin/config/services/helpdesk`) and create a new integration — **Zammad** should
now appear as an available platform. See [Configuration](../configuration/index.md)
to enter your Zammad URL and API token and confirm issues sync through to Zammad
tickets.
