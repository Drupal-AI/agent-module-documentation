# Adding a metadata column (the Filebrowser Extra pattern)

Filebrowser Extra is the canonical example of extending a directory listing with an extra
column. It is two event subscribers registered in `filebrowser_extra.services.yml`.

## 1. Declare the column — `filebrowser.metadata_info`

```php
// Drupal\filebrowser_extra\EventSubscriber\MetadataInfoEventSubscriber
public static function getSubscribedEvents(): array {
  $events['filebrowser.metadata_info'][] = ['setInfo', 0];
  return $events;
}
public function setInfo($event) {           // $event = Drupal\filebrowser\Events\MetadataInfo
  $data = $event->getMetaDataInfo();
  $data['modified'] = ['title' => t('Modified'), 'type' => 'integer'];
  $event->setMetaDataInfo($data);
}
```

## 2. Populate the column — `filebrowser.metadata_event`

`MetadataEventSubscriber` subscribes to `filebrowser.metadata_event` and sets the `modified`
value for each file. It is constructed with `@file_system`, `@date.formatter` and
`@entity_type.manager` (see the services file) so it can stat the file and format the mtime.

## 3. Register both — `*.services.yml`

```yaml
services:
  filebrowser_modified.metadata_info:
    class: Drupal\filebrowser_extra\EventSubscriber\MetadataInfoEventSubscriber
    tags: [{ name: event_subscriber }]
  filebrowser_modified.metadata_event:
    class: Drupal\filebrowser_extra\EventSubscriber\MetadataEventSubscriber
    arguments: ['@file_system', '@date.formatter', '@entity_type.manager']
    tags: [{ name: event_subscriber }]
```

## To write your own column

Copy this submodule, change the key (`modified` → e.g. `owner`), the `title`/`type` in
`setInfo()`, and the value logic in the `metadata_event` subscriber. The `type` hint
(`integer`, `string`, ...) tells Filebrowser how to treat the value in the listing table.
Enable your module alongside `filebrowser`; the new column appears in every listing.
