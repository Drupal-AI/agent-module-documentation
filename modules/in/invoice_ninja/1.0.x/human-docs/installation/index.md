# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **Invoice Ninja PHP SDK** (`invoiceninja/sdk`) Composer package — the
  module wraps this library to talk to Invoice Ninja, so it must be present.
- An **Invoice Ninja account** (hosted or self‑hosted) and an **API token**
  generated from it.

## Install with Composer

Requiring the module with the `-W` flag pulls in the Invoice Ninja SDK as a
dependency at the same time:

```bash
composer require drupal/invoice_ninja -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If the SDK is not pulled in automatically, add it
explicitly:

```bash
composer require invoiceninja/sdk
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/invoice_ninja -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en invoice_ninja -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Invoice Ninja**
(`/admin/config/system/invoice_ninja`). If the settings form loads, the module
and its SDK are installed correctly. Enter your Invoice Ninja URL and API token
there — see [Configuration](../configuration/index.md) — and then try a sync
(for example the `drush invoice_ninja:synchronize_users` command) to confirm the
connection works end to end.
