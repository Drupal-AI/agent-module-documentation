# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Drutopia Core declares a large dependency set, all resolved for you by
  Composer/Drush. It includes:
  - **Core:** CKEditor 5, Media, Media Library, Image, Responsive Image,
    Taxonomy.
  - **Contrib:** Automated Crop (`automated_crop`), Crop (`crop`), Focal Point
    (`focal_point`), Image Widget Crop (`image_widget_crop`), Display Suite
    (`ds`), Exclude Node Title (`exclude_node_title`), FAQ Field (`faqfield`),
    Metatag (`metatag`), Paragraphs (`paragraphs`), Pathauto (`pathauto`),
    Search API + Search API DB (`search_api`, `search_api_db`), Video Embed Field
    (`video_embed_field`) and Config Perms (`config_perms`).

There are no PHP library requirements. It is normally installed as part of a full
Drutopia site rather than in isolation.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_core -W
```

The `-W` (`--with-all-dependencies`) flag is important here — this feature's whole
purpose is to bring in a large stack of components, so let Composer resolve them.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drutopia_core -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_core -y
```

Enabling it also enables its dependencies and installs the shared default
configuration the rest of the Drutopia suite relies on. On a full Drutopia site,
the install profile enables this first, before any content feature.

## Verify it worked

- Confirm the module is enabled at **Extend** (`/admin/modules`).
- Confirm the bundled components are present — for example **Structure → Media
  types** (`/admin/structure/media`) should list media types, and Display Suite,
  Metatag and Pathauto should appear under **Configuration**.
- If you're upgrading an older Drutopia site, run `drush updatedb` so Drutopia
  Core's update hooks install any newly added dependencies.
