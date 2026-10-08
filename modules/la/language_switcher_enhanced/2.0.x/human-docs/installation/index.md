# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A multilingual site — core's **Language** module with **two or more languages**
  configured, and a **language‑switcher block** placed (this is what the module
  enhances).

There are no third‑party Composer or PHP library requirements, and no other
contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/language_switcher_enhanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_switcher_enhanced -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_switcher_enhanced -y
```

## Verify it worked

With the **Language switcher** block placed in a visible region, view a page that
is *not* translated into all of your languages, as a normal visitor. Once you have
chosen a behaviour (see [Configuration](../configuration/index.md)), the switcher
should hide, disable, or redirect the untranslated languages rather than linking
straight to a wrong or missing page.
