# Migrate process plugin: `flush_single_image`

`Drupal\flush_single_image\Plugin\migrate\process\FlushSingleImage` (`@MigrateProcessPlugin`
id `flush_single_image`). Flushes the existing derivatives of a file during a migration — useful
when a migration overwrites a file in place (same path, new content) and the old derivatives must
be cleared/rebuilt.

The plugin's **source value is the file's final destination URI** (typically the return of the
`file_copy` process plugin). It calls `service->flush($value, $action)` and returns `$value`
unchanged (pass-through).

## Configuration

| Key | Values | Default |
|---|---|---|
| `action` | `unlink` (delete derivatives) / `regenerate` (rebuild derivatives) | `unlink` |

An `action` other than empty/`unlink`/`regenerate` throws `\InvalidArgumentException` at construction.

```yaml
process:
  path_to_file:
    -
      plugin: file_copy
      source:
        - /path/to/file.png
        - public://new/path/to/file.png
    -
      plugin: flush_single_image
      action: 'regenerate'
```

This downloads/copies the file (replacing it) and then flushes every derivative previously created
for `public://new/path/to/file.png`.
