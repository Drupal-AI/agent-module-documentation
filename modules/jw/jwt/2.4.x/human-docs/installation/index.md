# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9.0 || ^10.0 || ^11.0`).
- **PHP 7.4 or newer**.
- The **`firebase/php-jwt` library** (`^5.5 | ^6.0 | ^7.0`) — Composer installs it for you.
- The **Key** module (`drupal/key`, `^1.3`) — pulled in automatically as a dependency; it
  provides the Key entities JWT signs with.
- For **RSA** (`RS256`) keys, PHP's **OpenSSL** extension (`ext-openssl`) must be enabled. HMAC
  keys do not need it.

## Install with Composer

Install with Composer so the `firebase/php-jwt` library and the Key module are pulled in
together. From the project root:

```bash
composer require drupal/jwt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install those dependencies and update
any shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/jwt -W`, `ddev drush …`. Inside the container (`ddev ssh`) run
> them without the prefix.

> **Install with Composer, not by hand.** A manual module copy will not fetch the
> `firebase/php-jwt` library, and the module cannot encode or decode tokens without it.

## Enable the base module

```bash
drush en jwt -y
```

Enabling the base module gives you the key framework, the token encode/decode service, and the
`jwt_auth` authentication provider — but on its own it neither issues nor validates tokens. For
that, enable the submodules below.

## Submodules — choose what you actually need

The base `jwt` module is a framework; the submodules do the real work of issuing and consuming
tokens. Enable the ones your use case calls for:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **JWT Authentication Consumer** | `jwt_auth_consumer` | *Validates* incoming tokens and resolves the Drupal user from a `drupal.uid` / `drupal.uuid` / `drupal.name` claim. Enable this to accept tokens. |
| **JWT Authentication Issuer** | `jwt_auth_issuer` | Exposes a `/jwt/token` endpoint that *mints* a token for the logged‑in user. Enable this to hand out tokens. |
| **JWT OAuth Client Credentials** | `jwt_oauth_ccf` | Machine‑to‑machine (client‑credentials‑grant) token issuance at `/oauth2/token`. |
| **JWT Path Auth** | `jwt_path_auth` | Accepts a JWT in a `?jwt=` query‑string parameter for whitelisted path prefixes (e.g. protected private files). |
| **Users JWT** | `users_jwt` | Per‑user RSA public keys instead of one site‑wide key. |

A common starter combination is the issuer plus the consumer:

```bash
drush en jwt_auth_issuer jwt_auth_consumer -y
```

Each submodule is documented separately under its own directory in this knowledge base.

## Verify it worked

Log in as an administrator and visit **Configuration → System → JSON Web Token Authentication**
(`/admin/config/system/jwt`). You should see the settings form asking you to select a signing
key. It won't work yet — that's expected until you create a Key and save this form, which is the
next step in [Configuration](../configuration/index.md).
