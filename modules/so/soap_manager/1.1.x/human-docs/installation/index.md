# Installation

## Requirements

SOAP Manager needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **PHP SOAP extension** enabled on your server.
- Core's **Serialization** module (`serialization`), which ships with Drupal.

There are no third‑party Composer libraries.

> **A note on security coverage:** this project is **not** covered by Drupal's
> security advisory policy. Review it before exposing endpoints publicly.

## Install with Composer

From the project root:

```bash
composer require drupal/soap_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soap_manager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en soap_manager -y
```

Drupal will enable the Serialization dependency at the same time if it is not
already on.

## Verify it worked

Confirm the PHP SOAP extension is loaded (`php -m | grep -i soap`), then go to
**Configuration → Web services → SOAP Endpoints** — you should see the endpoint
management screen, ready for you to add your first endpoint (see
[Configuration](../configuration/index.md)).
