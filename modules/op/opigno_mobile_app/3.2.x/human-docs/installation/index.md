# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). This release does not
  declare Drupal 11 support.
- An existing **Opigno LMS** site — this module is the mobile backend for Opigno and
  is meant to be installed on top of it.
- A number of modules, which Composer pulls in as dependencies:
  - [JWT](https://www.drupal.org/project/jwt) (`jwt`) plus **`jwt_auth_consumer`**
    and **`jwt_auth_issuer`** — for issuing and consuming the JSON Web Tokens.
  - [Key](https://www.drupal.org/project/key) (`key`) — to store the JWT signing
    key as a managed secret.
  - [RESTui](https://www.drupal.org/project/restui) (`restui`) — a UI for managing
    REST resources.
  - Core **REST**, **HAL**, and **Serialization** modules.

## Install with Composer

From the project root:

```bash
composer require drupal/opigno_mobile_app -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the JWT, Key, RESTui, and related modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/opigno_mobile_app -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en opigno_mobile_app -y
```

Drupal enables the JWT, Key, RESTui, REST, HAL, and Serialization dependencies
automatically.

## Submodule — OneSignal push notifications

To send push notifications to the app, enable the bundled submodule (it needs
Opigno's notification module, `opigno_notification`):

```bash
drush en opigno_onesignal -y
```

## Set up the JWT signing key

Tokens are signed with a **Key** managed by the Key module rather than a hard-coded
secret. In **Configuration → System → Keys** (`/admin/config/system/keys`), make
sure a signing key exists for the JWT issuer, and store its value securely (for
example via an environment-variable key provider) rather than committing it. This
is what keeps issued JWTs trustworthy.

## Review access before going live

Before exposing the API to the internet, review the access rules on the user/group
listing endpoints — some are gated only by `_access: TRUE`, so anonymous callers can
reach a few of them. Confirm that is acceptable for your site's data. You can review
enabled REST resources through **RESTui** at
**Configuration → Web services → REST**.

## Verify it worked

With the module enabled and a signing key in place, the API is served under
`/api/v1/*`. A quick smoke test is to POST valid credentials to
`POST /api/v1/token` and confirm you receive a signed JWT back; the Opigno native
mobile app can then be pointed at your site's URL to authenticate and load content.
