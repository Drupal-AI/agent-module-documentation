# `hook_media_duplicates_checksum_info_alter()`

Alter the discovered checksum plugin definitions. The most common use is to make an existing plugin
cover an **additional media source/type** without writing a new plugin — e.g. point a custom
file-based source at the built-in `file` plugin.

```php
/**
 * Implements hook_media_duplicates_checksum_info_alter().
 *
 * @param array $providers
 *   Checksum plugin definitions, keyed by plugin id.
 */
function my_module_media_duplicates_checksum_info_alter(array &$providers) {
  // Use the existing File checksum for a new file-based media source id.
  $providers['file']['media_types'][] = 'my_unique_file';
}
```

- Invoked by the plugin manager's `alterInfo('media_duplicates_checksum_info')`.
- `$providers` is keyed by plugin id; each definition has `id`, `label`, and `media_types` (the
  array of **media source plugin ids** it handles — this is what you usually extend).
- Definitions are cached (`media_duplicates_checksum_plugins` cache); run `drush cr` after changing
  the hook.

For a genuinely different fingerprinting strategy, implement a `MediaDuplicatesChecksum` plugin
instead — see [../plugins/checksum.md](../plugins/checksum.md).
