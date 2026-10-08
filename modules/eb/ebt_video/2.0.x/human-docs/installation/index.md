# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base for the Extra Block Types family.
- Core **Media** (`media`) module.
- **GLightbox** (`glightbox`) and **GLightbox Media Video** (`glightbox_media_video`)
  — provide the video lightbox popup.
- **Paragraphs** (`paragraphs`).

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_video -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_video -y
```

Enabling the module auto‑creates the **Video** block type, its fields, and a
dedicated `ebt_video` media view mode.

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see the **Video** block type. Add one, reference a remote or local video, place it,
and confirm the video renders (inline or in the lightbox popup) on the page.
