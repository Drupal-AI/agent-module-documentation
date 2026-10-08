# Installation

## Requirements

Entity SOAP Client has several dependencies. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **PHP SOAP extension** enabled on your server.
- The **Key** module (`key`) — for secure credential storage.
- Core's **Views** (`views`).
- The **DX Toolkit** module (`dx_toolkit`).
- The **Feeds** (`feeds`) and **Feeds Enhanced** (`feeds_enhanced`) modules —
  used for the SOAP‑to‑Feeds import integration.
- Optionally, the **Webform** module if you want to use the Webform submodule.

Composer resolves the contributed module dependencies for you when you require the
project with `-W`. The PHP SOAP extension, however, must be present in your PHP
build — check with `php -m | grep -i soap`.

> **A note on status:** this is a **Beta** release intended for community testing
> and is **not** covered by Drupal's security advisory policy. Test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/soap_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
shared dependencies (Key, Views, DX Toolkit, Feeds, Feeds Enhanced) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soap_client -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

For the base module:

```bash
drush en soap_client -y
```

To enable the Webform integration submodule at the same time:

```bash
drush en soap_client soap_client_webform -y
```

## Verify it worked

Confirm the PHP SOAP extension is loaded (`php -m | grep -i soap`), then create a
**Key** for your SOAP service credentials and import a WSDL to generate your first
SOAP Service and Operation entities.
