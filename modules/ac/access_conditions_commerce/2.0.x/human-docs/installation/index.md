# Installation

## Requirements

Access Conditions Commerce needs:

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **[Access Conditions](https://www.drupal.org/project/access_conditions)**
  (`access_conditions`) — provides the reusable access models the panes read.
- **[Drupal Commerce](https://www.drupal.org/project/commerce)** (`commerce`) —
  the checkout system whose panes this module replaces.
- **Condition Plugins Commerce** (`condition_plugins_commerce`) — supplies the
  Commerce-specific condition plugins (order total, product, etc.) you use inside
  access models.

Composer pulls all three in as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/access_conditions_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_conditions_commerce -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The project ships as a set of submodules, one per group of checkout panes. Enable
only the ones whose panes you need:

| Submodule | What it adds |
|-----------|--------------|
| **checkout** | Access-conditions variants of the *Login*, *Contact information*, *Billing information*, *Order summary* and *Review* panes. |
| **payment** | Variants of the *Payment information* and *Payment process* panes. |
| **promotion** | A variant of the *Coupon redemption* pane. |

Enable, for example, the checkout and payment panes:

```bash
drush en access_conditions_commerce_checkout access_conditions_commerce_payment -y
```

(Enabling any submodule pulls in the shared base module automatically.)

Once enabled, go to your Commerce checkout flow and place the new panes — see the
[main guide](../index.md#how-to-use-it).
