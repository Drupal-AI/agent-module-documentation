# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Image** module (`image`) — enabled by default on standard installs.
- The module also relies on **jQuery UI** for the viewer.

## Install with Composer

From the project root:

```bash
composer require drupal/panorama_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/panorama_viewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en panorama_viewer -y
```

## Verify it worked

Open the **Manage display** page of a content type that has an image field (for
example **Structure → Content types → *(type)* → Manage display**). The
**360° panorama viewer** formatter should be available for that image field.
Select it, add a genuine 360° image to a piece of content (with the field limited
to one value), and view the node — a pan-around panorama viewer should appear.
