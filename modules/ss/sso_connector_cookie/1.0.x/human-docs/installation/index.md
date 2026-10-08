# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP with the OpenSSL extension** — used for the cookie encryption and signing.
- **SSO Connector** (`sso_connector`) `^1.0` — the core module of the suite.
- Core's **Help** module.
- Sites that share a **common parent domain** (for example `a.example.com` and
  `b.example.com` under `example.com`).

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector_cookie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector_cookie -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector_cookie -y
```

A random cookie key is seeded automatically on install so the module fails closed
rather than running without a key. For a real deployment, provision the encryption
and MAC key material in `settings.php` or State and keep it **identical across
every site** that shares the cookie.

## Part of the SSO Connector bundle

This is an optional submodule that requires **SSO Connector** (core). See the core
project for the full suite.

## Verify it worked

On two sites under the same parent domain, log in on one and confirm you are
recognised as logged in on the other without a fresh login, and that logging out
on one clears the shared session on both.
