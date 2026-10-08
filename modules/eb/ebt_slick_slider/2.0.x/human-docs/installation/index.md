# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core ^2.0`) — the shared base for the Extra Block Types family.
- **Paragraphs** (`paragraphs ^1.0`) — the slides are Paragraphs.

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_slick_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_slick_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_slick_slider -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see the **Slick Slider** block type. Add one, add a couple of slides, place it, and
confirm the carousel rotates on the rendered page.
