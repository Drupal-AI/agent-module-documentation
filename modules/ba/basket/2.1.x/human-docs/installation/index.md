# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer.**
- Core **Node**, **Token** and **Views**, which Drupal enables as dependencies.
- **`scss_compiler`** — a *separate contrib project*. Basket compiles its
  storefront styling from Sass at request time, so this module must be installed
  and working or the shop renders unstyled. Install it alongside Basket.

> **Heads‑up:** in the environment where these docs were produced, `drush en
> basket` failed on a bare Drupal 11.4 site — most likely because of the
> `scss_compiler` dependency and the store's own install prerequisites. Install
> and enable `scss_compiler` first, and expect to do some setup before the store
> comes up cleanly. Test on a non‑production environment.

## Install with Composer

From the project root:

```bash
composer require drupal/basket -W
```

Also require the SCSS compiler it depends on:

```bash
composer require drupal/scss_compiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basket -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scss_compiler -y
drush en basket -y
```

If enabling Basket fails, check that `scss_compiler` is enabled and working first,
then retry. Once the store is up, see [Configuration](../configuration/index.md)
for the order admin area and permissions.

## Adding payment and delivery

Payment gateways and carriers are separate companion modules — for example
**Basket PayPal** (`basket_paypal`) for PayPal payments, and a Nova Poshta
delivery module. Install and enable the ones you need after Basket is running.
