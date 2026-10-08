# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Three **external JavaScript libraries** that are *not* bundled with the module
  and must be downloaded manually (see below). Charts will not render until they
  are in place.

There are no Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/pankm_chart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pankm_chart -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Download the required JavaScript libraries

Place these three files into the module's **`/pankm_chart/js/Scripts/`** folder:

1. **d3.js** — from <https://d3js.org>. For **PanKM Chart 11.1.x** use **v7.9.0**
   (for the older 10.1.x line the module expected d3 v5.9.2).
2. **polyfill.min.js** — from
   `https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.min.js`.
3. **fetch.umd.js** — from
   `https://github.com/github/fetch/releases/download/v3.0.0/fetch.umd.js`.

Charts depend on all three, so download them before (or right after) enabling the
module.

## Enable the module

```bash
drush en pankm_chart -y
```

When you enable the module it **automatically creates a dedicated content type and
a sample node**, so you have a working example to start from.

## Verify it worked

Go to **Content** (`/admin/content`) and open the sample node the module created.
If the chart renders, the module and its three JavaScript libraries are working.
If it does not, re-check that the three files are present in
`/pankm_chart/js/Scripts/` and clear the cache (`drush cr`). Then create your own
chart at **Content → Add content → PanKM Chart** (`/node/add/pankm_chart`).
