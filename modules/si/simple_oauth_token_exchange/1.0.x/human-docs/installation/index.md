# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Simple OAuth** module (`simple_oauth`) enabled — this module adds a grant
  type to it and does nothing on its own.

There are no third-party PHP or JavaScript library requirements. Note that the
current release is a release candidate (1.0.0-rc1), so test it before relying on
it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_token_exchange -W
```

The Composer package name (`drupal/simple_oauth_token_exchange`) matches the
module's machine name (`simple_oauth_token_exchange`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_token_exchange -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_token_exchange -y
```

Once enabled, the RFC 8693 token-exchange grant is available at Simple OAuth's
token endpoint. There is no configuration form; the important setup is on the
Simple OAuth side — your scopes and consumers — and granting the module's
permission only to clients that need it.

## Verify it worked

With a working Simple OAuth setup, have a client request the token-exchange grant,
passing an existing valid access token as the subject token and asking for a
narrower scope. If it receives a new token carrying the requested (and permitted)
scope, the grant is working.
