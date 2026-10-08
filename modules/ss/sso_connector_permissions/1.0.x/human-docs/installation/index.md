# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP 8.1 or newer**.
- **SSO Connector** (`sso_connector`) `^1.0` — the core module of the suite.
- Core's **User**, **Serialization**, and **Help** modules.

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector_permissions -y
```

## Grant the administrative permissions carefully

This module ships three permissions that govern cross-site role assignment. Grant
them only to trusted administrators:

- `administer sso connector permissions` — define role mappings and overrides.
- `manage sso site registrations` — approve and manage SP registrations.
- `view sso permissions report` — view the effective-permissions report.

## Part of the SSO Connector bundle

This is an optional submodule that requires **SSO Connector** (core). See the core
project for the full suite.

## Verify it worked

On the IdP, register and approve a Service Provider site, define a role mapping,
and confirm from the permissions report that a test user resolves to the roles you
expect on that SP.
