# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- An **Amazon Product Advertising API** account with a valid **access key**,
  **secret key**, and **partner (associate) tag**. Store the access and secret
  keys as secrets (env-backed or a Key entity), not in committed configuration.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/amazon_paapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amazon_paapi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amazon_paapi -y
```

After enabling, provide your Amazon PA-API credentials and partner tag through
environment variables so the client can sign its requests. Because it is a
helper client, the value comes from the module or custom code that uses it.
