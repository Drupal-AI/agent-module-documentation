# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Lightbox** module (`lightbox`) — this is the module's only Drupal
  dependency, and Drupal enables it automatically as a dependency.
- The **Tobii** JavaScript library, installed under your site's `libraries/`
  directory. The module expects these files to be present:
  - `libraries/tobii/dist/tobii.umd.js`
  - `libraries/tobii/dist/tobii.min.css`

  Installing the module with Composer (below) fetches the library files
  automatically from the maintainer's mirror, so you normally do not have to
  download them by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/lightbox_tobii -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightbox_tobii -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lightbox_tobii -y
```

## Verify it worked

On an image field's **Manage display**, choose the **Tobii** lightbox formatter
and save. Visit a page that shows that field and click the image — it should open
in the Tobii lightbox overlay. If the overlay does not appear, confirm the
library files listed under Requirements are present in `libraries/tobii/dist/`.
