# The Document media type and installed config

This module has **no settings form** (`configure` is null). Everything is shipped as config in
`config/optional/` and installed when the module and each dependency are present. To change any of it
after install, edit the config entity in the UI (`admin/structure/media/manage/document`) or
export/override with `drush config:export` / `drush config:set`. There is no `config/schema/` and no
runtime config object of the module's own — nothing to set via a settings API.

## The media type

`media.type.document` — id `document`, label "Document", description "Locally hosted documents.",
source plugin `file`, `source_configuration.source_field: field_media_file`, `new_revision: true`,
`queue_thumbnail_downloads: false`, `field_map: {}`. Carries an enforced `acquia_cms_document`
dependency.

## Fields on the `document` bundle

| Field | Config file(s) | Type | Notes |
|---|---|---|---|
| `field_media_file` | `field.storage.media.field_media_file` + `field.field.media.document.field_media_file` | file | The **source field**. Required, translatable, cardinality 1, `uri_scheme: public`, `file_directory: '[date:custom:Y]-[date:custom:m]'`, `file_extensions: 'csv txt rtf pdf doc docx xls xlsx ppt pptx pps odt ods odp'` (document/office formats only), `handler: 'default:file'`, `description_field: false`. |
| `field_categories` | `field.field.media.document.field_categories` | entity_reference → taxonomy `categories` | Field **instance** only; the storage (`field.storage.media.field_categories`) and `categories` vocabulary come from `acquia_cms_common`. `auto_create: false`, sorted by term name asc. |
| `field_tags` | `field.field.media.document.field_tags` | entity_reference → taxonomy `tags` | Instance only; storage/vocabulary from `acquia_cms_common`. `auto_create: true`, sorted by term name asc. |

Because `field_categories`/`field_tags` reference config owned by `acquia_cms_common`, those instances
(and any display region referencing them) only install when `acquia_cms_common` is present. The
`field_media_file` storage is defined by this module.

The `file_extensions` allowlist above is the set the upload widget accepts; add or remove extensions by
editing `field.field.media.document.field_media_file` (do not widen it without cause — it is deliberately
limited to non-executable document formats).

## Form displays

Two, both grouping the taxonomy fields in a `field_group` fieldset labelled **Taxonomy** (requires the
`field_group` module):

- `core.entity_form_display.media.document.default` — `field_media_file` uses the `file_generic` widget
  (`progress_indicator: throbber`); `field_categories` uses `options_select`; `field_tags` uses
  `entity_reference_autocomplete_tags` (`match_operator: CONTAINS`, `match_limit: 10`); `name` uses
  `string_textfield`. Hides `created`/`path`/`status`/`uid`.
- `core.entity_form_display.media.document.media_library` — for the Media Library form mode
  (`core.entity_form_mode.media.media_library`). Same taxonomy group and widgets, but **hides
  `field_media_file`** (the file is supplied by the Media Library add flow).

## View displays

- `core.entity_view_display.media.document.default` — renders `thumbnail` with the core `image`
  formatter using `image.style.card`, plus `created` (timestamp, medium) and `uid` (author). Hides
  `field_media_file`, `field_categories`, `field_tags`, `langcode`, `name`, `search_api_excerpt`.
- `core.entity_view_display.media.document.embedded` — for the `embedded` view mode
  (`core.entity_view_mode.media.embedded`, provided elsewhere). Renders `field_media_file` with the
  `file_default` formatter (`label: visually_hidden`, `use_description_as_link_text: true`); everything
  else hidden. This is the display used when a document is embedded in body text.

## Translation

`language.content_settings.media.document` enables content translation for the `document` bundle
(`default_langcode: site_default`, `language_alterable: true`, `content_translation.enabled: true`).
Requires the `content_translation` module.

## Overriding

There is nothing to configure through code — adjust the shipped config entities directly. To add a field
to the type, add it as you would to any media bundle
(`admin/structure/media/manage/document/fields`) and it exports with your site config. Uninstalling the
module does not remove `config/optional` objects that other modules now depend on; the media type carries
an enforced `acquia_cms_document` dependency.
