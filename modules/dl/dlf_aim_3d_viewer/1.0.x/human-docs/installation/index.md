# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Field** (`field`) module — part of a standard install.
- **Optional, for the conversion/thumbnail pipeline:** server‑side tooling
  (notably a **Blender** utility, plus the PHP/bash scripts the module ships) used
  to compress supported formats, convert them to GLB and render thumbnails. Basic
  viewing of the directly supported formats does not require this, but the
  automatic conversion features do.

The three.js viewer library is provided by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/dlf_aim_3d_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dlf_aim_3d_viewer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dlf_aim_3d_viewer -y
```

## After enabling

Grant the module's permissions to the appropriate roles on **People →
Permissions**, then add its 3D‑viewer field to the content type that will hold
your models.

## Verify it worked

Add the module's 3D‑viewer field to a content type, place it on the *Manage form
display* and *Manage display* tabs, then create a piece of content and upload a
supported 3D file (for example an OBJ or glTF model). Viewing the content should
render an interactive 3D viewer you can rotate and zoom.
