# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The PHP library **`web-auth/webauthn-lib`** (`^5.2`), used for WebAuthn /
  passkey support. Composer installs it automatically.
- **A miniOrange (Xecurify) account** — most methods delegate OTP
  challenge/verify to the miniOrange cloud, so you register an account from inside
  the module after installing. See [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/miniorange_2fa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install
`web-auth/webauthn-lib` and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/miniorange_2fa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en miniorange_2fa -y
```

## Optional submodules

miniOrange 2FA ships two submodules — enable only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **WebAuthn** | `miniorange_webauthn` | WebAuthn / passkey / security-key 2FA. |
| **Registration Verification** | `registration_verification` | OTP-verifies new user registrations (email/phone). |

For example:

```bash
drush en miniorange_webauthn -y
```

## Next: register and configure

Enabling the module does not enforce 2FA yet. You must first register a miniOrange
account and then turn on the policy. Continue to
[Configuration](../configuration/index.md).
