# Services / API

Three public services do the work; call them from your own code, a Drush command,
or an event subscriber. Both exporter and importer drive the Batch API, so they are
normally invoked from a CLI/batch context.

## `default_content_deploy.exporter` — `ExporterInterface`

Class `Drupal\default_content_deploy\Exporter`. Configure with setters, then call
`export()` (queues a batch), or export one entity synchronously.

Key methods:

- `setMode(string $mode)` — one of `default`, `reference`, `all` (throws otherwise).
- `setEntityTypeId(string)` (validates it is a content entity type), `setEntityBundle(string)`,
  `setEntityIds(array)`, `setSkipEntityIds(array)`, `setSkipEntityTypeIds(array)` / `getSkipEntityTypeIds()`.
- `setFolder(string)`, `setForceUpdate(bool)` (deletes the folder first),
  `setTextDependencies(?bool)`, `setSkipExportTimestamp(?bool)`, `setVerbose(bool)`.
- `setDateTime(\DateTimeInterface)` / `getDateTime()` / `getTime()` — export only entities changed since.
- `setLinkDomain(string)` / `getLinkDomain()` — HAL `_links` domain (defaults to current host).
- `export(): void` — runs the configured batch.
- `exportEntity(ContentEntityInterface $entity, ?bool $with_references = FALSE): bool` — export one entity (and, optionally, its references) immediately.
- `getSerializedContent(ContentEntityInterface $entity, bool $add_metadata): string` — return the `hal_json`+metadata JSON the importer expects. For `user` entities it adds `pass` (the stored hash); adds `_dcd_metadata.export_timestamp` when `$add_metadata` and timestamps aren't skipped.

```php
$exporter = \Drupal::service('default_content_deploy.exporter');
$exporter->setMode('reference');
$exporter->setEntityTypeId('node');
$exporter->setEntityIds([12]);
$exporter->setFolder('../content');
$exporter->export(); // then run the batch (drush_backend_batch_process() in CLI)
```

## `default_content_deploy.importer` — `ImporterInterface`

Class `Drupal\default_content_deploy\Importer`. Configure, `prepareForImport()` to
scan+plan, then `import()` to queue the batch.

Key methods: `setFolder(string)`, `setForceOverride(bool)`, `setPreserveIds(bool)`,
`setIncremental(bool)`, `setDelete(bool)`, `setVerbose(bool)`, `prepareForImport()`,
`getResult(): array` (planned create/update + path-alias + delete file objects),
`import(): void`, `decodeFile(object $file): void` (read + `hal_json`-decode one file).

```php
$importer = \Drupal::service('default_content_deploy.importer');
$importer->setFolder('../content');
$importer->setForceOverride(FALSE);
$importer->prepareForImport();
$importer->import();
```

`scan()` walks the folder recursively for `*.json` files; each file's entity type is
its parent directory name and its UUID is the filename. A `_deleted/` subfolder is
scanned only when `setDelete(TRUE)`.

## `default_content_deploy.manager` — `DeployManager`

Helper service. Methods: `getEntityUuidById($entity_type, $id): string`,
`getContentEntityTypes(): array` (content entity types that have a UUID key, keyed by
ID → label), `getContentFolder(): ?string` (the configured `content_directory` or
NULL), `getCurrentHost(): string`, `compressContent(): void` /
`uncompressContent(string $file): void` (tar.gz the export folder for download / untar
an uploaded archive into `{temp}/dcd/content`).

## `default_content_deploy.metadata` — `DefaultContentDeployMetadataService`

Plain value object shared between the overridden normalizers and the importer to
carry old-ID→UUID maps, export timestamps, and per-UUID "correction required" flags
across a batch.

## Container overrides (`DefaultContentDeployServiceProvider::alter()`)

Swaps in DCD's own HAL normalizers/resolver so deployment round-trips cleanly:
replaces `serializer.entity_resolver.uuid` (→ `UuidResolver`),
`serializer.normalizer.entity.hal` (→ `ConfigurableContentEntityNormalizer`),
`serializer.normalizer.field_item.hal` (→ `ConfigurableFieldItemNormalizer`), and
registers higher-priority normalizers for `file` entities/fields and (if
`menu_link_content` is enabled) menu links.

## Hook it invokes

`hook_cron` (`default_content_deploy_cron`) — see `configure/settings.md`
(`batch_ttl` garbage collection). For export/import extension points, see
`events/events.md`.
