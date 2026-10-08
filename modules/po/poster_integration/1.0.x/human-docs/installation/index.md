# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- **Drupal Commerce** with its **Commerce Product** (`commerce_product`) and **Commerce
  Order** (`commerce_order`) modules — these are required dependencies. Composer installs them
  for you with the `-W` flag below if they are not already present.
- A **Poster account** with an API **access token** and the **spot id** you want to sync.

## Install with Composer

From the project root:

```bash
composer require drupal/poster_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Drupal Commerce and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/poster_integration -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en poster_integration -y
```

## Verify it worked

1. Grant your administrator role the **Setup poster integration** permission on
   **People → Permissions**.
2. Visit **`/admin/commerce/config/poster_integration`** — you should see the settings form
   with the access token, spot id, and "send orders" options.
3. Enter your credentials, save, and run **Load categories** / **Load products** to confirm
   the import brings your Poster catalogue into Commerce.

See the [manual setup guide](../index.md) for how to configure the token, run the imports, and
enable order push.
