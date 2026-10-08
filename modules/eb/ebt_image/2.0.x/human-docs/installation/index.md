# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base for the Extra Block Types family.
- Core **Media** (`media`) and **Link** (`link`) modules.
- **GLightbox** (`glightbox`) — provides the lightbox popup viewer.

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_image -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_image -y
```

Enabling the module auto‑creates the **EBT Image** block type and its fields (media,
caption, link, and the shared EBT settings).

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see **EBT Image** as an available block type. Add one, choose an image, and confirm
the caption, link, image‑style, and lightbox options appear alongside the shared EBT
design options.
