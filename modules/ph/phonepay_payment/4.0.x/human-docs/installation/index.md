# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **[Drupal Commerce](https://www.drupal.org/project/commerce)** with its Payment
  functionality (`commerce_payment`) — this is a Commerce payment gateway, so
  Commerce must be installed and configured with a store, products and checkout.
- A **PhonePe merchant account** with API credentials (merchant id, salt key and
  salt index).
- A customer **profile type** (the default is `customer`) that includes an
  **address** field and a **mobile‑number** field with the machine name
  `field_mobile`.

## Install with Composer

From the project root:

```bash
composer require drupal/phonepay_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in any shared
dependencies as needed. (Install Drupal Commerce first if it is not already part of
your project.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phonepay_payment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phonepay_payment -y
```

## Prepare the customer profile type

Before you take payments, make sure the profile type you will use for checkout has
the fields PhonePe needs:

1. Go to **Configuration → People → Profile types** and manage the profile type
   (default: **Customer**, at
   `/admin/config/people/profile-types/manage/customer/fields`).
2. Confirm it has an **Address** field.
3. Add a phone/mobile field with the machine name **`field_mobile`** if it is not
   already present.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
(`/admin/commerce/config/payment-gateways/add`) and confirm **PhonePe** appears as
a gateway plugin you can add. Then head to
[Configuration](../configuration/index.md) to set up the gateway.
