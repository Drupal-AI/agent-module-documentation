# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3**.
- The **Key** module (`drupal/key`, `^1.20`) and the **ExternalAuth** module
  (`drupal/externalauth`, `^2.0`). Key stores the Auth0 secrets securely;
  ExternalAuth maps Auth0 identities to Drupal accounts. Both are pulled in by
  Composer and enabled as dependencies.
- Two PHP libraries, pulled in automatically by Composer:
  - **`auth0/auth0-php`** (`^8.3`) — the official Auth0 SDK.
  - **`php-http/guzzle7-adapter`** (`^1.0`) — the HTTP adapter the SDK uses.
- An **Auth0 tenant** with an Application (client ID + secret) you control.

## Install with Composer

From the project root:

```bash
composer require drupal/auth0 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Auth0 SDK,
the Guzzle adapter, Key, ExternalAuth, and update any shared dependencies as
needed. Because the SDK and adapter are real Composer requirements, install with
Composer rather than by copying files.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auth0 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auth0 -y
```

Drupal enables Key and ExternalAuth at the same time.

## Prepare your secrets

Before configuring the module, store the Auth0 **client secret** (and a **cookie
secret** for the SDK's session encryption) so they are not kept in plain
configuration. Following this project's conventions, keep the value in an
environment variable and create a Key entity that reads it — for example:

```bash
ddev dotenv set .ddev/.env --auth0-client-secret=<value>
ddev restart
ddev drush key:save auth0_client_secret --label='Auth0 Client Secret' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"AUTH0_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Never commit `.ddev/.env` or hard-code a secret.

## Next step

Connect your tenant and finish setup — continue to
[Configuration](../configuration/index.md).
