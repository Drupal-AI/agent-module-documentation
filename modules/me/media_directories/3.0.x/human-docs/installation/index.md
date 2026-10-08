# Installation

## Requirements

Media Directories needs:

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- These core modules enabled (Drupal turns them on as dependencies): **Media**, **Media
  Library**, **Taxonomy** and **Views**.

Some submodules have extra, optional suggestions:

- **AI** (`drupal/ai`) — required by the `media_directories_ai` submodule for AI-powered
  alt text and translations.
- **Focal Point** (`drupal/focal_point`) — enables focal-point support in the browser.
- **SVG Image** (`drupal/svg_image`) — enables SVG support in image fields.

## Install with Composer

From the project root:

```bash
composer require drupal/media_directories -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_directories -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_directories -y
```

Enabling the base module adds the *Directory* field to media and injects a directory filter
into core's Media Library and the admin media overview. **It does nothing visible until you
point it at a folder vocabulary** — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

The base module is just the folder data model. The editor-facing features come from
optional submodules; enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Browser** | `media_directories_browser` | The Vue.js media browser at `/admin/content/media-browser` with drag-and-drop folder management, a field widget, and CKEditor 5 integration. This is the one most people want. |
| **File link** | `media_directories_file_link` | A CKEditor 5 "Insert file link" button and a matching text filter. |
| **AI** | `media_directories_ai` | AI-generated alt text and translations in the browser. Requires `drupal/ai`. |
| **Image resize** | `media_directories_image_resize` | A text filter that physically resizes embedded images. |
| **Compat** | `media_directories_compat` | A text filter that converts legacy `<drupal-entity>` embeds to `<drupal-media>`. |
| **UI** | `media_directories_ui` | **Deprecated** — the old entity_browser-based UI. Do not use on new sites. |
| **Editor** | `media_directories_editor` | **Deprecated** — the old entity_embed / CKEditor 4 integration. Do not use on new sites. |

For example, to add the drag-and-drop browser:

```bash
drush en media_directories_browser -y
```

Each submodule requires the base Media Directories module, which is already present once
you have installed it above.
