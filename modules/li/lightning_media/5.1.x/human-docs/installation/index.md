# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** (`image`), **Media Library** (`media_library`) and **User**
  (`user`) modules — Drupal enables these automatically as dependencies.
- **Lightning Core** (`drupal/lightning_core:^6`) — this is a hard Composer
  dependency and will be pulled in for you.

Individual features and submodules suggest further contributed modules, which you
only need if you want that feature:

| For… | Install |
|---|---|
| Bulk uploading many files at once (Bulk Upload submodule) | `drupal/dropzonejs` (+ the `enyo/dropzone` JS library) |
| Better image fields (Image submodule) | `drupal/entity_browser` |
| Image cropping | `drupal/image_widget_crop` |
| Creating media from uploads/embeds in an entity browser | `drupal/inline_entity_form` |
| Instagram media type | `drupal/media_entity_instagram` |
| Tweet media type | `drupal/media_entity_twitter` |
| Slideshow/carousel media type | `drupal/slick_entityreference` (+ `vardot/blazy`) |

## Install with Composer

From the project root:

```bash
composer require drupal/lightning_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including Lightning Core, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightning_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en lightning_media -y
```

This installs the two extra media view modes (`embedded`, `thumbnail`), the
`field_media_in_library` field storage, and the settings form at *Configuration →
Media → Lightning Media*.

## Component submodules — enable only what you need

Lightning Media ships eight optional submodules, each providing one media type.
Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|---|---|---|
| **Audio** | `lightning_media_audio` | An audio media type |
| **Bulk Upload** | `lightning_media_bulk_upload` | A DropzoneJS‑powered form for uploading many files at once (needs `dropzonejs`) |
| **Document** | `lightning_media_document` | A document/file media type |
| **Image** | `lightning_media_image` | Enhanced image handling (works best with Entity Browser / Image Widget Crop) |
| **Instagram** | `lightning_media_instagram` | An Instagram media type (needs `media_entity_instagram`) |
| **Slideshow** | `lightning_media_slideshow` | A simple carousel media type (needs `slick_entityreference`) |
| **Twitter** | `lightning_media_twitter` | A tweet media type (needs `media_entity_twitter`) |
| **Video** | `lightning_media_video` | Local and remote (oEmbed) video media types |

For example, to add image and video handling:

```bash
drush en lightning_media_image lightning_media_video -y
```

Each submodule requires the base Lightning Media module, which is already present
once you have installed it above. Some submodules also expect their suggested
contributed module (see the table under Requirements) to be installed first.

## Optional roles and text format

If your site also runs the **Lightning Roles** module, enabling Lightning Media
provisions two roles — **Media creator** and **Media manager** — and grants the
Lightning *creator* content role the `rich_text` text format. Without Lightning
Roles those roles are simply not created (you can build equivalents by hand). See
the [`agent/`](../agent/start.md) permissions reference for the exact grants.

## Verify it worked

Go to **Configuration → Media → Lightning Media**
(`/admin/config/system/lightning/media`) — the settings form should load. Then add
a piece of media (*Content → Media → Add media*) and confirm you see the live source
preview and the *Show in media library* checkbox.

Next, see [Configuration](../configuration/index.md) for the two settings and the
per‑item library switch.
