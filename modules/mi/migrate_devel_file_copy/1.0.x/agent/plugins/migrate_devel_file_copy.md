<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migrate_devel_file_copy — the `file_copy_or_generate` process plugin

## Usage in a migration
```yaml
process:
  uri:
    plugin: file_copy_or_generate
    source:
      - constants/source_base_path
      - filename
    # plus any core file_copy options (file_exists, move, etc.)
```
Drop-in replacement for `plugin: file_copy`; `$value` is `[source, destination]`.

## Behaviour (`FileCopyOrGenerate::transform`)
1. Calls parent `FileCopy::transform()`. If it succeeds (source present), returns normally.
2. On `MigrateException`:
   - If `file_exists($destination)` → return `$destination`.
   - If (`!file_exists($source)` and the message matches `/^File .+ does not exist$/`) OR the source is not a local URI:
     - Ensure `$dir` (destination directory) exists and is writable, else `prepareDirectory(CREATE_DIRECTORY | MODIFY_PERMISSIONS)`.
     - Lowercase the extension (so `iMaGe.JPEG` maps correctly), rewriting the destination.
     - `jpg|jpeg|gif|png|bmp` → `generateImage()` (`Random::image('200x200','600x600')`, preserving the original extension via a `FileSystem::move`); on any throwable it falls back to `generateText()`.
     - `txt` / default → `generateText()` writes four `*` characters with `file_put_contents`.
     - If nothing was produced → `MigrateSkipRowException`.
   - Otherwise re-throw the original exception.

## Notes
- Purely a dev/test aid; do not use to fabricate production content.
- All paths originate from the migration definition, not from HTTP input.
