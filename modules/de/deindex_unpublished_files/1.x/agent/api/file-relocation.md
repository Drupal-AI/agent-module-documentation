<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File relocation on media publish-state change

## Trigger

`MediaHooks::mediaPresave(MediaInterface $media)` (`src/Hook/MediaHooks.php`), registered as
`hook_media_presave` two ways: the attribute `#[Hook('media_presave')]` on the method (service
`deindex_unpublished_files.hooks.media`, `autowire: true`), and a `#[LegacyHook]` procedural shim
`deindex_unpublished_files_media_presave()` in `deindex_unpublished_files.module` (resolves the
service via `class_resolver`) for Drupal 10.1–11.0 back-compat.

Injected services (`MediaHooks::create()`): `file_system`, `config.factory`, `entity_type.manager`.

## Guard logic

1. Return early if `$media->isNew()`.
2. Load the unchanged original via `entity_type.manager` storage `loadUnchanged($media->id())`; return
   if none.
3. Compare `$original->isPublished()` (`$was_published`) vs `$media->isPublished()` (`$is_published`);
   **return if unchanged** — it acts only on a published↔unpublished transition.
4. Read `unpublish_mode` from `deindex_unpublished_files.settings` (may be `null` → no branch runs).
5. Iterate `$media->getFields()`, act only on fields whose type is `file`, and on each
   `referencedEntities()` file.

Then it computes a `$new_uri` per mode and, if set, calls
`file_system->move($original_uri, $new_uri, <FileExists::Rename>)`; on success it
`$file->setFileUri($new_path); $file->save();`. `getFileExistsMode()` returns `FileExists::Rename`
(with a `DeprecationHelper` fallback to `EXISTS_RENAME` on older core), so a name collision renames
rather than overwrites.

## Mode `move`

- Unpublish (`!$is_published`) + file in `public://`: strips `public://`, encodes the source
  subdirectory into the filename as `"<relative_path>__<basename>"` (when the dir is non-empty and not
  literally `public:`), and targets `private://unpublishedfiles/<encoded_name>`.
- Republish (`$is_published`) + file already in `private://unpublishedfiles/`: reverses it — if the
  basename contains `__`, splits once into `[$folder, $real_filename]` → `public://<folder>/<real_filename>`;
  otherwise `public://<basename>`.

Requires a configured `private://` stream and an existing `private://unpublishedfiles/` dir (enforced
by `SettingsForm::validateForm()`). Files served from `private://` go through Drupal's file-download
access pipeline; **this module adds no `hook_file_download`, so it does not itself grant access** —
access to the moved file is decided by core/media as normal.

## Mode `prefix`

- Unpublish + basename does not already contain `.ht_`: rename in place to `<dirname>/.ht_<basename>`.
- Republish + basename contains `.ht_`: `str_replace('.ht_', '', $original_uri)` to restore.

Protection relies on the web server denying dotfiles / `.ht*` (Drupal's default `.htaccess` does;
nginx needs equivalent rules). The file keeps its stream (e.g. stays in `public://`) but under a
denied name.

## Operational notes

- Every transition changes the file **URI** (and, if renamed on collision, the basename) — confirm
  references still resolve after a publish/unpublish cycle.
- Only media types with a `file` field are affected (image/svg_image media store their file in a
  file-type field too, but the hook iterates `getFieldDefinition()->getType() === 'file'`).
- Relocation happens at presave inside the media save; the file entity is re-saved with the new URI.
