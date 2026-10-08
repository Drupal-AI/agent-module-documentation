# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal **Commerce** (`commerce`) with **Commerce Checkout** (`commerce_checkout`)
  and **Commerce Shipping** (`commerce_shipping`) enabled.
- The **Profile** module (`profile`) — the billing profile supplies the recipient's
  name, email, and phone for the packet.
- The **PHP SOAP extension** — the module talks to Packeta over SOAP
  (`https://www.zasilkovna.cz/api/soap.wsdl`), which needs PHP's `SoapClient`.
- A **Packeta (Zásilkovna) account** with an API password and an e-shop identifier.
- **Products with a weight** — since 2021-09-01 Packeta's API requires a weight to
  submit a package.

The Views helper submodule additionally needs the **Views Bulk Edit**
(`views_bulk_edit`) module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_packeta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_packeta -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_packeta -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Commerce Packeta Views** | `commerce_packeta_views` | A product-variation View with a **Views Bulk Edit** bulk operation for setting product weights — handy because Packeta requires a weight on every packet. Requires the `views_bulk_edit` module. |

Enable it when you need it:

```bash
drush en commerce_packeta_views -y
```

## Verify it worked

Head to your shipping configuration and confirm that **Packeta** is available as a
shipping-method plugin. Then follow [Configuration](../configuration/index.md) to add
and set up the method, and run a test checkout to confirm the pickup-point selector
appears after entering a shipping address.
