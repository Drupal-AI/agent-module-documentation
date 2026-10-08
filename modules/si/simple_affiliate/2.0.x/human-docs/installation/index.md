# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules are required, and there are no third-party Composer or PHP
  library requirements. The module relies on core's user and Views subsystems, which
  are present on a standard site.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_affiliate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_affiliate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_affiliate -y
```

Enabling installs the referral field (`field_simple_affiliate_referrals`) on user
accounts, its storage, and the Simple Affiliate Dashboard View.

## After installing

There is no configuration form. Place the **Simple Affiliate** block at **Structure
→ Block layout** so members can find their personal affiliate link — see the main
guide's [How to use it](../index.md#how-to-use-it) section.
