# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce Cart** (`commerce_cart`) enabled — it ships with Drupal Commerce.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_cart_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_links -y
```

## Set the permissions

Cart links only work for users who hold the right permissions, so this step is
part of getting the module running, not optional polish. Under **People →
Permissions** (`/admin/people/permissions`) grant:

- **`view commerce cart links`** — required for anyone (usually the **anonymous**
  and **authenticated** roles) to follow a `/cart-links` URL at all.
- **`generate cart share links`** — for users who should be able to open the
  share‑cart modal and create a link to their own basket.
- **`administer commerce_cart_links`** — restricted; grant only to administrators
  who manage the settings form.

## Verify it worked

Log in as an administrator and open **Commerce → Configuration → Orders → Cart
Links** (`/admin/commerce/config/orders/cart-links`) — the settings form should
load. Then build a simple test link such as `/cart-links/{variation-id}-1` (using
a real product variation id) and follow it; the product should be added to your
cart. If you get a 403, check the referer configuration and the `view commerce
cart links` permission — see [Configuration](../configuration/index.md).
