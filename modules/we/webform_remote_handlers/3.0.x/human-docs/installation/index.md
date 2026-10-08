# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Webform** module (`drupal/webform`) — this is a hard dependency and the
  handlers appear inside Webform's own admin UI.
- For the SOAP handler, PHP's **SOAP extension** must be available on your server
  (the handler uses PHP's built‑in `SoapClient`).

There are no other third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_remote_handlers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
Webform module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webform_remote_handlers -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_remote_handlers -y
```

This also enables Webform if it isn't already on. There is no configuration step
at the module level — the **REST** and **SOAP** handlers become available to add
to any individual Webform (see [Configuration](../configuration/index.md)).

## Submodules

Webform Remote Handlers ships no submodules.

## A note on secrets

The handlers can hold endpoint passwords, HTTP Basic credentials, and OAuth2
client secrets. Don't hard‑code or commit these — store them in environment
variables and reference them from configuration, in line with this project's
secret‑handling practice.
