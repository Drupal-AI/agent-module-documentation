<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio media type, fields, displays, permissions, hooks

Everything this module delivers is **installable configuration** under `config/optional/` (core Media
config) and `config/pack_acquia_cms_audio/` (Site Studio), plus two hook functions. There is no
settings route — `data.json.configure` is `null`.

## Install / enable

`composer require drupal/acquia_cms_audio` then enable it. Because dependencies include
`acquia_cms_common`, `media`, `media_library`, `media_entity_soundcloud` and `field_group`, those must
resolve first. The config in `config/optional/` installs only when its own dependencies are met (e.g.
`taxonomy.vocabulary.categories` / `.tags`, provided by other Acquia CMS packages) — otherwise those
fields are silently skipped, which is normal for optional config.

`hook_install($is_syncing)` (`acquia_cms_audio.install`): when **not** importing config, calls
`_acquia_cms_common_editor_config_rewrite()` (a helper from `acquia_cms_common`) to re-apply the shared
CKEditor configuration. It does nothing else.

## The media type

`config/optional/media.type.audio.yml`:
- `id: audio`, `label: Audio`, `source: soundcloud` (plugin from `media_entity_soundcloud`).
- `source_configuration.source_field: field_media_soundcloud`.
- `new_revision: true`, `queue_thumbnail_downloads: false`, `field_map: {}`.
- `third_party_settings.crop.image_field: null` (crop integration present but unset).

## Fields

- **`field_media_soundcloud`** — `field.storage.media.field_media_soundcloud.yml` (type `string`,
  max_length 255, cardinality 1) + `field.field.media.audio.field_media_soundcloud.yml`
  (label "Soundcloud audio URL", **required: true**, translatable). This holds the track URL and is the
  media source field.
- **`field_categories`** — `entity_reference` to taxonomy `categories` (target bundle `categories`,
  `auto_create: false`), not required.
- **`field_tags`** — `entity_reference` to taxonomy `tags` (target bundle `tags`, `auto_create: true`),
  not required.
- The storages for `field_categories` / `field_tags` are **not** shipped here (they come from
  `acquia_cms_common` / the shared content model); this module ships only the field instances.

## Form & view displays / modes

- Form displays: `core.entity_form_display.media.audio.default` and `.media_library`.
- View displays: `core.entity_view_display.media.audio.default`, `.embedded`, `.media_library`.
  The **default view display** renders only `field_media_soundcloud` with the `soundcloud_embed`
  formatter (`type: visual`, `width: 100%`, `height: 450`); name, thumbnail, uid, created,
  `field_categories`, `field_tags`, langcode and `search_api_excerpt` are hidden.
- View modes: `core.entity_view_mode.media.embedded`, `.media_library`; form mode
  `core.entity_form_mode.media.media_library`.
- `language.content_settings.media.audio.yml` enables content translation for the bundle.

## Permissions

`acquia_cms_audio.permissions.yml` declares five media permissions (each `provider: media`):
`create audio media`, `edit own audio media`, `delete own audio media`, `edit any audio media`,
`delete any audio media`. These are the standard core media bundle permission names for the `audio`
bundle; they gate create/edit/delete of audio media via core Media access.

`acquia_cms_audio_content_model_role_presave_alter(RoleInterface &$role)` (`.module`) implements the
Acquia CMS Common `hook_content_model_role_presave_alter`. On the `content_author` role it grants
`create audio media`, `edit own audio media`, `delete own audio media`; on `content_editor` it grants
`edit any audio media`, `delete any audio media`. This runs when Acquia CMS (re)builds its content-model
roles — so on a plain Drupal site without that role-build flow you assign the permissions manually.

## Site Studio component (optional)

`config/pack_acquia_cms_audio/` contains a Cohesion component **`cpt_audio`** ("Audio"), a
`cohesion_sync_package` (`pack_acquia_cms_audio`), a `sitestudio_file_metadata` entry and a preview
`Audio.png`. The component's `json_values` define a container → media-library **entity browser**
(restricted to the `audio` bundle, view mode `media.embedded`) plus an "Add space below" select and an
in-editor help panel. All of this config is `enforced: module: acquia_cms_site_studio` — so it only
installs on sites running Acquia CMS Site Studio; on a non-Site-Studio site it is inert.

## Operating notes

- No config schema ships (`config/schema/` absent), so no editable settings object exists for this
  module — behavior is fixed by the installed config above.
- To create audio: add a media item of type **Audio** and paste a SoundCloud track URL into
  "Soundcloud audio URL". Reference it from content via a media reference field or the media library.
- Uninstalling removes the module's enforced config (the `audio` type and its fields) per standard
  Drupal config dependency handling.
