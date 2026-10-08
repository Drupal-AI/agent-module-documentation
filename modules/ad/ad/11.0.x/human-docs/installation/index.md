# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third-party Composer or PHP library requirements.

This is an **alpha** release (11.0.0-alpha12) — the version number follows Drupal
core rather than the module's maturity. Test on a non-production environment
before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/ad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ad -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ad -y
```

Once enabled, you define your adverts and their placement as part of building out
your advertising setup — see the [main guide](../index.md#how-to-use-it). Before
running network ad scripts on an EU-facing site, add a consent-management module
(such as `usercentrics` or `consent_mode`).
