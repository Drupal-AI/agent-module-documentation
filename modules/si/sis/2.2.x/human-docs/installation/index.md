# Installation

## Requirements

Smart Imaging Styles is lightweight and leans on Drupal core:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Responsive Image** module (`responsive_image`) and **System**
  (`system`). Drupal enables these as dependencies when you turn on the module.

There are no third-party Composer packages or PHP library requirements. If you want
smart, on-the-fly cropping you can optionally add an imaging service such as the
Thumbor or Cloudinary modules, but neither is needed for the module to work.

## Install with Composer

From the project root:

```bash
composer require drupal/sis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sis -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sis -y
```

## Verify it worked

Edit the *Manage display* screen of any content type or media type that has an
image field. Smart Imaging Styles should now appear as an available **formatter**
for that field. Selecting it, saving, and reloading a page where the image appears
is the quickest way to confirm the module is active — see
[Configuration](../configuration/index.md) for the details.
