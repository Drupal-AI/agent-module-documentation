# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- For **server-side tracking (CAPI)**: the **Facebook PHP Business SDK**, pulled
  in via Composer (see below).
- For **e-commerce events**: **Drupal Commerce**, required only if you enable the
  `meta_pixel_commerce` submodule.

There are no other required contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/meta_pixel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you plan to use the Conversions API, also require the
Facebook Business SDK so the server-side calls can be made:

```bash
composer require facebook/php-business-sdk
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meta_pixel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meta_pixel -y
```

## Submodules

Meta Pixel ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Meta Pixel Commerce** | `meta_pixel_commerce` | E-commerce event tracking for Drupal Commerce — ViewContent (product/variation views, including AJAX variation changes), AddToCart, InitiateCheckout, AddPaymentInfo, and Purchase. Requires Drupal Commerce. |

Enable it only if you run a Commerce store:

```bash
drush en meta_pixel_commerce -y
```

## Verify it worked

After enabling, head to the module's settings and connect your pixel/dataset (see
[Configuration](../configuration/index.md)). Once configured with consent granted,
load a page as an anonymous visitor and confirm the Pixel fires — the Meta Pixel
Helper browser extension or your browser's network tab will show the `fbq`
requests, and events should appear in your Meta Events Manager.
