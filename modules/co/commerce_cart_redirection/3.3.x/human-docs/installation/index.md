# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** — specifically the **Commerce** (`commerce`) and
  **Commerce Product** (`commerce_product`) modules. These are required
  dependencies; the redirect works on Commerce's add‑to‑cart flow.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_redirection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have Commerce installed, requiring
this module will bring the needed Commerce packages in as dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_cart_redirection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_redirection -y
```

Enabling it also pulls in the Commerce and Commerce Product modules if they are
not already on. The module ships no submodules.

## Verify it worked

Log in as an administrator and go to **Commerce → Configuration → Orders → Cart
redirection** (`/admin/commerce/config/commerce_cart_redirection`). You should see
the settings form. Nothing is redirected until you configure it there — see
[Configuration](../configuration/index.md).
