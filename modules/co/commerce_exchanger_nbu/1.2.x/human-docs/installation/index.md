# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Commerce Exchanger** (`commerce_exchanger`) — the module depends on it, and
  Drupal enables it automatically as a dependency. Commerce Exchanger in turn
  builds on Drupal Commerce.
- **UAH currency must be enabled.** Installation is blocked with an error unless
  the Ukrainian hryvnia (UAH) currency exists in Commerce, because UAH is the
  base currency for NBU rates. Add UAH under Commerce's currency settings first
  if it is not already present.

No API key or credentials are required — NBU exchange rates are fetched from a
public endpoint. There are no additional PHP libraries or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_exchanger_nbu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Commerce Exchanger.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_exchanger_nbu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_exchanger_nbu -y
```

## Verify it worked

Once enabled, **NBU** becomes available as an exchange‑rate provider inside
Commerce Exchanger. Open Commerce Exchanger's configuration and confirm you can
select NBU as a rate source — see "How to use it" on the
[overview page](../index.md).
