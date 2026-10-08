# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11`).
- Core's **Link** field module (`link`).
- The contrib **Font Awesome** module (`fontawesome/fontawesome`, version
  `^2 || ^3`), which brings the Font Awesome project into Drupal so the icons can
  render. Make sure Font Awesome is installed and configured to load its library
  on the pages where your links appear — otherwise the formatter outputs icon
  markup with nothing to display it.

## Install with Composer

From the project root:

```bash
composer require drupal/link_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Font Awesome
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_icons -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Link Icons Brands** | `link_icons_brands` | Imports the ready‑made brand service definitions (Facebook, Instagram, YouTube, GitHub, Mastodon, Bluesky, and many more) as configuration entities, so the formatter recognises those hostnames out of the box. Enable it unless you intend to define every mapping yourself. |

```bash
drush en link_icons_brands -y
```

## Verify it worked

Go to **Manage display** for an entity that has a link field and confirm
**Service icon (with options)** appears in the field's **Format** list. Set a link
field to a known service (for example a `facebook.com` URL) and view the content —
you should see the matching Font Awesome icon. If you see nothing where the icon
should be, check that the Font Awesome module is loading its library on that page.
