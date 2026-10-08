# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed module dependencies and no third‑party PHP libraries.

Two features are enhanced by other modules if present: the **EU Cookie Compliance**
privacy option only works (and its checkbox is only enabled) when the
`eu_cookie_compliance` module is installed, and the **Facebook Pixel Commerce**
submodule requires Drupal Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/facebook_pixel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facebook_pixel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facebook_pixel -y
```

## Optional: the Commerce submodule

If you run Drupal Commerce and want e‑commerce tracking (AddToCart,
InitiateCheckout, Purchase, product ViewContent), also enable the bundled submodule:

```bash
drush en facebook_pixel_commerce -y
```

It requires the base Facebook Pixel module (already present) and Drupal Commerce.

## Grant the permission

The module provides a **Configure facebook_pixel** permission that gates the settings
form. Grant it to the roles that should manage tracking:

```bash
drush role:perm:add administrator 'configure facebook_pixel'
```

(There is also a `use php for page_visibility` permission for advanced page‑visibility
rules — grant it only to fully trusted roles.)

## Verify it worked

Go to **Configuration → Web services → Facebook Pixel** (`/admin/config/
facebook_pixel`), enter your pixel id and save. Then load a public page and view its
source — you should find the pixel bootstrap and, in `drupalSettings.facebook_pixel`,
your pixel id. (You'll notice a harmless log notice about a missing
`facebook_pixel.admin` library on the settings page; it does not affect anything.)

Next, see [Configuration](../configuration/index.md) to set visibility and privacy
options.
