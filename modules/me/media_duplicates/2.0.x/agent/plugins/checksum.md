# The `MediaDuplicatesChecksum` plugin type

A checksum plugin decides **how** a media item's source is fingerprinted. One plugin is selected
per media *source plugin id* and used on presave to fill `duplicates_checksum`.

## Discovery

- Manager service: `plugin.manager.media_duplicates.checksum`
  (class `MediaDuplicatesChecksumPluginManager`, a `DefaultPluginManager`).
- Namespace: `Plugin/MediaDuplicatesChecksum`; annotation
  `@MediaDuplicatesChecksum`; interface `MediaDuplicatesChecksumInterface`.
- Alter hook: `media_duplicates_checksum_info` → `hook_media_duplicates_checksum_info_alter()`
  (see [../hooks/info-alter.md](../hooks/info-alter.md)).

## Annotation

```php
/**
 * @MediaDuplicatesChecksum(
 *   id = "my_checksum",
 *   label = @Translation("My checksum"),
 *   media_types = {"my_source_plugin_id", "another_source"},
 * )
 */
```

- `id` — plugin id.
- `label` — human label.
- `media_types` — array of **media source plugin ids** this plugin handles (e.g. `file`, `image`,
  `oembed`). The manager matches a media item's `getSource()->getPluginId()` against these.

## Interface & base class

`MediaDuplicatesChecksumInterface`:
- `getChecksum(Media $media): string|null` — the checksum (SHA-256 based) used to compare.
- `getChecksumData(Media $media): string` — the raw source data the hash is built from.

Extend `MediaDuplicatesChecksumBase` (implements `ContainerFactoryPluginInterface`). Its
`getChecksum()` calls your `getChecksumData()` and returns `Crypt::hashBase64($data)` (or NULL when
data is empty), so a minimal plugin only implements `getChecksumData()`:

```php
class MyChecksum extends MediaDuplicatesChecksumBase {
  public function getChecksumData(Media $media) {
    return $media->getSource()->getSourceFieldValue($media);
  }
}
```

## Built-in plugins

- **`file`** (`media_types = {file, image, audio_file, video_file}`) — overrides `getChecksum()` to
  SHA-256 hash the actual **file contents** (URL-safe base64) via the source field's File entity.
- **`oembed`** (`media_types = {oembed}`) — `getChecksumData()` returns the oEmbed source field
  value (hashed by the base class).

## Manager helpers

- `getDefinitionForMediaType($sourcePluginId)` — the plugin definition whose `media_types` contains
  that source id (handles deriver `:` suffixes by trimming). Throws `PluginException` if none.
- `createInstanceForMediaType($sourcePluginId)` — instantiate that plugin.

If a media item's source has no matching plugin, presave logs a warning and stores a NULL checksum
(the item is treated as un-fingerprinted and never blocked). Add a plugin (or the info-alter hook)
to cover new source types.
