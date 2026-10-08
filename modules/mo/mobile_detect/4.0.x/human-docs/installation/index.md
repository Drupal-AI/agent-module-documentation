# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`mobiledetect/mobiledetectlib`** PHP library (version 4.8.09). This is a
  Composer dependency, so installing the module with Composer pulls it in
  automatically — there is no separate `/libraries` download.

The module has no dependencies on other Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/mobile_detect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and installs the `mobiledetect/mobiledetectlib` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mobile_detect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mobile_detect -y
```

Once enabled, device detection is active immediately: the `is-mobile` /
`is-tablet` body classes and the Twig functions work right away, and the two
block‑visibility conditions become available on every block. See
[Configuration](../configuration/index.md) for the settings form and the UI
features.

## Verify it worked

Place the **Mobile Detect Status** block from **Block layout** on a page (or
open a page on a phone) — it reports the detected state and the active
Mobile_Detect library version, confirming detection is working.
