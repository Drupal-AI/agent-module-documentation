# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Field**, **File**, **Image**, and **Node** modules (all part of
  Drupal core).
- The contributed **Paragraphs** module (`paragraphs`).
- The bundled **Field Tooltips Data** submodule (`field_tooltips_data`), which
  provides the tooltip field type, widget, and formatter — enabled automatically
  as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_image_tooltips -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Paragraphs dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_image_tooltips -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_image_tooltips -y
```

Enabling the main module also pulls in the bundled **Field Tooltips Data**
submodule and the Paragraphs dependency.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Field Tooltips Data** | `field_tooltips_data` | Provides the underlying field type, widget, and formatter that store and render the tooltip data — which node each hotspot references and where it sits on the image. It is required by the main module and is enabled automatically when you enable `field_image_tooltips`. |

## Verify it worked

Add a Paragraphs field to a content type and confirm that **Image with
tooltips** appears among the allowed Paragraph bundles. Create a piece of content
using it, place a tooltip that references a node, and view the page — clicking
the tooltip marker should open that node's content in a modal dialog.
