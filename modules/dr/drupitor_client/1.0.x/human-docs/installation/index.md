# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Composer-based Drupal installation** — the module works by running Composer
  on the server.
- PHP's **`proc_open()`** function must be available (it is often disabled in
  hardened shared-hosting environments).
- The **Composer executable** must be reachable on the system.
- Core's **System** and **User** modules (always present in Drupal core).

## Install with Composer

From the project root:

```bash
composer require drupal/drupitor_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupitor_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupitor_client -y
```

Enabling the module does **not** switch the API endpoint on. For security, the
endpoint starts in a disabled state and stays inert until you enable its
functionality and set an API token on the settings form — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Development → Drupitor Client**
(`/admin/config/development/drupitor-client`). If the settings form loads, the
module is installed. Follow the [Configuration](../configuration/index.md) guide
to enable the endpoint and set your token before the API becomes reachable.
