# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/email_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_token -y
```

## Verify it worked

Enabling the module alone does not change any output yet — you still need to turn
the filter on. Go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), configure a text format, and confirm
that **Email Token Filter** now appears in the **Enabled filters** list. Tick it,
save, then place `[etf:gin-email]` in a block or node using that format and view
the page — a "mail me" link should render. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough.
