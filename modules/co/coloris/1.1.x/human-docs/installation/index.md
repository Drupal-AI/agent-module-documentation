# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Options** module (`options`) enabled — this is the only dependency, and
  Drupal enables it automatically as needed.

There are no third‑party Composer or PHP library requirements. The Coloris
JavaScript library is loaded at runtime from a CDN (see the note below).

## Install with Composer

From the project root:

```bash
composer require drupal/coloris -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/coloris -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en coloris -y
```

There is no configuration form to visit. Once enabled, the **Coloris Color** field
type becomes available in the Field UI. See the *How to use it* section of the
[overview](../index.md) to add and configure a field.

> **CDN note.** The Coloris picker's CSS/JS is loaded from the jsDelivr CDN pinned
> to `@latest`, so the exact version is not fixed by the module. To pin a version
> or self‑host it, override the `element.coloris.lib` library with
> `hook_library_info_alter()` and point it at a local `libraries/` copy.

## Verify it worked

On any bundle's **Manage fields** tab, click **Add field** — you should see
**Coloris Color** in the field type list. Add it, then edit content of that bundle:
the field should render a color swatch that opens the Coloris picker.
