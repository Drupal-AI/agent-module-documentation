# Installation

## Requirements

- **Drupal 9.1, 10, 11, or 12** (`core_version_requirement: ^9.1 || ^10 || ^11 || ^12`).
- Core's **Interface Translation** (`locale`) and **Language** (`language`)
  modules. Drupal enables these automatically as dependencies when you turn on
  Localization Plural Config.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/l10n_pconfig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/l10n_pconfig -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en l10n_pconfig -y
```

## Verify it worked

Go to **Configuration → Regional and language → Languages**, and edit any
language. You should now see the plural‑formula fields on the language edit form —
these are added by this module and are not present in a stock Drupal install.
