# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2** or newer.
- The **Monolog** module (`monolog`) — a hard dependency.
- The **`logzio/monolog-handler`** (`logzio-monolog`) PHP library, which is
  pulled in automatically when you install this module with Composer.
- A **Logz.io account** with an active subscription, and a **log-shipping
  token** associated with that account.

Installing with Composer (below) is important here — it is what brings in both
the Monolog module and the `logzio-monolog` library.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog_logz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Monolog module and the `logzio-monolog` library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monolog_logz -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monolog_logz -y
```

Enabling the module registers the `monolog.handler.logz` service, but it does
**not** start shipping logs yet — you still need to add your Logz.io settings
and wire the handler into Monolog. See [Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep monolog_logz
```

Once configured (next page), trigger a log entry — for example with
`drush php:eval "\Drupal::logger('test')->error('Logz test');"` — and confirm it
appears in your Logz.io dashboard.
