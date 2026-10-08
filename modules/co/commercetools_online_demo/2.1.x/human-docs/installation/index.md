# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **commercetools** suite — this project depends on:
  - `commercetools` (base integration)
  - `commercetools_demo` (demo accounts and content)
  - `commercetools_content` (coupled UI)
  - `commercetools_decoupled` (decoupled UI)
- Core **Content Translation** (`content_translation`) and **Locale** (`locale`),
  for the multi‑language demo.

All of these are enabled automatically as dependencies when you enable the demo.
This is a demo/showcase project and is **not for production**.

## Install with Composer

From the project root:

```bash
composer require drupal/commercetools_online_demo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, including the commercetools suite.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commercetools_online_demo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commercetools_online_demo -y
```

Enabling it also turns on the commercetools suite and the core translation modules
it depends on, and deploys the pre‑configured B2C Lifestyle demo store.

## Verify it worked

Visit the front end — you should see the demo storefront populated with products.
Log in with `admin` / `admin` to confirm the admin side works. To use your own
data, see the [overview](../index.md) for connecting a commercetools trial
account.
