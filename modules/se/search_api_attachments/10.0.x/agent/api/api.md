# Hooks & programmatic surface

Defined in `search_api_attachments.api.php`. Both hooks are invoked from the
`file_attachments` processor during indexing.

## Control what gets indexed — `hook_search_api_attachments_indexable()`

```php
/**
 * @param object $file            A file entity.
 * @param \Drupal\search_api\Item\ItemInterface $item  The item the file was referenced in.
 * @param string $field_name      The field the file came from.
 * @return bool|null              Return FALSE to skip indexing this file.
 */
function hook_search_api_attachments_indexable($file, ItemInterface $item, $field_name) {
  if (in_array($item->getOriginalObject()->uid, my_module_blocked_uids())) {
    return FALSE;
  }
}
```

Called from `FilesExtractor::isFileIndexable()` after the built-in checks (exists on disk,
permanent, allowed MIME/extension, under max filesize, private-file policy). Any FALSE return
excludes the file.

## React after extraction — `hook_search_api_attachments_content_extracted()`

```php
/**
 * @param object $file  The file whose content was just extracted.
 * @param \Drupal\Core\Entity\EntityInterface $entity  The entity it was referenced in.
 */
function hook_search_api_attachments_content_extracted($file, EntityInterface $entity) {
  // e.g. mark related entities for reindex when a media file changes.
}
```

Invoked once per file right after successful extraction (before caching returns on later runs).

## Plugin alter hook

`hook_text_extractor_info_alter(array &$definitions)` — modify discovered TextExtractor plugin
definitions.

## Services (for reference)

- `plugin.manager.search_api_attachments.text_extractor` — the TextExtractor plugin manager
  (see [../plugins/plugins.md](../plugins/plugins.md)).
- `search_api_attachments.cache` / `search_api_attachments.cache_factory` — extraction cache
  (`get($file)` / `set($file, $text)`), keyvalue or files backend.
- `search_api_attachments.extract_file_validator` (`ExtractFileValidator`) — MIME/extension,
  size and private-file checks; `DEFAULT_EXCLUDED_EXTENSIONS` constant.
