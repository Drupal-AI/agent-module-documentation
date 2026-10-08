# Installation

## Requirements

- **Drupal 10.1, 11 or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **Drupal Commerce** — the `commerce` and `commerce_cart` modules (the only
  module dependencies).

There are no extra PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_addtocart_ajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_addtocart_ajax -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_addtocart_ajax -y
```

Once enabled, the add‑to‑cart form submits over AJAX. If your theme's messages
container is not the default `.status-messages`, set the correct selector — see
[Configuration](../configuration/index.md).

## Verify it worked

On your storefront, add a product to the cart. The page should **not** reload — you
should see a brief loading animation, a status message appear in your theme's
messages area, and the cart block update with the new item. If the status message
doesn't show, adjust the selector on the settings form. (Note: the AJAX cart
refresh replaces a visible **Cart** block, so place one in a region if your theme
doesn't already show it.)
