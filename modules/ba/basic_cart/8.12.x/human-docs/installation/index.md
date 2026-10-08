# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Telephone](https://www.drupal.org/docs/core-modules-and-themes)** core
  module (used by the order's phone field) — enabled automatically as a dependency.
- The **[Entity Reference Quantity](https://www.drupal.org/project/entity_reference_quantity)**
  module, which the order uses to reference the ordered products with quantities.
- The **[jQuery UI](https://www.drupal.org/project/jquery_ui)** library module, which
  Composer pulls in as a requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/basic_cart -W
```

This installs Basic Cart together with its required modules (Entity Reference
Quantity and jQuery UI). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basic_cart -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basic_cart -y
```

Or enable **Basic Cart** from *Extend* (`/admin/modules`). Drupal will enable
Telephone and Entity Reference Quantity at the same time if they aren't already on.

Enabling the module also installs the **Basic Cart Order** content type (with its
address/phone/email/message/total fields) and an orders View, ready to receive
orders.

There are no submodules. After enabling:

1. Go to **Configuration → Basic Cart → Settings** and choose which content types are
   buyable — see [Configuration](../configuration/index.md).
2. Grant the **Use cart** permission to the roles that should be able to shop.

## Optional: enable add‑to‑cart on existing content

If you enable a content type that already has nodes, those existing nodes won't have
the add‑to‑cart field switched on yet. You can turn it on for all of them at once
with the bundled Drush command:

```bash
drush basic-cart:enable-add-to-cart
# short alias:
drush baca-en
```

This processes every node of your enabled types in batches. (The same thing is
available as a bulk node action if you prefer the UI.)
