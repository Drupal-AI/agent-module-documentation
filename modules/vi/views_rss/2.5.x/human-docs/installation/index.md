# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) enabled — the only hard dependency.
- No third‑party PHP libraries are required for the base module. Two are optional:
  - **getID3** (`james-heinrich/getid3`, `^2.0@beta`) — required only if you enable
    the `views_rss_media_getid3` submodule (it reads real audio/video metadata).
  - **Video Embed Field** (`drupal/video_embed_field`) — optional; lets the core
    submodule's `<enclosure>` preprocessor handle embedded video fields.

## Install with Composer

From the project root:

```bash
composer require drupal/views_rss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you plan to use the getID3 media submodule, also require
its library:

```bash
composer require james-heinrich/getid3 -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_rss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with at least the core element set — the base module
alone provides no RSS elements:

```bash
drush en views_rss views_rss_core -y
```

## Submodules — enable the element sets you need

The base module supplies only the Views plugin machinery. Each submodule contributes
a set of RSS `<channel>`/`<item>` elements. Enable the ones your feed needs:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Core Elements** | `views_rss_core` | The standard RSS 2.0 elements — `<title>`, `<link>`, `<description>`, `<guid>`, `<enclosure>`, `<pubDate>`, channel `<image>`, `<ttl>`, `<atom:link>`, and more. **Effectively required** — the row plugin needs it so each item has at least a title or description. |
| **Dublin Core Elements** | `views_rss_dc` | Dublin Core metadata such as `dc:creator`, `dc:date`, `dc:subject`. |
| **Format Elements** | `views_rss_format` | A tweak to control raw/CDATA output — lets specific elements skip HTML-entity encoding to pass raw markup through. |
| **Media (MRSS) Elements** | `views_rss_media` | Yahoo Media RSS elements (`media:content`, `media:thumbnail`, `media:category`) for podcast/video feeds. |
| **Media getID3** | `views_rss_media_getid3` | Enriches the Media RSS elements with real bitrate, resolution, and duration read from files via the getID3 library (requires the `james-heinrich/getid3` library above). |

For example, to build a podcast feed with Media RSS you might run:

```bash
drush en views_rss_core views_rss_media -y
```

## Verify it worked

After enabling, edit or create a View at **Structure → Views**, add a **Feed**
display, and set its format to **Advanced RSS feed**. When you open the format/row
settings you should see RSS elements grouped by namespace (at minimum the core RSS
elements). If the element list looks empty or incomplete, enable more submodules and
run `drush cr` — the module caches its element registries, so a cache rebuild makes
newly enabled elements appear. See "How to build a feed" in the
[overview](../index.md) for the full mapping steps.
