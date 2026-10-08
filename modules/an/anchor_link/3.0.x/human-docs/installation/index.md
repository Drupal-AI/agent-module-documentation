# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) and **Editor** module (`editor`),
  which Drupal enables automatically as dependencies.
- The **`vardot/ckeditor5-anchor-drupal`** CKEditor 5 plugin library
  (`^1.0.3 || ^2.0.4`). Composer pulls it in when you require the module; it needs
  to end up in your site's `libraries/` directory so the editor can load its
  JavaScript (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/anchor_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the `vardot/ckeditor5-anchor-drupal`
library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anchor_link -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

### Making sure the library is in place

The editor loads the anchor plugin's build from
`/libraries/ckeditor5-anchor-drupal/build/anchor-drupal.js`. The module's
`composer.json` declares the library, so with a standard Composer setup that uses
the asset-packagist repository and an installer path for `type:drupal-library`, it
lands in `web/libraries/ckeditor5-anchor-drupal` automatically. If the Anchor link
button does not work after enabling, confirm that file exists and, if not, place the
`vardot/ckeditor5-anchor-drupal` library there manually.

## Enable the module

```bash
drush en anchor_link -y
```

Enabling the module makes the **Anchor link** button available in the CKEditor 5
toolbar configurator, but it does not change any text format by itself. Add the
button to a format's toolbar to switch it on — see
[How to use it](../index.md#how-to-use-it) on the overview page.
