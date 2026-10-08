# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Contributed dependencies (Composer installs these for you):
  - [Paragraphs](https://www.drupal.org/project/paragraphs)
  - [Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions)
  - [Field Group](https://www.drupal.org/project/field_group)
- A number of core modules are also required and enabled as dependencies: block,
  field, file, image, link, media, media_library, options, system, text, user,
  and views.
- *Optional but suggested:* the [Solo](https://www.drupal.org/project/solo)
  theme, which integrates fully with the **PB Content** type and full‑width
  regions. Some individual bundle submodules also depend on other contrib
  modules (for example `viewsreference`, `webform`, `contact_formatter`, or
  `link_attributes`) — Composer will tell you when a submodule needs one.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_bundles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs,
Entity Reference Revisions, Field Group, and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_bundles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en paragraphs_bundles -y
```

Or enable **Paragraphs Bundles** from **Extend** (`/admin/modules`). The base
module gives you the shared field types, the styling machinery, and the
`simple_bundle` paragraph type.

## Submodules — enable only the bundles you need

Paragraphs Bundles ships **26 bundle submodules**. Enable the ones you want with
`drush en`; each one provisions its paragraph type and fields automatically on
enable:

| Bundle submodule | Adds |
|------------------|------|
| `paragraph_bundle_3d_carousel` | A 3D carousel |
| `paragraph_bundle_3d_flip_box` | A 3D flip box |
| `paragraph_bundle_accordion` | An accordion |
| `paragraph_bundle_alert` | An alert / notice block |
| `paragraph_bundle_block` | A block reference bundle |
| `paragraph_bundle_block_content` | A custom‑block content bundle |
| `paragraph_bundle_card` | A card |
| `paragraph_bundle_carousel` | A carousel |
| `paragraph_bundle_contact_form` | An embedded core Contact form |
| `paragraph_bundle_content` | **PB Content** — a `pb_content` node type for full‑page building |
| `paragraph_bundle_grid` | A responsive grid |
| `paragraph_bundle_hero` | A hero region |
| `paragraph_bundle_icon` | An icon |
| `paragraph_bundle_image` | An image (several other bundles depend on this) |
| `paragraph_bundle_image_background` | An image‑background section |
| `paragraph_bundle_image_grid` | An image grid |
| `paragraph_bundle_image_overlay` | An image with overlay |
| `paragraph_bundle_layout` | A layout / column container |
| `paragraph_bundle_link` | A link |
| `paragraph_bundle_modal` | A modal dialog |
| `paragraph_bundle_node_reference` | A node reference (with carousel/slideshow displays) |
| `paragraph_bundle_parallax` | A parallax section |
| `paragraph_bundle_slideshow` | A slideshow |
| `paragraph_bundle_tabs` | Tabs |
| `paragraph_bundle_views` | An embedded View |
| `paragraph_bundle_webform` | An embedded Webform |

For example, to add the accordion and hero bundles:

```bash
drush en paragraph_bundle_accordion paragraph_bundle_hero -y
```

Each submodule requires the base Paragraphs Bundles module (already present once
you installed it above); some also depend on `paragraph_bundle_image` or on an
extra contrib module, which Drupal/Composer will flag.

## Next steps

There is no configuration page. After enabling the bundles you want, attach a
**Paragraphs** reference field to the entity that should hold them and allow the
bundle types — see [How to use it](../index.md#how-to-use-it) on the overview
page.
