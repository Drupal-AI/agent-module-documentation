<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — extraction service, field, formatter, event

## `ExtractorManager` service
`Drupal\file_extractor\Service\ExtractorManager` (autowired; also aliased to
`ExtractorManagerInterface`). Get it via `\Drupal::service(ExtractorManager::class)` or DI.

- `extract(FileInterface $file): string` — the entry point. Returns extracted text, `''` on
  non-indexable / failure. Steps:
  1. `isFileIndexable($file)` — file exists, MIME not in excluded extensions, file is **permanent**,
     under `max_filesize`, and (unless `exclude_private` allows) not `private://`; then dispatches
     `FileIndexableEvent` (other modules may veto).
  2. Cache lookup in the `file_extractor` bin, cid
     `extraction:<fid>:<sha256(serialize(extraction_result settings))>`. Miss → run the configured
     plugin, then `set()` permanent with tags = file cache tags + `config:file_extractor.settings`.
  3. `limitBytes()` truncates to `number_first_bytes` via `mb_strcut`.
- `setExtractionSettings(array $settings): void` — override the extraction settings for this manager
  instance (merged over current). Used by the formatter's per-instance override and by the Test form.

## Computed base field on `file`
`hook_entity_base_field_info` (in `src/Hook/EntityTypeInfo.php`) adds a computed `string_long` field
`file_extractor_extracted_file` to `file` entities, class
`ExtractedFileFieldItemList`. Its `computeValue()` calls `ExtractorManager::extract()` for the file and
stores a single item (index 0) when non-empty. Read it like any field: `$file->get(
'file_extractor_extracted_file')->value`.

## Field formatter
`file_extractor_extracted_text` (`ExtractedText`, extends `FileFormatterBase`, for `file` field types).
- Settings: `override_global_extraction_settings` (bool) + `extraction_settings` (same shape as global).
  When override is on, it calls `setExtractionSettings()` before extracting.
- `viewElements()` renders each referenced file as `#markup => extractorManager->extract($file)` with the
  file's cache tags. (`#markup` is filtered through core's admin XSS filter on render.)

## `FileIndexableEvent`
`Drupal\file_extractor\Event\FileIndexableEvent` — dispatched during `isFileIndexable()`. Subscribe to it
to programmatically allow/deny extraction of a specific file:
```php
public static function getSubscribedEvents(): array {
  return [FileIndexableEvent::class => 'onIndexable'];
}
public function onIndexable(FileIndexableEvent $event): void {
  if (/* some rule on */ $event->getFile()) {
    $event->setIndexable(FALSE);
  }
}
```

## Update services
`FileExtractorUpdater` (`update9101()` and static `update9101PrepareNewSettings()`) migrate the old flat
extraction-settings structure to the new `extractable` / `extraction_result` nesting across global config,
view/form displays, Views, and Layout Builder sections — invoked from `.install` / `.post_update.php`.
Not part of the runtime API.
