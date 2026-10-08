# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core **Link** (`link`) and **Media** (`media`) modules.
- **EBT Basic Button** (`ebt_basic_button`) — supplies the hero's call‑to‑action
  buttons and pulls in the shared **EBT Core** base.
- **Paragraphs** (`paragraphs`).

Composer resolves these automatically when you install with the `-W` flag below.

**Before you enable it:** the hero's fields reference an **image media type**. If
your site has no `image` media type yet, enabling can fail with an *"unmet
dependencies … media.type.image"* error. Create the image media type first (most
standard installs already have one), then enable the module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_hero -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_hero -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_hero -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder on a page) —
you should see **Hero** listed as an available block type. Add one, and confirm the
background media, title, subtitle, and button fields appear along with the shared
EBT design options. If enabling failed on a media‑type error, create the `image`
media type first and try again.
