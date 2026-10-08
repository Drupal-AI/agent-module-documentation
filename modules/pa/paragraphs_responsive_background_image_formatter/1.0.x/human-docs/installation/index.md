# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Core **Media** (`media`), the **Paragraphs** module (`paragraphs`), and the
  **BG Image Formatter** module (`bg_image_formatter`) — this module extends BG
  Image Formatter's responsive background handling. Drupal will pull these in as
  dependencies when you install with Composer and `-W`.

There are no additional third-party Composer or PHP library requirements beyond
those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_responsive_background_image_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required modules (including BG Image Formatter) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_responsive_background_image_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_responsive_background_image_formatter -y
```

Make sure **Paragraphs**, **Media**, and **BG Image Formatter** are enabled too
(Drush enables the declared dependencies for you).

## Verify it worked

Open a paragraph type's **Manage display**, edit the display of a media image
field, and confirm **Paragraphs Responsive Background Image** appears as an
available formatter with a **DOM element target** option. Add the paragraph to
some content with a background image and check that the section renders with a
responsive CSS background. See "How to use it" on the [overview page](../index.md)
for the full field-display workflow.
