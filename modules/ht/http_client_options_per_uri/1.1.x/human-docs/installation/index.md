# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other Drupal module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_options_per_uri -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_client_options_per_uri -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_options_per_uri -y
```

Enabling the module activates the middleware — no code changes are needed in the
modules that make outbound requests.

## Configure it

This module has no admin UI. All configuration is done in `settings.php` under
`$settings['http_client_options_per_uri_config']` — see the
[overview's "How to use it"](../index.md#how-to-use-it) section for the array shape,
matching rules, and examples.

## Verify it worked

Add a rule to `settings.php` that matches a host you can call, then trigger an
outbound request to it and confirm the option took effect (for example, a low
`timeout` causes a slow endpoint to fail fast for that host only, while other hosts
keep the default). Requests to hosts that don't match any rule behave exactly as
before.
