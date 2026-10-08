# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A running **Go-WkhtmltoX service** that Drupal can reach over the network — this
  module is a *client*, so the rendering service itself must exist and be
  reachable. You will need its URL for the endpoint setting.

There are no other module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/go_wkhtmltox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/go_wkhtmltox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en go_wkhtmltox -y
```

## Set the endpoint

This module has no admin form — configure the service URL in `settings.php`:

```php
$config['go_wkhtmltox.settings']['endpoint'] = 'http://wkhtmltox:8080';
```

Keep the Go-WkhtmltoX service on a trusted/private network. See the
[overview page](../index.md) for the endpoint details and code examples.

## Verify it worked

With the module enabled and the endpoint set, run a small conversion from custom
code (see the example on the overview page) and confirm you get a valid PDF or
image back. If the call fails, check that the endpoint URL is correct and that the
service is reachable from the Drupal container.
