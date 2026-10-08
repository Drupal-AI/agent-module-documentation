# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Seers account** (from https://seers.com/) with a cookie consent banner
  configured — that's where you obtain the embed script / site identifier the
  module needs.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gdpr_ccpa_cookie_consent_seers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gdpr_ccpa_cookie_consent_seers -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gdpr_ccpa_cookie_consent_seers -y
```

## Verify it worked

Log in as an administrator and confirm the module appears as enabled on the
**Extend** page (`/admin/modules`). Then connect your Seers account (see
[Configuration](../configuration/index.md)) and load a front‑end page to confirm
the Seers banner appears.
