# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **file field** on the content type or entity that will hold your 3D models.
- 3D model files in **OBJ, GLTF, or GLB** format to display.

There are no contrib module dependencies and no additional PHP library
requirements — the Google `<model-viewer>` web component ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/model_viewer_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/model_viewer_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en model_viewer_formatter -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a file field)* → Manage
display**. For the file field, open the **Format** dropdown — you should see
**Model Viewer (Google)** as an available option. Select it, save, then upload a
sample OBJ/GLTF/GLB file to a node of that type and confirm the interactive
viewer appears on the rendered page. See the [main guide](../index.md) for the
per-field formatter options.
