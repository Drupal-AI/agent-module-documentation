# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drupal Commerce** with the **Payment** module — the gateway depends on
  `commerce_payment`, which is enabled automatically as a dependency.
- A **Nets Easy (Nexi)** merchant account and its API keys.

There are no additional PHP libraries or Composer requirements. Note that this is
a development release — review it before using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_easy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_easy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_easy -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If the Nets Easy plugin appears in the list, the module
is installed correctly. Continue to [Configuration](../configuration/index.md) to
enter your Nets Easy credentials.
