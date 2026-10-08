# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce core** — required for the module to work (it operates on
  Commerce product variations).
- The **Webform** module — required to be installed (it backs the optional Order
  Request submodule's functionality).

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_availability -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you plan to use the Order Request feature, make sure
the Webform module is installed too:

```bash
composer require drupal/webform -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_product_availability -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_availability -y
```

## Submodules

- **Commerce Product Availability Webform Request**
  (`commerce_product_availability_webform_request`) — adds an **"Order request"**
  button beside the Add to Cart button on product displays, linking the shopper to
  a webform (for example to request an order for a currently unavailable product).
  The button appears only on variations that have a Product Availability field set
  with **Webform Request** enabled in the field settings. Enable it when you want
  that flow:

  ```bash
  drush en commerce_product_availability_webform_request -y
  ```

## Verify it worked

Grant the module's permissions at **People → Permissions** to the appropriate
roles. Then go to **Commerce → Configuration → Product variation types → (a type)
→ Manage fields → Add field** and confirm a **Product Availability** field type
appears under the **Commerce** section. Continue to
[Configuration](../configuration/index.md).
