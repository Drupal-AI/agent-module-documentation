<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processing pipeline, batch, Drush & service

All entry points (forms, batch, autosave submodule, Drush) funnel through one procedural function
in `entity_links_bulk_processor.module`.

## Core function

`entity_links_bulk_processor_process_attributes(string $text, array &$errors, array &$actions,
?string $langcode = null): string`

Steps (in order), each gated by a config flag from `entity_links_bulk_processor.settings`:

1. If `convert_d7_media_tokens`: `_..._convert_d7_media_tokens()` rewrites D7 WYSIWYG tokens
   `[[{"fid":...}]]` and shorthand `[[media:TYPE:ID]]` to `<drupal-media>` (looks up media by file
   id via `_..._find_media_by_d7_fid()` / `_..._find_media_by_fid()`; handles youtube/vimeo remote
   video).
2. Loads `$text` into `DOMDocument` (wrapped in a UTF-8 `<html><body>`), builds `DOMXPath`, iterates
   `//a[@href]`:
   - skips anchors already carrying `data-entity-uuid`; normalizes `#`-only anchors;
   - validates `mailto:` (`_..._validate_mailto` — `FILTER_VALIDATE_EMAIL`, lowercases),
     `tel:`/`sms:`/`fax:` (`_..._validate_tel|sms|fax` → `_..._format_phone_number` per
     `tel_format`, adds `tel_country_code`, 7–15 digit check);
   - `_..._convert_external_to_internal()` rewrites hrefs whose host matches
     `convert_external_domains`;
   - if `convert_file_paths`: `_..._convert_file_to_media()` maps `/sites/default/files/...` or
     `/system/files/...` to a media entity (DB lookup on `file_managed` + `media__<field>`);
   - handles `title` attributes (`remove_matching_title_attrs` / `report_mismatched_titles`);
   - `_..._parse_entity_path()` matches `/node|/media|/taxonomy/term/<id>`, else (if
     `resolve_path_aliases`) `_..._resolve_path_alias()` via `path_alias.manager` (+ optional
     cross-language scan and `_..._follow_redirect_chain()` on the `redirect` table); UUID from
     `_..._get_entity_uuid()`; sets `data-entity-type`/`-uuid`/`-substitution` (and `path_alias_format:
     system` rewrites the href).
3. If `convert_media_src`: rewrites `//img|video|source[@src]` absolute URLs to relative
   (`_..._convert_to_relative`).
4. If `remove_inline_styles`: strips `style` from `remove_inline_styles_elements` (unless a class in
   `remove_inline_styles_exclude_classes`).
5. If `css_class_mappings`: for every `//*[@class]`, applies mappings by priority — **custom
   selector** (`_..._css_to_xpath`) → **element-specific** → **wildcard `*`** — supporting an
   `exclude` selector; empty `to` removes the class.
6. If `convert_img_to_drupal_media` / `convert_video_to_drupal_media`: replace `<img>`/`<video>`
   with `<drupal-media>` (`_..._convert_img|video_to_drupal_media`, media matched by src via
   `_..._find_media_by_src`).
7. Serializes the `<body>` children back to a string.

`$errors[]` and `$actions[]` collect `[Rule] message` strings the callers log to CSV / show in
previews. UUID/media lookups use `accessCheck(false)` entity queries or the DB API (bulk
maintenance context, gated by the admin permission).

## Batch (UI)

`EntityLinksBulkProcessorForm::batchProcess($entity_type, $bundles, $ids, $log_settings,
$is_dry_run, &$context)` queries entities (`accessCheck(false)`), runs the core function on each
text field, saves changed entities (unless dry-run), and writes success/error/stats CSVs;
`::batchFinished()` reports totals. `ProcessNowForm` builds one operation per selected entity type.

## Drush command

`src/Drush/Commands/EntityLinksBulkProcessorCommands::processFields()` — command
`entity-links:bulk-process` (alias `elbp`), registered in `drush.services.yml` (args
`@entity_type.manager`, `@entity_links_bulk_processor.entity_type_discovery`). Options: `--filter`
(`node:* paragraph:basic ...`), `--ids`, `--languages`, `--default-language-only`, `--dry-run`,
`--backup=<path>` (runs `drush sql:dump` via `exec()` with `escapeshellarg`, optional interactive
restore), `--error-log`/`--success-log` (CSV), `--json` + `--fail-on-error` / `--fail-on-save-error`
(CI/CD). Sets state `entity_links_bulk_processor.processing = TRUE` so the autosave submodule stays
out of the way, previews samples, confirms (unless `--yes`/`--dry-run`), then processes and
rebuilds cache.

## Service `EntityTypeDiscovery`

`src/Service/EntityTypeDiscovery.php` (id `entity_links_bulk_processor.entity_type_discovery`):
`getEntityTypesWithTextFields()` returns content entity types that have a `text`/`text_long`/
`text_with_summary` field (via `entity_field.manager` field maps); `getCommonEntityTypes()` returns
`node, block_content, paragraph, media, taxonomy_term` (default UI selection).

## Discovery helpers

`_..._discover_css_classes_all_elements(entity_types, bundles, element_types, sample_size,
include_custom)` scans text-field tables with regex per element (and any custom element when
requested), returning `element => {class => count}`; used by `CssClassDiscoveryForm`.
