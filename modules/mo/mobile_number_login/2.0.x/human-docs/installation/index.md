# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1||^11||^12`).
- Core authentication (always present) — the module builds on it.
- In practice you also need a working **SMS-sending / mobile-number layer** to
  deliver the one-time codes, along with an SMS gateway account. Set that up (and
  store its credentials as secrets) as part of configuration.

There are no additional PHP library requirements declared by the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/mobile_number_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mobile_number_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mobile_number_login -y
```

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to switch on
phone login and confirm the SMS/OTP path. Then test a login with a real mobile
number: you should receive a one-time code by SMS and be able to sign in with it.
