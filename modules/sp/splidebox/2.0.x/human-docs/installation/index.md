# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Splide** module (`splide`) — the Splide slider integration.
- The **Blazy** module (`blazy`) — the lazy‑loading and media layer Splidebox
  builds on. This is a substantial module in its own right; installing Splidebox
  brings it along, so be aware you are adding Blazy to your site.
- The **Splide** JavaScript library, which the Splide module manages.

For thumbnail navigation and the full Views integration, Blazy 2.23 or later is
recommended.

## Install with Composer

From the project root:

```bash
composer require drupal/splidebox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Splide and Blazy dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/splidebox -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en splidebox -y
```

Enabling Splidebox also enables Splide and Blazy if they are not already on.

## Verify it worked

Edit the display of an image or media field (under **Structure → Content types →
[type] → Manage display**), pick a Blazy‑based formatter, and set its **Media
switcher** option to **Splidebox**. View a page with that field and click an
image — it should open in the Splidebox overlay.
