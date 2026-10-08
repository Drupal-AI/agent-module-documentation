# Installation

## Requirements

Menu Breadcrumb runs on **Drupal 9, 10, or 11** (`^9 || ^10 || ^11`) and has
**no contrib dependencies** — it uses only Drupal core. There is nothing extra
for Composer to pull in.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_breadcrumb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any core packages
it needs along the way.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_breadcrumb -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_breadcrumb -y
```

## Verify it worked

Log in as an administrator and go to
**Configuration → User interface → Menu Breadcrumb**
(`/admin/config/user-interface/menu-breadcrumb`). You should see the Menu
Breadcrumb settings page:

![The Menu Breadcrumb settings page](../images/settings.png)

If the settings page loads, the module is installed correctly. Note that Menu
Breadcrumb does **not** change any breadcrumbs until you enable it and save its
settings — head to [Configuration](../configuration/index.md) next to switch it
on and choose how the trail is built.
