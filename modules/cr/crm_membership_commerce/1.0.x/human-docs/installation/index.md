# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: >=11.1`).
- The following modules, which Composer installs as dependencies:
  - **CRM Membership** (`crm_membership`) — and, through it, the CRM project it depends
    on.
  - **Commerce Product** (`commerce_product`).
  - **Commerce Order** (`commerce_order`).
- No additional third‑party PHP libraries are required.

You will need a working Drupal Commerce store and at least one CRM Membership Type before
this integration has anything to act on.

## Install with Composer

From the project root:

```bash
composer require drupal/crm_membership_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update CRM
Membership, Commerce, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm_membership_commerce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crm_membership_commerce -y
```

Enabling the module also enables CRM Membership and the required Commerce modules if they
are not already on.

## Verify it worked

Because the module has no settings page, verify it by exercising the flow: create a CRM
Membership Type, set up a membership product variation with a reference to that type
(see "How to use it" on the [overview page](../index.md)), and place a test order. After
checkout completes, confirm a CRM membership was created or renewed for the customer. If
nothing happens, check the site logs at `/admin/reports/dblog` for warnings about
unresolved membership types or contacts.
