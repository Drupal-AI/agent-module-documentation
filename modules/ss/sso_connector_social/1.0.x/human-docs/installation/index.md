# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP 8.1 or newer**.
- **SSO Connector** (`sso_connector`) `^1.0` — the core module of the suite.
- Core's **User**, **Block**, **Help**, **File**, and **Image** modules.
- The `firebase/php-jwt` library, pulled in automatically by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector_social -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector_social -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector_social -y
```

## Part of the SSO Connector bundle

This is an optional submodule that requires **SSO Connector** (core). See the core
project for the full suite.

## Verify it worked

Configure at least one provider (for example Google) with its client ID and
secret, place the social login block, then as an anonymous visitor click the
provider button and confirm you can sign in and that a Drupal account is linked.
