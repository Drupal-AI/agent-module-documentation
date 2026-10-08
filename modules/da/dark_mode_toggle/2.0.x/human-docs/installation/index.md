# Installation

## Requirements

Dark Mode Toggle is self-contained — no third-party libraries and no other
contrib modules:

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- A theme whose CSS will react to the `data-dmt-mode` attribute (see
  [How to use it](../index.md#how-to-use-it)). The module works without dark-mode
  CSS, but nothing on screen will change colour until you add it.

## Install with Composer

From the project root:

```bash
composer require drupal/dark_mode_toggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dark_mode_toggle -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dark_mode_toggle -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region — **Dark Mode Toggle** should appear in the block picker.
Place it, save, and load a page: you should see the Light / Dark / System buttons.
They will switch the `data-dmt-mode` attribute immediately; the visible colour
change only appears once your theme has the matching CSS.
