# Installation

## Requirements

- **Drupal 8, or 10.2+, or 11** (`core_version_requirement: ^8 || ^10.2 || ^11`).
- **Drupal Commerce** (`commerce`).
- **Simplenews** (`simplenews`) — the newsletter module this pane subscribes people to.

Both dependencies must be present; Composer will fetch them for you.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_simplenews_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_simplenews_checkout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_simplenews_checkout -y
```

## Verify it worked

Edit a checkout flow at **Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`). In the list of available panes you should now
see **Simplenews subscription** — drag it onto a step to add newsletter sign-up to your
checkout. See "How to use it" in the [overview](../index.md) for the full walkthrough.
