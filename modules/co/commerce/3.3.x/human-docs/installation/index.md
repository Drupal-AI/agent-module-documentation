# Installation

## Requirements

Drupal Commerce needs **Drupal 10.3+ or 11** and **PHP 8.1 or newer** with the
**BCMath** extension (`ext-bcmath`) enabled — Commerce uses BCMath for exact
money arithmetic, so this is not optional.

Commerce is a **package of submodules** rather than a single module. Enabling it
pulls in a set of contrib dependencies, which Composer installs automatically:

- **Address** (`drupal/address`) — customer and store addresses, backed by the
  `commerceguys/addressing` library.
- **Entity API** (`drupal/entity`) — shared base classes for Commerce entities.
- **Entity Reference Revisions** (`drupal/entity_reference_revisions`) — used by
  order items and other revisioned references.
- **Inline Entity Form** (`drupal/inline_entity_form`) — embeds sub-forms such as
  product variations inside a parent form.
- **Profile** (`drupal/profile`) — customer profiles (billing/shipping).
- **State Machine** (`drupal/state_machine`) — drives order and payment
  workflows (draft → placed → fulfilled).
- **Token** (`drupal/token`) — placeholders used in number patterns, mail, etc.

It also relies on the **`commerceguys/intl`** library for currency-aware,
locale-aware price formatting, and on core's **Datetime** and **Views** modules.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Address, Entity, State Machine and other dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the pieces you need

Because Commerce is modular, you enable only the submodules your shop uses. A
typical starting set — base framework, products, cart, checkout and payment —
is:

```bash
drush en commerce commerce_product commerce_cart commerce_checkout commerce_payment -y
```

Enabling those submodules also brings in the ones they depend on
(`commerce_store`, `commerce_order`, `commerce_price`, and so on). Add
`commerce_tax` and `commerce_promotion` later when you need taxes or discounts.

## Verify it worked

Log in as an administrator and go to **Commerce → Configuration**
(`/admin/commerce/config`). You should see the Commerce configuration hub with
its grouped links (Store, Orders, Payment, …):

![The Commerce Configuration landing page](../images/config.png)

If that page loads and shows the configuration areas, Commerce is installed
correctly. Next, follow the [Configuration](../configuration/index.md) tour to
set up your first store.
