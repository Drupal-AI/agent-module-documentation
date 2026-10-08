# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher**.
- Core **User**, **System**, **Node**, and **Comment** (dependencies; Drupal
  enables them as needed).
- **Drupal Commerce** — *optional*, but required if you want e‑commerce
  order/transaction fraud checks.
- A **SensFRX account** (a free plan with 500 API credits/month is available). Sign
  up at `https://client.sensfrx.ai/signup`; after signup you receive a **Property
  ID** and **Property Secret Key**, which the module needs to connect.

> Note that on a site **without** Drupal Commerce Payment, the shipped code can
> fatal and its routes may fail to register.

## Install with Composer

From the project root:

```bash
composer require drupal/sensfrx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sensfrx -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sensfrx -y
```

After enabling, you are redirected automatically to the SensFRX setup screen at
**Administration → SensFRX → Setup**.

## Verify it worked

Complete the setup step (see [Configuration](../configuration/index.md)). Once your
account is connected, the **Administration → SensFRX → Dashboard** should load and
begin showing activity and risk data.
