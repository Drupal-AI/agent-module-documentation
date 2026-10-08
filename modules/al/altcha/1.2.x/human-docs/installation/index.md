# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contrib **CAPTCHA** module (`drupal/captcha:^1.15 || ^2.0`), which ALTCHA
  depends on and Composer pulls in.
- The **`altcha-org/altcha`** PHP library (`^1.3.1`), pulled in by Composer, which
  performs the challenge signing and verification.
- The PHP **OpenSSL** extension (`ext-openssl`), used for the cryptographic
  operations.

## Install with Composer

From the project root:

```bash
composer require drupal/altcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the CAPTCHA module and the `altcha-org/altcha`
library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/altcha -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en altcha -y
```

Enabling ALTCHA also enables the CAPTCHA module as a dependency. On install, ALTCHA
generates the HMAC secret key it uses for self‑hosted verification, so the default
self‑hosted mode is ready immediately. Grant the **Administer ALTCHA** permission to
whoever manages the settings, then continue with
[Configuration](../configuration/index.md).

## Submodule — Obfuscate

An optional submodule reuses the ALTCHA proof‑of‑work to hide field values from
scrapers:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ALTCHA Obfuscate** | `altcha_obfuscate` | Field formatters that hide email addresses, phone numbers, or other strings behind a proof‑of‑work challenge until a visitor clicks to reveal them. |

```bash
drush en altcha_obfuscate -y
```

It requires the base ALTCHA module, which is already present once you have
installed it above.
