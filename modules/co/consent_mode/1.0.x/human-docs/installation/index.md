# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required.

**Plan to pair it.** This module only sets Consent Mode *defaults*; it does not
collect consent. You also need a consent banner / CMP that sends
`gtag('consent', 'update')` when the visitor chooses — otherwise the site denies
forever (see the [overview](../index.md)). This project is **not covered by
Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/consent_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consent_mode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consent_mode -y
```

Out of the box the module is active and declares **all six consent signals as
denied** by default.

## Verify it worked

Load a page and view its source (or use your browser's dev tools): near the top of
the `<head>` you should see a `gtag('consent', 'default', {...})` call with the
signals set to `denied`. To change the defaults or turn the script off, see
[Configuration](../configuration/index.md).
