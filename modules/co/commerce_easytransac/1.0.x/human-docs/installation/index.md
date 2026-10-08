# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module (`commerce_payment`) and the
  **Address** module (`address`) — both enabled automatically as dependencies.
- The **`easytransac/easytransac` PHP SDK**, which Composer installs when you
  require the module (install the module with Composer so the SDK comes with it;
  otherwise you must add the SDK to your `vendor` folder manually).
- An **EasyTransac** account with an application/API key.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_easytransac -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the EasyTransac SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_easytransac -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_easytransac -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If **EasyTransac** (and the Pay by bank variant) appear
in the list of plugins, the module is installed correctly. Continue to
[Configuration](../configuration/index.md) to enter your API key and notification
URL.
