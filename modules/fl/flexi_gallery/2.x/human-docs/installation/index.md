# Installation

## Requirements

- **Drupal 9, 10, or 11** (and beyond) — the module declares very wide core
  support (`^9 || ^10 || ^11 || ^12 …`).
- An **image field** to format — Flexi Gallery is a formatter, so it only does
  something once you point it at a multi-value image field.
- *Optional:* the **Colorbox** and/or **Fancybox** module if you want the
  lightbox display options. They are not required to install Flexi Gallery; the
  matching lightbox option simply becomes available (and its library is attached)
  when the module is present.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flexi_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flexi_gallery -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexi_gallery -y
```

## Verify it worked

Go to **Structure → Content types → *(any type with a multi-value image field)* →
Manage display**. Open the **Format** dropdown for that image field — **Flexi
Gallery** should now be one of the choices. Selecting it and opening the formatter
settings confirms the module is active.
