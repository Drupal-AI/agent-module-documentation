# Installation

## Requirements

- **Drupal 11.3 or later** (`core_version_requirement: ^11`).
- **PHP 8.3 or later**.
- An **HTTPS‑enabled** website — required both for secure redirection to Nexi and
  for the server‑to‑server notify callback.
- A **Nexi XPay account** (required for production payments; Nexi also provides a
  test/sandbox environment).
- Core modules **Field**, **Options**, **System**, and **User** — enabled
  automatically as dependencies.

No external PHP libraries or SDKs are required.

## Install with Composer

From the project root:

```bash
composer require drupal/nexi_xpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nexi_xpay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nexi_xpay -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web Services → Nexi XPay**
(`/admin/config/services/nexi_xpay`). If the settings form loads, the module is
installed. Continue with [Configuration](../configuration/index.md) to enter your
Nexi environment and credentials before creating any transactions.
