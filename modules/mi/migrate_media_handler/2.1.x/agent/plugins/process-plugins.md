<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Media Handler — process plugins

All file plugins run *after* core `migration_lookup`, which resolves the D7 file to a
destination file id. If lookup finds nothing, the plugin creates the file + media itself.

## update_file_to_image
```yaml
field_image:
  - {plugin: migration_lookup, source: field_old_image, migration: example_file, no_stub: true}
  - plugin: update_file_to_image
    source_field: field_old_image   # optional: pulls alt/title
    update_with_alt: true           # optional
    target_bundle: picture          # optional (default: image)
```

## update_file_to_document / update_file_to_audio
Same shape; optional `source_field` pulls `display`/`description`. Default bundles
`document` / `audio`.

## update_link_to_video
No file migration needed — converts a D7 video URL to a `remote_video` media (oEmbed).
```yaml
field_video:
  - {plugin: update_link_to_video, source: field_old_video}
```

## dom_inline_image_handler / dom_inline_doc_handler
Extend migrate_plus `DomProcessBase`; wrap between `dom` import/export steps. They scan
`//img` (skipping inline `image/png`) and PDF `<a href>` tags, create media, and replace
the node with `<drupal-media data-entity-uuid=...>`, adding attributes from the
`img_replace`/`doc_replace` settings. Chainable:
```yaml
'body/value':
  - {plugin: dom, method: import, source: 'body/0/value'}
  - plugin: dom_inline_doc_handler
  - plugin: dom_inline_image_handler
  - {plugin: dom, method: export}
```

## record_media_ref
Stores the SHA1 file hash into `field_original_ref` so later migrations dedupe by hash.

## Settings (override via `drush config-set migrate_media_handler.settings <key> <val> -y`)
`site_uri` (regex for your prod domain), `file_source`, `file_dest`, `file_owner`,
`image_field_name`/`document_field_name`/`audio_field_name`/`video_field_name`,
`img_replace`, `doc_replace`. Do not edit the shipped `config/install` file directly.
