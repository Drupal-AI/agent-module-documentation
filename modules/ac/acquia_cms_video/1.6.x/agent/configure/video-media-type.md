# Video media type

This module has **no settings form**. Its behavior is the config it installs (as `config/optional`, so
it loads once its dependencies exist). Everything below is editable afterwards through the media-type UI,
`drush cget/cset`, or config sync — this module just supplies the defaults.

## The media type — `media.type.video`

| Key | Value |
|-----|-------|
| `id` / `label` | `video` / "Video" |
| `description` | "Remotely hosted videos from external sources, e.g. YouTube, Vimeo." |
| `source` | `oembed:video` (core Media oEmbed source) |
| `source_configuration.source_field` | `field_media_oembed_video` |
| `source_configuration.providers` | `YouTube`, `Vimeo` (allowlist) |
| `source_configuration.thumbnails_directory` | `public://oembed_thumbnails` |
| `queue_thumbnail_downloads` | `false` (thumbnail fetched during save, not via cron queue) |
| `new_revision` | `true` |

The `providers` list is the allowlist core enforces on the entered URL — only YouTube and Vimeo URLs are
accepted. To allow more providers, add to that list, e.g.:

```
drush cset media.type.video source_configuration.providers.2 'Dailymotion' -y
```

## Fields on the `video` bundle

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `field_media_oembed_video` | string (max 255) | yes | The source field; label "Remote video URL". Storage `field.storage.media.field_media_oembed_video` is shipped by this module. |
| `field_categories` | entity_reference → `taxonomy_term` | no | Target vocabulary `categories`; `auto_create: false`. |
| `field_tags` | entity_reference → `taxonomy_term` | no | Target vocabulary `tags`; `auto_create: true` (typing a new tag creates the term). |

The `field_categories` / `field_tags` **storages and the `categories`/`tags` vocabularies are not shipped
here** — they come from `acquia_cms_common`. If common is absent those two field configs simply do not
install (they list those configs as dependencies). Content translation is enabled on the bundle
(`language.content_settings.media.video`).

## Displays

- **Form (`media.video.default`)**: order = name, `field_media_oembed_video` (`oembed_textfield`),
  langcode, then a `field_group` fieldset **"Taxonomy"** (`group_taxonomy`) wrapping `field_categories`
  (`options_select`) and `field_tags` (`entity_reference_autocomplete_tags`), then uid, created.
- **View `default` (`media.video.default`)**: shows `thumbnail` (image style `thumbnail`, lazy-loaded),
  `uid` (author), `created`; the oEmbed field and taxonomy fields are hidden — i.e. the default view is a
  poster/thumbnail, not the player.
- **View `embedded` (`media.video.embedded`)**: renders `field_media_oembed_video` with the core `oembed`
  formatter at `max_width: 960`, `max_height: 540` — this is the actual video player, used by the media
  library / embed button.
- **Extra view mode `media.video_component`** ("Video component"): declared for the Site Studio content
  templates in `config/pack_acquia_cms_video` (a Cohesion component `cpt_video_media` + templates). Those
  are optional Site Studio config and only relevant when `acquia_cms_site_studio` is installed.

## Config-schema note

The module defines **no `config/schema`**; the installed objects validate against core Media / Field /
field_group / core display schemas. `provides_config_schema` is therefore false.
