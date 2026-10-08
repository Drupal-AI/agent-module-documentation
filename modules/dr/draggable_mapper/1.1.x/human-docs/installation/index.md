# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field**, **Image**, and **Text** modules (Field and Image ship with
  core and are enabled as needed).
- The **Paragraphs** module (`paragraphs`) — used to model markers.
- The **Inline Entity Form** module (`inline_entity_form`) — used to edit markers
  within the map form.
- **jQuery UI Draggable, Droppable, and Resizable** — provide the drag‑and‑resize
  editing interface.

## Install with Composer

From the project root:

```bash
composer require drupal/draggable_mapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including Paragraphs, Inline Entity Form, and the jQuery UI pieces
— as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/draggable_mapper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en draggable_mapper -y
```

Drush enables the required Paragraphs, Inline Entity Form, and jQuery UI
dependency modules automatically.

## Optional: SVG marker icons

Drupal's image fields have limited SVG support by default. If you want to use SVG
files for marker icons, install the **SVG Image** module and add `svg` to the
allowed extensions on the marker icon field:

```bash
composer require drupal/svg_image -W
drush en svg_image -y
```

Then, under **Structure → Paragraph types → DME Marker → Manage fields → Icon →
Edit**, add `svg` to the allowed file extensions.

## Verify it worked

1. Grant the Draggable Mapper permissions to the roles that should manage maps on
   **People → Permissions** (`/admin/people/permissions`).
2. Go to **Structure → Draggable Mapper Entities → Add Draggable Mapper**
   (`/admin/structure/draggable-mapper-entity/add`) and confirm you can upload an
   image, add a marker, and drag it into place.

See "How to use it" in the [overview](../index.md) for the full authoring
walkthrough.
