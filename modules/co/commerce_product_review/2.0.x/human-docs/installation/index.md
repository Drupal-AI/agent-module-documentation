# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** with its **Commerce Product** (`commerce_product`) and
  **Commerce Price** (`commerce_price`) submodules — both are hard dependencies.
- The **rateit.js** JavaScript library, required if you want ratings shown as stars
  (both the rating display and the rating form). See below.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_review -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_review -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the rateit.js library

Star display and the star rating form need the external **rateit.js** library. There
are two ways to install it.

**With Composer (recommended).** First allow your project to install JavaScript
libraries via [Asset Packagist](https://asset-packagist.org). In your project's
`composer.json`, add the repository:

```json
"repositories": [
    {
        "type": "composer",
        "url": "https://asset-packagist.org"
    }
]
```

and configure where libraries are installed (merge with any existing `extra`
entries):

```json
"extra": {
    "installer-types": ["bower-asset", "npm-asset"],
    "installer-paths": {
        "web/libraries/{$name}": ["type:drupal-library", "type:bower-asset", "type:npm-asset"]
    }
}
```

Then require the library:

```bash
composer require "npm-asset/jquery.rateit"
```

**Manually.** Download rateit.js and extract it under your `libraries` directory so
that its files live at `libraries/jquery.rateit/scripts`.

Either way, the library must end up at `libraries/jquery.rateit/scripts` for the
star widgets and formatters to work. If you only ever display ratings as numbers,
you can skip the library.

## Enable the module

```bash
drush en commerce_product_review -y
```

## Verify it worked

Go to **Commerce → Configuration → Product review types**
(`/admin/commerce/config/product-review-types`) — you should see the **default**
review type. After configuring it (see [Configuration](../configuration/index.md))
and enabling the "Overall rating" field on your product display, visit a product as
a logged-in customer and confirm you can add a review and that stars render (if you
installed rateit.js).
