<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Tamper Media URL (feeds_tamper_media_url) — agent index

Provides one **Tamper plugin** that turns a **file URL** in an imported Feeds row into a **Media
entity** and returns the media's ID. Despite the project name it is purely a Tamper plugin, so it
runs wherever Tamper plugins are consumed — a Feeds importer being the usual case. Core
requirement `^10 || ^11`. No routes, no permissions, no admin config, no config schema.

- Plugin id: **`create_media_tamper`** (label "Create Media Tamper", category `Other`),
  class `Drupal\feeds_tamper_media_url\Plugin\Tamper\CreateMedia` extends `TamperBase`.
- The info file declares **no dependencies**, so install/enable `feeds`, `feeds_tamper`, `tamper`
  and core `media` yourself before using it.
- Two per-plugin settings, set on the Tamper configuration form (not module config):
  `media_type` (select of media bundles) and `media_field` (text field naming the file/image
  field on that bundle).
- The mapped Feeds target should be a **media-reference** field — `tamper()` returns the created
  (or matched) media entity's **id**.

## What you'd do → where

- **Configure and use the `create_media_tamper` plugin, its settings, and exactly what it does
  with the URL at import time (lookup / download / file + media creation)** →
  [plugins/create-media.md](plugins/create-media.md)

## Key facts (real names)

- Whole module is one file: `src/Plugin/Tamper/CreateMedia.php` (plus `.info.yml`, `README.txt`,
  `LICENSE.txt`). No `.services.yml`, `.routing.yml`, `.permissions.yml`, `config/`.
- Setting constants: `SETTING_MEDIA_TYPE = 'media_type'`, `SETTING_MEDIA_FIELD = 'media_field'`.
- `defaultConfiguration()` sets both to `''`. `buildConfigurationForm()` renders a `select` of
  `MediaType::loadMultiple()` and a `textfield` for the media field name.
- `tamper($data, $item)`: `$data` is the URL string. Empty URL → returned unchanged. Otherwise it
  derives a filename (`getFileName()` = `file_system->basename()`, query string stripped), looks up
  an existing `file` entity by `filename`, downloads + writes to `public://{filename}` if absent,
  then finds-or-creates a `media` entity of bundle `media_type` with `media_field` → the file id,
  and returns `$media->id()`.
- Created media defaults: `uid = 1`, `langcode = 'en'`, `status = 1`, `name` = filename.
- Idempotent by filename: re-importing the same basename reuses the existing file and media rather
  than re-downloading.
- Intended for browser-accessible file URLs (project notes it currently targets images).
