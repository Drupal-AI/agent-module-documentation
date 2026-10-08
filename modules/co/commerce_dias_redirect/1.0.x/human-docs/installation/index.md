# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module — the gateway depends on
  `commerce` and `commerce_payment`, which are enabled automatically as
  dependencies.
- A **DIAS merchant agreement** with your Greek bank, which supplies the
  order‑registration and order‑status API URLs plus a merchant username and
  password.

There are no additional PHP libraries or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_dias_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_dias_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_dias_redirect -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If **DIAS Payment Redirect** appears in the list of
plugins, the module is installed correctly. From there, continue to
[Configuration](../configuration/index.md) to enter your DIAS API URLs and
credentials.
