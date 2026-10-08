# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the project supports
  core 8.8+ generally).
- The **Monolog** library, version 2.3 or newer — installed automatically with the
  module via Composer.

There are no other Drupal module dependencies.

> **Development only:** this module logs credentials and payloads without redaction
> (see [Configuration](../configuration/index.md)). Install it on local/staging
> environments and never leave it enabled on production.

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_client_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_logger -y
```

## Verify it worked

Trigger an outbound request (for example run code that calls
`\Drupal::httpClient()->get(...)`), then check your Drupal log — with core's
Database Logging enabled that is **Reports → Recent log messages**
(`/admin/reports/dblog`). You should see the request and response recorded. Then
visit the settings form at
**`/admin/config/development/logging/http_client`** to adjust what is captured.
