# Events & subscribers

## `PostCreateIndexDocumentEvent`

`Event\PostCreateIndexDocumentEvent` (extends `Drupal\Component\EventDispatcher\Event`). Dispatched by
`VragenAiBackend::indexItem()` **after** the `DocumentItem` has been filled from the Search API item but
**before** it is written to Vragen.ai. Use it to enrich or veto a document.

Constructor `($item, $document, $index, bool $shouldIndex = TRUE)`. Accessors:

- `getItem(): ItemInterface` — the Search API item being indexed.
- `getDocument(): DocumentItem` — the prepared Vragen.ai document; call `->fill([...])` to change
  `content`, `url`, `mime_type`, `meta_data`, `attachments`, etc.
- `getIndex(): IndexInterface`.
- `shouldIndex(?bool $value = NULL): bool` — call with `FALSE` to skip indexing. If a document already
  exists remotely, the backend then **deletes** it instead of writing.

```php
// mymodule.services.yml: tag with { name: event_subscriber }
public static function getSubscribedEvents(): array {
  return [PostCreateIndexDocumentEvent::class => 'onPostCreate'];
}

public function onPostCreate(PostCreateIndexDocumentEvent $event): void {
  if ($event->getItem()->getDatasource()->getEntityTypeId() === 'node') {
    $event->getDocument()->fill(['meta_data' => ['source' => 'drupal']]);
  }
  // Or veto:
  // $event->shouldIndex(FALSE);
}
```

## Bundled subscriber — `search_api_vragen_ai.index_events_subscriber`

`EventSubscriber\IndexEventsSubscriber` subscribes to `PostCreateIndexDocumentEvent`
(`onPostCreateIndexDocument`). It implements the "index PDFs via Media" behavior: non-Media items are
untouched; Media items are vetoed unless their source field is a `file` whose mime type is
`application/pdf`, in which case the document is rewritten with `content = NULL`,
`url = file->createFileUrl(FALSE)`, `mime_type = application/pdf` so Vragen.ai extracts the PDF.
Media-type resolution uses `DeprecationHelper::backwardsCompatibleCall` for D11 compatibility.

## Bundled subscriber — `search_api_vragen_ai.mapping_events_subscriber`

`EventSubscriber\MappingEventsSubscriber` subscribes to Search API's mapping events
(`SearchApiEvents::MAPPING_FIELD_TYPES`, `MAPPING_VIEWS_FIELD_HANDLERS`, `MAPPING_VIEWS_HANDLERS`) and
maps the `vragen_ai_attachment` data type to `string` / `search_api_text` / `string` so attachment
fields work as normal string-ish fields in Views. `getSubscribedEvents()` guards against a fatal during
install by returning `[]` when `SearchApiEvents` is not yet loadable.
