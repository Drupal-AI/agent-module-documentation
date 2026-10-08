# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- An **eTracker account** (a paid service) with an account ID.
- For consent gating: the **COOKiES** consent module, if you enable the
  `cookies_etracker` submodule.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/etracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/etracker -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en etracker -y
```

## Optional: consent integration submodule

If you use the **COOKiES** consent module and want eTracker gated behind consent
(recommended), enable the bundled submodule:

```bash
drush en cookies_etracker -y
```

## Verify it worked

Go to **Configuration → System → eTracker** (`/admin/config/system/etracker`),
enter your account ID (see [Configuration](../configuration/index.md)), then view a
front‑end page's HTML source in your browser — you should see the eTracker tracking
JavaScript in the configured scope. If you enabled the consent submodule, the script
should only load after the visitor consents.
