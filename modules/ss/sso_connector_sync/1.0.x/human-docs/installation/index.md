# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP 8.1 or newer**.
- **SSO Connector** (`sso_connector`) `^1.0` — the core module of the suite.
- Core's **Serialization**, **REST**, **System**, and **Help** modules.

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector_sync -y
```

## Part of the SSO Connector bundle

This is an optional submodule that requires **SSO Connector** (core). See the core
project for the full suite.

## Verify it worked

Configure two peer sites with a shared HMAC signing key and the appropriate
direction, then save a content entity on one and confirm it replicates to the
other. Remember that user and configuration sync are off by default and must be
enabled explicitly.
