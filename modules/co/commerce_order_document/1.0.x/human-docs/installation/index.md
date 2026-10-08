# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- **Commerce** (`commerce`) and **Commerce Order** (`commerce_order`) enabled —
  these are the module dependencies and are pulled in with Drupal Commerce.

There are no third‑party Composer libraries or special PHP extensions required.

> **Note:** This project is listed as **not covered** by Drupal's security
> advisory policy and is *seeking co-maintainer(s)*. Evaluate that before relying
> on it for a production store, and keep an eye on the project's issue queue.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_document -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_document -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_document -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Grant the permissions

This module adds the **administer order documents**
(`administer commerce_order document`) permission, which governs who may create and
edit the document configurations. The per-order **view / download / email** actions
are governed by the Commerce core **administer commerce_order** permission. Go to
**People → Permissions** (`/admin/people/permissions`), find these rows, and assign
them to trusted staff roles only — documents contain customers' personal and
financial details.

## Verify it worked

Open an existing order in the admin UI and confirm that the **Documents** tab (or
operation) is available, letting you view, download, or send an order document. To
configure document types, go to **Commerce → Configuration → Order documents**
(`/admin/commerce/config/order-documents`) and add one.
