<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `create_media_tamper` — Create Media from a URL

The module's entire behavior. A [Tamper](https://www.drupal.org/project/tamper) plugin that takes
a file URL from a Feeds source value and resolves it to a Media entity, returning the media's id.

- **Plugin id:** `create_media_tamper`
- **Label / description:** "Create Media Tamper" · **category:** `Other`
- **Class:** `Drupal\feeds_tamper_media_url\Plugin\Tamper\CreateMedia` (extends
  `Drupal\tamper\TamperBase`, annotation `@Tamper`)

Because it is a Tamper plugin, it is added to a **Feeds Type source** on the *Tamper* screen of a
Feeds importer (Feeds Tamper UI), not from any admin settings page — this module ships no routes,
permissions or config.

## Settings (Tamper configuration form)

| Key | Constant | Widget | Meaning |
|---|---|---|---|
| `media_type` | `SETTING_MEDIA_TYPE` | `select` of `MediaType::loadMultiple()` | Media **bundle** to create (e.g. `image`, `document`, `video`). Default `''`. |
| `media_field` | `SETTING_MEDIA_FIELD` | `textfield` | Machine name of the **file/image field** on that bundle to populate (e.g. `field_media_image`). Default `''`. |

`buildConfigurationForm()` builds the select from every media type's `id() => label()`;
`submitConfigurationForm()` saves both values via `setConfiguration()`.

## What `tamper($data, $item)` does, step by step

`$data` is the incoming value — expected to be a file URL string.

1. **Empty guard** — if `$data` is empty, return it unchanged (no media).
2. **Derive filename** — `getFileName()` = `\Drupal::service('file_system')->basename($url)`,
   trimmed, then everything after a `?` is dropped (query string removed). (An `$extension` is
   computed but not used.)
3. **Look up an existing file** — `findFile()` calls
   `entityTypeManager()->getStorage('file')->loadByProperties(['filename' => $file_name])` and
   returns the first match, or `FALSE`.
4. **Download if absent** — target path is `public://{filename}`. If no file matched, it fetches
   the URL with a **Guzzle** `GET` (`getContent()` → `new GuzzleHttp\Client(); $client->request('GET', $url)`;
   a status ≥ 400 makes it return `false`) and writes the body via `writeData()`
   (`\Drupal::service('file.repository')->writeData($data, 'public://{filename}', 0)`), producing a
   managed `file` entity. On `EntityStorageException | FileException` `writeData()` returns `FALSE`.
5. **Find or create media** — `findMedia($fid, $media_field)` looks up a `media` entity whose
   `media_field` already references the file id. If none, it creates one:
   ```php
   Media::create([
     'name' => $file_name,
     'bundle' => $media_type,
     'uid' => 1,
     'langcode' => 'en',
     'status' => 1,
     $media_field => ['target_id' => $file->id(), 'alt' => $file_name, 'title' => $file_name],
   ])->save();
   ```
6. **Return** `$media->id()` — so the Feeds target this Tamper feeds should be a **media-reference**
   field.

## Behavioral notes

- **Idempotent by filename.** Matching is on the file *filename* (URL basename), not on URL or
  hash. Re-importing the same basename reuses the existing file and media; two different URLs that
  end in the same basename collide onto the same file.
- **Public scheme only.** Files always land in `public://`; the media owner is hardcoded to
  `uid = 1` and langcode to `en`.
- **No dependency metadata.** `feeds_tamper_media_url.info.yml` lists no dependencies; you must have
  `media` plus the `tamper`/`feeds_tamper`/`feeds` stack enabled for this to be usable.
- **Setup recipe** (from the project page): create a Feeds Type, map a source carrying the file URL
  to a media-reference field, add this Tamper to that source, and pick the media type + media field.
- Designed for browser-accessible URLs; the project notes it currently targets images.
