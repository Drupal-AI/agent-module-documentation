# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Amazon Product Advertising API** account with a valid **access key**,
  **secret key**, and **partner (associate) tag**. Store the access and secret
  keys as secrets (env-backed), not in exported configuration.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/amazon_pa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amazon_pa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amazon_pa -y
```

## Submodules — enable only what you need

Amazon PAAPI5 ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Filter** | `amazon_pa_filter` | A text filter for turning product references into Amazon product output within formatted content. |
| **ASIN** | `asin` | Support for working with Amazon ASIN product identifiers. |

For example:

```bash
drush en amazon_pa_filter -y
```

Each submodule requires the base Amazon PAAPI5 module, which is already present
once you have installed it above.

## Next step

Enter your Amazon API credentials on the settings form — see
[Configuration](../configuration/index.md).
