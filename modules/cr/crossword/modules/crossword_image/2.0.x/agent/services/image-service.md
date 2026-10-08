<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `crossword.image_service` and image regeneration

## Install & enable

```bash
drush en crossword_image -y
```

Deps: base `crossword` + core `image`.

## `CrosswordImageService` (service `crossword.image_service`)

`src/CrosswordImageService.php` (interface `CrosswordImageServiceInterface`). Turns a crossword file
into a cached, managed image using a `crossword_image` plugin.

- `getImageUri(FileInterface $file, string $plugin_id)`: returns the image URI, generating it if
  missing or if the source file is newer than the cached image (`filemtime` comparison; the stale
  image is deleted + `image_path_flush`ed and rebuilt). Returns NULL if the file isn't a parseable
  crossword (`crossword.data_service::getData()` empty) or the plugin id is unknown.
- `getImageEntity(FileInterface $file, string $plugin_id)`: same, but returns/creates the managed
  `file` entity (via `loadByProperties(['uri'=>…])` or `saveImageEntity()`).
- `getDestinationUri()`: `{source-dir}/crossword/{fid}-{plugin}.{ext}` (or `public://crossword/…`
  when the source is at the public root). Extension from `image_type_to_extension($plugin->getType())`.
- `saveNewImageResource()`: gets the plugin's toolkit + `createImageResource($file)`, prepares the
  directory, `save()`s, and registers the file. `saveImageEntity()` marks it permanent and adds a
  `file_usage` row (`add($image, 'crossword', 'file', $sourceFid)`).

## Bundled `crossword_image` plugins

| id | class | image |
|---|---|---|
| `thumbnail` | `CrosswordThumbnail` | Empty grid (black/white squares). |
| `numbered_thumbnail` | `CrosswordNumberedThumbnail` | Grid with clue numerals drawn using `fonts/RobotoMono-Regular.ttf`. |
| `solution_thumbnail` | `CrosswordSolutionThumbnail` | Filled-in solution grid. |

All extend `CrosswordThumbnailBase` → `CrosswordImagePluginBase` (annotation `@CrosswordImage` with
`id` + `title`). Write a new plugin in `Plugin/crossword/crossword_image/` to add another image style;
it appears automatically in the formatter/media/token option lists
(`CrosswordImageManager::getCrosswordImageOptionList()`).

## `crossword_image_rendered` formatter

`src/Plugin/Field/FieldFormatter/CrosswordImageRendered.php` extends core `ImageFormatter`. Adds a
`crossword_image` select (which plugin) at weight -100 and restricts `image_link` options to Content /
Image / **Crossword File**. `defaultSettings()` = `['crossword_image' => 'thumbnail'] + parent`.
Schema `field.formatter.settings.crossword_image_rendered`.

## Regeneration form/route

`crossword_image.regenerate` (`/admin/config/media/crossword/regenerate`, permission **`administer
crossword images`**, menu under *Configuration → Media*). `CrosswordImageRegenerateForm` posts a
required checkbox list of image plugins; `submitForm()` calls
`CrosswordImageService::regenerateCrosswordImages($ids)`.

`regenerateCrosswordImages()` selects every `file_usage` row for module `crossword`, chunks the fids
(10 per batch op), and for each image parses `{fid}-{plugin}` out of the **image filename**, deletes
the old image, and rebuilds it with the matching plugin
(`crosswordImageRegenerateBatchOp`/`…BatchFinished` static callbacks). The form itself warns it is
**experimental**, resource-intensive, and best reserved for local development (back up files first) —
images are normally generated once and never updated, so this exists mainly for when you change a
`crossword_image` plugin.
