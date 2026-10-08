# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **SSO Connector** (`sso_connector`) `^1.0` — the core module of the suite.
- The contributed **Autologout** module (`autologout`) `^1.0` — required.
- Core's **Help** module.
- **Recommended:** **SSO Connector Cookie** (`sso_connector_cookie`), which
  provides the cryptographically validated SSO session this module checks. Without
  it, the module falls back to the contributed Autologout timeouts unchanged.

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector_autologout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector_autologout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector_autologout -y
```

Drupal enables the SSO Connector, Autologout, and Help dependencies as part of
turning this module on.

## Part of the SSO Connector bundle

This is an optional submodule that requires **SSO Connector** (core). See the core
project for the full suite and how the pieces fit together.

## Verify it worked

With the module enabled and an SSO session in place, confirm that a user who is
active on another site in the SSO network is *not* logged out here, while a
genuinely idle user still is logged out at the Autologout timeout.
