# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) enabled — the only hard dependency. The **Views
  UI** module is what you use to build the feed.
- No third-party libraries for the base module. Two optional submodules have extra
  suggestions (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/views_rss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_rss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module and its submodules

The base `views_rss` module supplies only the plugin machinery — it ships no RSS
elements on its own. **You must also enable at least the Core Elements submodule** for
a feed to produce anything. At minimum:

```bash
drush en views_rss views_rss_core -y
```

## Submodules — enable what your feed needs

Advanced Views RSS Feed ships five submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Core Elements** | `views_rss_core` | The standard RSS 2.0 `<channel>` and `<item>` elements (title, link, description, enclosure, guid, category, image, ttl…). **Required** — an RSS item must have a title or a description, so the feed won't work without this. |
| **Dublin Core Elements** | `views_rss_dc` | Dublin Core metadata (`dc:creator`, `dc:date`, `dc:subject`, …) alongside the core elements. |
| **Format Elements** | `views_rss_format` | An output tweak that lets specific elements skip HTML-entity encoding and pass raw markup through. |
| **Media Elements** | `views_rss_media` | Yahoo Media RSS (`media:content`, `media:thumbnail`, `media:category`) for podcast and video feeds. |
| **Media getID3** | `views_rss_media_getid3` | Enriches the Media RSS elements with real audio/video bitrate, resolution, and duration read via getID3. Requires the `james-heinrich/getid3` library (`^2.0@beta`). |

Optional library/module suggestions:

- **`views_rss_media_getid3`** needs the `james-heinrich/getid3` PHP library — add it
  with `composer require james-heinrich/getid3` if you enable that submodule.
- **`views_rss_core`**'s `<enclosure>` preprocessor can additionally handle embedded
  video fields if the **Video Embed Field** module (`drupal/video_embed_field`) is
  installed.

For example, to build a podcast feed with media metadata:

```bash
drush en views_rss views_rss_core views_rss_media views_rss_media_getid3 -y
```

## Verify it worked

Edit a View at **Structure → Views**, add a **Feed** display, and open its **Format**
setting. **Advanced RSS feed** should appear as an available style. See the
[How to use it](../index.md#how-to-use-it) section of the overview for mapping fields
to RSS elements.
