# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- PHP extensions **openssl**, **curl**, and **json** (openssl is needed to generate
  the RSA signing keys for OpenID Connect ID tokens).
- Two Composer libraries, installed automatically with the module:
  - `bshaffer/oauth2-server-php` (`~1.14`) — the underlying OAuth2 server library.
  - `bshaffer/oauth2-server-httpfoundation-bridge` (`~1.1`).

## Install with Composer

From the project root:

```bash
composer require drupal/oauth2_server -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies and
install the bshaffer libraries alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oauth2_server -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oauth2_server -y
```

## Serve over HTTPS

OAuth 2.0 relies on TLS — access tokens, authorization codes, and client secrets all
travel in requests to the endpoints. Only expose the OAuth endpoints over **HTTPS** in
production.

## A note on client secrets

When you register a client (see [Configuration](../configuration/index.md)), the
module stores its **client secret hashed** with Drupal's password hasher, so you do not
need to manage that value as an environment secret on the server side. On the *client
application's* side, however, treat its copy of the client secret like any other
credential: keep it in an environment variable rather than committing it to code or
configuration. Never paste real client secrets into files that are checked into
version control.

Once enabled, set up a server, scopes, and at least one client — see
[Configuration](../configuration/index.md).
