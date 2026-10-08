# Installation

## Requirements

- **Drupal 10 or 11** (the module's `core_version_requirement` is `^10 || ^11`; the
  project notes compatibility back to core 9 as well).
- **PHP 8.3 or higher** — the code uses constructor property promotion and
  `array|false` union types.
- The PHP **openssl** extension (for RSA/ECDSA signing).
- The **Key** module (`key`, ^1.0) — stores and rotates the signing key material.
- Two Composer libraries, pulled in automatically when you require the module:
  **`lcobucci/jwt`** (^5.0, for creating and validating tokens) and
  **`symfony/clock`** (^6.0 || ^7.0, for time‑sensitive validation).

## Install with Composer

From the project root:

```bash
composer require drupal/jwt_authentication -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer
install `lcobucci/jwt`, `symfony/clock`, and the Key module alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jwt_authentication -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jwt_authentication -y
```

Or enable **JWT Authentication** on the **Extend** page (`/admin/modules`). The
Key module is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → System → JWT Authentication**
(`/admin/config/system/jwt-authentication`). If the settings form loads, the module
is installed. Next, follow [Configuration](../configuration/index.md) to create a
signing key and wire up the token flow — the endpoints won't issue usable tokens
until a key and algorithm are configured.

> **Heads up:** This release is not covered by Drupal's security advisory policy, so
> review it carefully before relying on it for production authentication.
