# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`pragmarx/google2fa`** PHP library, used to generate secrets and validate
  OTPs. It is pulled in automatically by Composer when you require the module — no
  separate step needed.

There are no contributed module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/otp_service -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `google2fa`
library alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/otp_service -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en otp_service -y
```

## Verify it worked

After enabling, the module's OTP‑setup block should be available in **Structure →
Block layout** (look for the OTP secret‑setup block), and the validation form at
`/otp/validation` should exist (gated by the **use otp_service form** permission).
See [Configuration](../configuration/index.md) to place the block and wire things
up.
