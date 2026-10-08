<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring File MIME

## Where and who
- Settings form: **Configuration → Media → File MIME** (`/admin/config/media/filemime`).
- Apply tab: `/admin/config/media/filemime/apply`.
- Both require the core **`administer site configuration`** permission. There is no module-specific
  permission — anyone who can edit site config can change how uploaded files are typed.

## The two inputs
The config object is `filemime.settings` with two string keys, both empty on install:

1. **`file` — Local mime.types file path.** A path such as `/etc/mime.types`. If the path is
   readable at map-build time it is read and parsed. The form tells you whether the currently
   configured path is readable. The file must use standard `mime.types` syntax.
2. **`types` — Custom MIME type mappings.** A textarea of `mime.types`-format lines. These are
   parsed **after** the file, so an entry here **overrides** the same extension from the file.

### Line format
Each non-empty line: `MIME/type ext1 ext2 ext3 …`. Whitespace-separated. A token starting with `#`
begins a comment and ends that line. Example:

```
audio/mpeg    mpga mpega mp2 mp3 m4a
audio/mpegurl m3u
audio/ogg     oga ogg opus spx
image/webp    webp
# this whole line is ignored
```

## How the mapping takes effect
The module registers `MimeTypeMapLoadedSubscriber` on core's `MimeTypeMapLoadedEvent`. When core
builds its extension→MIME map, the subscriber calls `$map->addMapping($type, $extension)` for every
parsed extension. It does not replace core's guesser; it augments the map core's guesser reads. New
uploads are typed with the updated map immediately after config is saved (clear caches if a mapping
does not seem to be picked up: `ddev drush cr`).

## Applying to already-uploaded files
Changing the map only affects **new** guesses. To restamp existing files:
1. Go to the **Apply** tab and confirm. It reports how many `file_managed` rows will be processed.
2. A batch runs over every file with a **local** stream scheme, re-guesses each with
   `file.mime_type.guesser`, and if the type changed calls `setMimeType()` + `save()`.
3. Each change is logged to the `filemime` logger channel (old → new → uri); a summary message
   reports files processed and updated. Remote/non-local stream files are skipped.

## Verify
- Inspect config: `ddev drush cget filemime.settings`.
- Upload a file with the affected extension and check its recorded MIME type (e.g. on the file's
  admin page, or the `filemime` column of `file_managed`).
- The type you set becomes the file's `Content-Type` on download, which is what changes
  display-vs-download behaviour, font loading, video playback, etc.

## Operational notes
- `filemime.settings` is ordinary exportable config — set it once and deploy across environments,
  or point `file` at a per-environment `mime.types` path.
- Uninstalling the module removes the subscriber and restores core's built-in map; it does not
  re-stamp files that were already saved with a custom type (run Apply, or reasses, before
  uninstalling if that matters).
- Because a mapping forces a label onto file bytes that were never inspected, keep core's
  extension-based upload validation as the real gate; do not map an unexpected/dangerous extension
  to a permissive type as a convenience.
