# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 7.4 or newer**, with the **SOAP extension** (`ext-soap`) enabled — this is
  not present on every host. Check with:

  ```bash
  php -m | grep -i soap
  ```

- **Drupal Commerce** `^2.32 || ^3` with **Commerce Shipping** `~2 || ^3` — the
  module depends on `commerce_shipping`.
- The **`whatarmy/fedex-rest`** library, installed by Composer with the module.
- A **FedEx** shipping account (credentials from fedex.com).
- The **Commerce Physical** module's dimension/weight field types, so you can add
  those fields to products (see Configuration).

> This release is **2.0.0‑alpha2** — an alpha. Test it thoroughly before relying
> on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_fedex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in `whatarmy/fedex-rest`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_fedex -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_fedex -y
```

## Submodules — enable only if you need them

Both submodules cover consignments with **legally required declarations**, not
optional features. Enable them only if you actually ship these goods:

| Submodule | Machine name | For |
|-----------|--------------|-----|
| **Commerce FedEx Dangerous Goods** | `commerce_fedex_dangerous` | Hazardous‑materials shipments |
| **Commerce FedEx Dry Ice** | `commerce_fedex_dry_ice` | Dry‑ice shipments |

For example:

```bash
drush en commerce_fedex_dangerous -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Shipping → Shipping methods**
and add a shipping method; **FedEx** should be available as a plugin. Then continue
to [Configuration](../configuration/index.md) to add product weight/dimension
fields and enter your FedEx credentials.
