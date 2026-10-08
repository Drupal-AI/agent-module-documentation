# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core ^2.0`) — the shared base for the Extra Block Types family.
- Core **Media** (`media`) and **Media Library** (`media_library`).
- **Paragraphs** (`paragraphs ^1.0`).
- The **FlexSlider** JavaScript library — the `levmyshkin/flexslider ^2.7` Composer
  package (a maintained FlexSlider fork). Because it is listed as a Composer
  requirement of the module, `composer require … -W` pulls it in automatically.

There are no separate PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed — and it is what installs the `levmyshkin/flexslider` library alongside the
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_slideshow -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_slideshow -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see the **Slideshow** block type. Add one, choose a few media images, place it, and
confirm the FlexSlider slideshow runs on the rendered page.
