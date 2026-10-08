# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal **Commerce** (`commerce`) with **Commerce Payment** (`commerce_payment`)
  enabled — these are the module dependencies.
- A **Payin-Payout** merchant account with an **API token** and an **agent (store)
  id**.
- A **phone-number field on the customer profile** — Payin-Payout requires a phone
  number, and you point the gateway at this field (see Configuration).

There are no third‑party Composer libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_payin_payout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_payin_payout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_payin_payout -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Add a phone field to the customer profile

Before you can use the gateway, make sure the **customer** profile type has a field
that stores a phone number. Add one at
`/admin/config/people/profile-types/manage/customer` (Manage fields) if it isn't
already there — you'll select it on the gateway form, and the gateway will error at
checkout if the selected field is missing.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**, click **Add payment
gateway**, and confirm that **Payin-Payout** appears in the plugin list. Then follow
[Configuration](../configuration/index.md).
