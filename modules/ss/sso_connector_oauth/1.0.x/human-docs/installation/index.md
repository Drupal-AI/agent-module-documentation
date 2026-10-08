# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **SSO Connector** (`sso_connector`) `^1.0` — provides the RS256 keypair used to
  sign tokens.
- Core's **User** and **Help** modules.
- **Optional:** the **Consumers** module, if you want to manage OAuth clients as
  entities rather than through this module's configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector_oauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector_oauth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector_oauth -y
```

Because this module signs tokens with the keypair from SSO Connector core, make
sure the core module's keypair is already provisioned (see the SSO Connector
installation guide).

## Part of the SSO Connector bundle

This is an optional submodule that requires **SSO Connector** (core). See the core
project for the full suite and the bundle architecture document.

## Verify it worked

Register a test OAuth client, then point an OAuth/OIDC client library at your
site's discovery document and run through the Authorization Code flow — you should
be shown the consent form, receive a code, and be able to exchange it for an RS256
access token at the token endpoint.
