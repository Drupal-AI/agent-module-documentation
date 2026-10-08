# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`), which Drupal enables as a dependency.
- The third-party **Tempus Dominus** JavaScript library — either self-hosted
  under `/libraries/tempus-dominus`, or loaded from a CDN (a single setting; see
  below).
- Optional: the **Webform** module, only if you want the Bootstrap DateTime
  Webform element.

There are no Composer package requirements beyond Drupal itself.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_datetime_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap_datetime_picker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the Tempus Dominus library

The picker needs the Tempus Dominus library on disk unless you use the CDN:

- **Self-hosted:** place the library at `/libraries/tempus-dominus`, with its
  assets at `dist/js/tempus-dominus.min.js` and `dist/css/tempus-dominus.min.css`
  (and locale files under `dist/locales/`). Drupal's status report checks whether
  the library is present and shows the detected version; the settings form also
  warns if the folder is missing.
- **CDN:** if you'd rather not host the files, turn on **Use Tempus Dominus CDN**
  in the settings form (or set `use_tempus_dominas_cdn: true`) to load the library
  from jsDelivr instead. The icon CSS also has its own CDN toggle.

## Enable the module

```bash
drush en bootstrap_datetime_picker -y
```

There are no submodules. Next, tune the shared look and behaviour on the settings
form — see [Configuration](../configuration/index.md).
