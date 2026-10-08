# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Image** module (`image`) and core's **Link** module (`link`), both
  enabled. Drupal pulls them in automatically as dependencies. The Link module is
  essential here — the Link field is what supplies each image's destination URL.

There are no third-party Composer or PHP library requirements.

Optional companions the module suggests (not required):

- **Link Attributes** (`drupal/link_attributes`) — add attributes like `rel` or
  `target` to a Link field, which the formatter then applies to the image link.
- **Link Target** (`drupal/link_target`) — a smaller module that just adds a
  `target` attribute (for example to open the link in a new tab).
- **Paragraphs** (`drupal/paragraphs`) — handy for building repeatable image + link
  promo components.

## Install with Composer

From the project root:

```bash
composer require drupal/image_link_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_link_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_link_formatter -y
```

The new **"Image wrapped within link field"** formatter is available immediately on
any image field's Manage display settings.

## Optional submodule — Responsive Image Link Formatter

If you display images with core's **Responsive Image** formatter and want the same
"wrap in a Link field's URL" behavior, enable the bundled submodule:

```bash
drush en responsive_image_link_formatter -y
```

It requires the base module (already present) and core's Responsive Image module.

## Next step

There's no configuration page — you set the formatter up per field on each
bundle's **Manage display** page. See the "How to use it" section on the
[overview page](../index.md) for the walkthrough.
