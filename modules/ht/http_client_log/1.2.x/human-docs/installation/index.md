# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Options** module (`options`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

> **Where to run it:** this module lives in the "Development" package for a reason —
> it captures credentials and payloads (see [Configuration](../configuration/index.md)).
> Prefer local/staging environments, or enable it only briefly on production for a
> specific investigation.

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_client_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_log -y
```

## Verify it worked

Trigger any outbound request — for example run some code that calls
`\Drupal::httpClient()->get('https://httpbin.org/get')` — then log in as an
administrator and visit **`/admin/reports/http-client-log`**. The request you just
made should appear in the listing, and clicking it should show the full request and
response details.
