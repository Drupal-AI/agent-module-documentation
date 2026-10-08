# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce `^3.0`** — this release **pins Commerce 3** in its
  `composer.json`, so it will not install on a Commerce 2 site. It requires the
  Commerce modules `commerce`, `commerce_cart`, `commerce_checkout`,
  `commerce_order`, `commerce_price`, and `commerce_product`.
- **Registration `^3.4.2`** (`registration`) — the base
  [Registration](https://www.drupal.org/project/registration) module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in Commerce 3 and the Registration
module; if your site is still on Commerce 2, resolve that first.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_registration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_registration -y
```

## Submodules

Enable these only if you need what they add:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Waitlist** | `commerce_registration_waitlist` | Handles what happens when an event reaches capacity — attendees can join a waitlist and be promoted when a place frees up. |
| **Change Host** | `commerce_registration_change_host` | Lets a registration be moved to a different event or session (the "can I switch to the Thursday session?" case) without refunding and rebooking. Worth enabling proactively for anything with multiple sittings. |

For example:

```bash
drush en commerce_registration_waitlist commerce_registration_change_host -y
```

## Verify it worked

Open a Commerce product and confirm you can reach its registrations settings at
`/product/{commerce_product}/registrations/settings`. Then follow
[Configuration](../configuration/index.md) to make the product a registration host.
Also review the base Registration module's own README, which has important guidance
for configuring it to work well with Commerce.
