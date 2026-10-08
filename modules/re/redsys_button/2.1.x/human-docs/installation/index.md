# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The **[Key](https://www.drupal.org/project/key)** module, **1.22 or newer**
  (`key`) — a hard dependency used to store the merchant secret. Composer pulls it
  in for you.
- A **Redsys merchant account** and **HTTPS** in production.
- Optional: **Webform 6.3** for the `redsys_button_webform` submodule; **Drupal
  Commerce 3** for the `commerce_redsys_button` submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/redsys_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Key module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redsys_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redsys_button -y
```

Drupal enables the Key dependency automatically if it isn't already on.

## Submodules

Enable these only if you need them:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Commerce gateways** | `commerce_redsys_button` | Four off‑site Drupal Commerce payment gateways — Redsys **card**, **Bizum**, **PayPal**, and **xPay**. Credentials (merchant code, key, terminal) are configured **per gateway** at `/admin/commerce/config/payment-gateways`, not from the module's global settings. Supports EUR, USD, GBP. Requires Drupal Commerce 3. |
| **Webform handler** | `redsys_button_webform` | A `redsys_payment` Webform handler (Payment category). Add it under a webform's **Settings → Emails / Handlers**, then map the amount, email, description, and result elements. The submission stays a **draft** until a signed Redsys notification confirms payment. Requires Webform 6.3. |

```bash
# examples — enable only what you use
drush en commerce_redsys_button -y
drush en redsys_button_webform -y
```

## Upgrading from 1.x

If you're moving from a 1.x install, run database updates:

```bash
drush updb -y
```

The update installs the new `redsys_payment` and `redsys_payment_request` entity
storage, expands the payment‑method options (xPay), and **migrates your legacy
plaintext merchant key into a Key entity** (`redsys_button_legacy`, using the
configuration provider). Move that secret to a non‑config Key provider before
production. Legacy installs stay on `HMAC_SHA256_V1`.

## Verify it worked

Log in as an administrator and open **Configuration → System → Redsys settings**
(`/admin/config/system/redsys-settings`). The form should load. Then create a Key
for the merchant secret and complete the [Configuration](../configuration/index.md)
steps, testing against the Redsys **test** environment before switching to
production.
