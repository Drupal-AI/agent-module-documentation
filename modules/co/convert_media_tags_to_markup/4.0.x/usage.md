Convert Media Tags to Markup fixes legacy Drupal 7 `media_wysiwyg` embed tokens (the `[[{"type":"media",...,"fid":"123",...}]]` JSON blobs left behind after a migration) by turning them into real `<img>` markup, either on the fly with a text-format filter or permanently in the database via a Drush-run helper.

---

The module provides one text filter plugin, `convert_legacy_media_tags_to_markup`
("Convert Legacy Media Tags to Markup", `TYPE_TRANSFORM_IRREVERSIBLE`), which you add to a
text format; on render it calls `App::filterText()`. That method regex-matches media tokens
(`/\[\[\{.*?"type":"media".+?\}\]\]/s`), JSON-decodes each, loads the referenced file by
`fid` (`File::load`), builds an absolute-then-relative file URL, and emits a fixed
`<div class="media …"><img …></div>` block using the token's `alt`, `title`, `class`,
`style`, `height`, and `width` attributes. A failed token (bad JSON, missing `fid`, unloadable
file) is logged to watchdog and replaced with an empty string (the filter as a whole falls back
to the original text on a top-level exception). For a one-time permanent conversion, the
`DbReplacer` singleton (`\Drupal\convert_media_tags_to_markup\ConvertMediaTagsToMarkup\DbReplacer::instance()->replaceAll($entity_type, $bundle, $simulate)`,
invoked via `drush ev`) loads every entity of a type/bundle, runs each formatted-text field
value through the same `filterText()`, and either prints a simulation (when `$simulate = TRUE`)
or saves the rewritten value (when `FALSE`). There is no admin UI, permission, config schema,
plugin type, or registered Drush command — it is a filter plus a code entry point.

---

- Render legacy D7 `media_wysiwyg` embed tokens as images without re-importing content.
- Add a text-format filter that converts `[[{"type":"media",...}]]` blobs to `<img>` on output.
- Clean up body fields after a Drupal 7 → 10/11 migration that left raw media JSON.
- Permanently rewrite media tokens to markup in the database with a Drush one-liner.
- Preview a bulk conversion in simulation mode before writing changes.
- Convert media tokens for a single entity type and bundle at a time (e.g. `node`/`page`).
- Restore broken images on migrated nodes where the Media module is no longer used.
- Keep the referenced file entity (by `fid`) as the image source during conversion.
- Preserve original `alt`, `title`, `class`, `style`, `width`, and `height` from the token.
- Fall back gracefully (empty image / original text) when a token's file is missing.
- Log conversion failures to watchdog for post-migration auditing.
- Batch-fix an entire content type's legacy embeds ahead of decommissioning old media handling.
- Apply the fix only on selected text formats (e.g. Full HTML) via the filter.
- Combine with revision creation so a bad bulk conversion can be reverted per node.
- Avoid maintaining the D7 Media module purely to display old embeds.
- Migrate embed markup once, then remove the runtime filter for performance.
- Handle multiple media tokens within a single field value in one pass.
- Produce consistent, theme-independent `<div class="media …">` image wrappers.
- Support Drupal 10 and 11 on PHP 8.
- Transform content during a staged content-cleanup project without editor effort.
