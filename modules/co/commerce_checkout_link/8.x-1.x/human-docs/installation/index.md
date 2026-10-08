# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **Commerce Order** (`commerce_order`) and **Commerce Cart** (`commerce_cart`)
  enabled — both ship with Drupal Commerce.
- A configured **site hash salt** (every Drupal site has one in `settings.php`);
  it is what keys the secure link signatures. You do not need to do anything
  special here — a standard Drupal install already has one.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_checkout_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_checkout_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_checkout_link -y
```

## Verify it worked

There is no settings page to check. To confirm the module works, have a developer
call `CheckoutLinkManager::generateUrl($order)` for an existing order (for example
from a custom controller, a Drush script, or `drush php:eval`), then open the
returned URL in a fresh browser session (logged out). You should land on the
checkout for that order without being asked to log in. Remember the link expires
after 24 hours by default, and should only be shared with the intended recipient
over HTTPS.
