# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10 || ^11`; the Composer
  constraint is `drupal/core:^10.1 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- **[TFA](https://www.drupal.org/project/tfa) 1.4 or newer** (`drupal/tfa:^1.4`) —
  this module is a plugin for it.
- **[Encrypt](https://www.drupal.org/project/encrypt) 3.1 or newer**
  (`drupal/encrypt:^3.1`) — used to encrypt the one-time codes at rest.

Composer installs TFA and Encrypt for you. Before the email factor can work you must
also complete the normal TFA setup, which includes selecting an **encryption
profile** — the same profile is used to encrypt the OTPs.

## Install with Composer

From the project root:

```bash
composer require drupal/tfa_email_otp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tfa_email_otp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tfa_email_otp -y
```

Drupal enables `tfa` and `encrypt` as dependencies. If you are upgrading from a site
that used the legacy `tfa_email_code` plugin, the install step automatically renames
those references to `tfa_email_otp` and keeps migrated users enabled — no action
needed on a fresh install.

Next, allow and configure the plugin on the TFA settings page — see
[Configuration](../configuration/index.md).
