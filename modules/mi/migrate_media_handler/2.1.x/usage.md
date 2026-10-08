<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Media Handler provides Migrate process plugins that turn Drupal 7 file fields, video link fields, and inline WYSIWYG `<img>`/`<a href>` references into Drupal media entities during migration.

---

Moving a Drupal 7 site that did not use the D7 Media module onto Drupal's media system is tedious: each file field and each inline image/document link has to become a file entity, then a media entity, then a reference. This module centralises that work in a `MediaMaker` service and exposes it as reusable process plugins: `update_file_to_image`, `update_file_to_document`, `update_file_to_audio` (chained after core `migration_lookup`), `update_link_to_video` (YouTube URL → remote_video), and two `migrate_plus` DomProcessBase plugins, `dom_inline_image_handler` and `dom_inline_doc_handler`, that rewrite rich-text `<img>` and PDF `<a>` tags to `<drupal-media>` embeds. A `record_media_ref` plugin stores a SHA1 hash of each file in a `field_original_ref` text field added to every media bundle on install, so later lookups can find already-migrated media by file hash and avoid duplication.

Behaviour and settings: MediaMaker reads `migrate_media_handler.settings` (`site_uri` regex, `file_source`/`file_dest` paths, `file_owner`, per-bundle field names, and `img_replace`/`doc_replace` attribute maps). The README stresses overriding these with `drush config-set` rather than editing the shipped file. `field_original_ref` is added by `hook_install` and removed on uninstall. This is migration-time developer tooling run under Drush/CLI: there are no runtime routes, no permissions, and no user-facing endpoints. Entity queries deliberately use `accessCheck(FALSE)`, which is appropriate for a trusted migration context; `makeFileEntity()` copies file contents with `file_put_contents(... file_get_contents($path))` from the operator-configured source path.

---

- Convert D7 image file fields to media reference fields with `update_file_to_image`
- Convert D7 document file fields to media with `update_file_to_document`
- Convert D7 audio file fields to media with `update_file_to_audio`
- Convert D7 YouTube link fields to remote_video media with `update_link_to_video`
- Rewrite inline `<img>` tags in body text to `<drupal-media>` via `dom_inline_image_handler`
- Rewrite inline PDF `<a href>` links to media embeds via `dom_inline_doc_handler`
- Chain both DOM plugins to process images and documents in one pass
- Record a file-hash reference with `record_media_ref` to dedupe media
- Avoid duplicate media by looking up existing entities by SHA1 file hash
- Carry alt/title from the D7 source into new image media (`source_field`, `update_with_alt`)
- Carry display/description onto document or audio media
- Target a non-default media bundle with `target_bundle`
- Set the source/destination file paths via `file_source` and `file_dest` settings
- Point `site_uri` at the production domain regex to resolve full-path links
- Assign migrated files to a specific owner via `file_owner`
- Add project-specific attributes to `<drupal-media>` output via `img_replace`/`doc_replace`
- Override settings with `drush config-set` then export to config
- Stub-lookup files first with core `migration_lookup` (`no_stub: true`)
- Auto-create file+media when `migration_lookup` finds no existing file
- Reuse `MediaMaker` public methods from custom migration code
- Clean up the temporary `field_original_ref` field by uninstalling the module
- Skip inline base64 PNG images during rich-text processing
- Migrate multilingual media by passing the source `language` property
- Handle http/https, vfs, and relative source paths via `getSourceFilePath`
