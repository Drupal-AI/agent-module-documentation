# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core **Block** — required to place list signup blocks.
- Core **REST** — required only if you want to use the provided REST endpoint.
- Core **Datetime** — if you use custom date fields.
- **Webform** — if you want to send webform submissions to an enabled list.
- A **SendPulse account** created on the developer portal, with an API user ID and
  secret.

There are no third‑party PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/sendpulse_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sendpulse_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sendpulse_api -y
```

Enable the core modules you need alongside it, for example:

```bash
drush en block rest -y
```

## After enabling

1. Add your SendPulse credentials (in `settings.php` or the admin UI) and authorize
   the connection — see [Configuration](../configuration/index.md).
2. Enable the lists you want, then place blocks / add webform handlers / add fields
   as needed.

## Verify it worked

Go to **Configuration → Web services → Sendpulse**
(`admin/config/services/sendpulse-api`). After saving valid credentials and
authorizing, the lists screen (`…/lists`) should show your SendPulse lists ready to
enable.
