# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Commerce Cart** (`commerce_cart`) enabled — it ships with Drupal Commerce.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_skip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_cart_skip -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_skip -y
```

## Set the permission

Grant **`administer commerce cart skip rules`** under **People → Permissions**
(`/admin/people/permissions`) to the administrators who should create and manage
rules. This permission gates the entire rule‑management UI; there is no anonymous
access to it.

## Verify it worked

Log in as an administrator and open **Commerce → Configuration → Products →
Commerce Cart Skip** (`/admin/commerce/config/products/commerce_cart_skip`) — the
rules list should load with an option to add a rule. Create a test rule, visit a
product whose variation matches it, and confirm the add‑to‑cart step is replaced by
the buy‑now behaviour and that you land on the purchased confirmation page.

> **Note:** this module is minimally maintained and not covered by Drupal's
> security advisory policy. Test rule matching on staging before enabling in
> production.
