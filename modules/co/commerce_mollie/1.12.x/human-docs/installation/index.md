# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: ^8.0`).
- **Drupal Commerce** (`drupal/commerce` `^2.40 || ^3.0`) with its **Commerce** and
  **Commerce Payment** modules enabled.
- The **Mollie PHP SDK** (`mollie/mollie-api-php` `~2.0`), installed automatically
  via Composer.
- A **Mollie account** with API keys (a `test_…` key and a `live_…` key).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_mollie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Mollie SDK and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_mollie -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_mollie -y
```

There are no submodules.

## Keep your Mollie API keys out of version control

The API keys are credentials. Rather than typing them into configuration that gets
exported and committed, set them per environment as environment variables and
reference them from `settings.php`. With DDEV, for example:

```bash
ddev dotenv set .ddev/.env --mollie-api-key-live=<value>
ddev restart
```

Then override the gateway configuration from `settings.php` using the environment
variable, so the live key never lands in exported config.

## Next steps

The module does not add a payment gateway automatically — you create one in
Commerce. See [Configuration](../configuration/index.md).
