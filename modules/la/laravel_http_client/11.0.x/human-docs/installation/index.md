# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- This is a **developer library** module — it is only useful if you (or another
  module) write code against it. There is no site‑builder feature to enable
  separately.

There are no additional contrib module dependencies. The Laravel HTTP Client
component (and its Guzzle dependency) is pulled in through Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/laravel_http_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Laravel HTTP
Client library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/laravel_http_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en laravel_http_client -y
```

There is no configuration to do — the `Http` service is now available to your
code.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`). The real
check is in code: from a custom controller or service, make a simple request such
as `Http::get('https://example.com')` and confirm you get a response back.
