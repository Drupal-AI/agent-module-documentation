# Installation

## Requirements

Izi Message is lightweight and has no module dependencies beyond core:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The bundled **iziToast** JavaScript library, which the module provides — there
  is nothing extra to download.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/izi_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/izi_message -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en izi_message -y
```

## Verify it worked

Perform any action that produces a status message — save a piece of content or a
configuration form, for example. Instead of the usual block of text at the top of
the page, the confirmation should now appear as a light toast‑style notification.
To fine‑tune where it appears and how long it stays, see
[Configuration](../configuration/index.md).
