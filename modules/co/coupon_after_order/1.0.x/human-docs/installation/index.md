# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** (`commerce`) with its **Order**, **Price** and **Promotion**
  components (`commerce_order`, `commerce_price`, `commerce_promotion`).
- **State Machine** (`state_machine`) — Commerce's order-workflow engine, which this
  module uses to react when an order is placed.

Drupal enables these dependencies automatically when you turn on Coupon After Order,
and Composer installs the Commerce and State Machine packages for you.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/coupon_after_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce, State
Machine, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/coupon_after_order -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en coupon_after_order -y
```

## Verify it worked

1. Confirm Commerce and State Machine came along by checking the module list at
   **Extend** (`/admin/modules`).
2. Under **Commerce → Promotions**, make sure you have a coupon-bearing promotion
   with sensible limits (usage cap, expiry, single-use per customer) for the reward.
3. Grant the module's permission to the appropriate role under **People →
   Permissions**.
4. Place a test order and confirm a coupon is generated for that promotion and
   emailed to the customer.
