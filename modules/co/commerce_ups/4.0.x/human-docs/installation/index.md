# Installation

## Requirements

Commerce UPS needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- **Drupal Commerce Shipping** (`drupal/commerce_shipping` `^2.0 || ^3.0`) — the
  framework that shipping methods plug into. This in turn requires Drupal
  Commerce itself.
- The **`sainsburys/guzzle-oauth2-plugin`** library (`^3.0`), which handles the
  OAuth2 client-credentials authentication to UPS. Composer pulls it in
  automatically.

You will also need a **UPS developer account** with an application that gives you
a **Client ID** and **Client Secret**, plus your UPS **account number**. These
are entered in the shipping method configuration, not during installation.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ups -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required Commerce Shipping and OAuth2 library dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_ups -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ups -y
```

This also enables Commerce Shipping if it wasn't already on.

## Keeping credentials out of exported config

Your UPS credentials are stored on the shipping method configuration entity,
which means they can end up in exported configuration. To keep the secret out of
version control, override it per environment in `settings.php` — for example:

```php
$config['commerce_shipping.commerce_shipping_method.<id>']['plugin']['configuration']['api_information']['secret'] = getenv('UPS_CLIENT_SECRET');
```

Store the value itself in an environment variable rather than hard-coding it.

## Next steps

Add a shipping method and configure UPS — see
[Configuration](../configuration/index.md).
