# Installation

## Requirements

Asset Injector needs **Drupal 10.3+ or 11** (`drupal/core: ^10.3 || ^11`). It has
**no other module dependencies** and pulls in no extra libraries — once Drupal
core meets the version requirement, nothing else is needed.

## Install with Composer

From the project root:

```bash
composer require drupal/asset_injector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any packages it
needs to along the way.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/asset_injector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en asset_injector -y
```

Once enabled, the Asset Injector screens appear under **Configuration →
Development → Asset Injector** (`/admin/config/development/asset-injector`).

## Verify it worked

Log in as an administrator and go to
`/admin/config/development/asset-injector`. You should see the **Asset Injector**
overview page with two entries — **CSS Injector** and **JS Injector**:

![The Asset Injector overview page listing CSS Injector and JS Injector](../images/list.png)

If the page loads and both collections are listed, the module is installed
correctly. Next, [add your first CSS or JS injector](../configuration/index.md).

> **A note on access.** Injecting CSS or JavaScript is security-sensitive, so
> Asset Injector's two permissions — *administer css assets injector* and
> *administer js assets injector* — are restricted. Grant them only to fully
> trusted administrators.
