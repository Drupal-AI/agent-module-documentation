<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# filefield_to_mediafield — Drush command

Single Drush command; there is no UI. Run it after a migration to copy legacy
file/image field values into an already-existing (empty) core Media field on the
same entities.

## Command
`drush filefield-to-media:copy` (alias `fftm`)

Positional args (with defaults):
1. `file_field_name`  (`field_image`) — source file/image field to read from.
2. `media_field_name` (`field_image_media`) — target media-reference field to fill.
3. `media_bundle`     (`image`) — media type to create (`image` maps alt/title/width/height; anything else maps display/description).
4. `media_entity_file_field_name` (`field_media_image`) — the file/image field *on the media entity*.
5. `entity_type`      (`node`) — entity type to iterate.
6. `bundle`           (optional) — restrict to one bundle; omit to process all bundles of the type.

Option: `--no-reuse` — disable de-duplication. By default the command hashes
(`sha1_file`) existing media files and reuses a matching media entity instead of
creating a duplicate; pass `--no-reuse` when hashes misbehave, when the media
field config is non-default, or when you need per-instance alt/title text.

## Example
```
drush fftm field_image field_image_media image field_media_image node article
```
Copies `field_image` on `article` nodes into `field_media_image` media, referenced
from `field_image_media`.

## Operational notes
- The target media field must exist and should be empty before running.
- Created media entities are owned by user 1 (`uid = 1`) and published.
- Take a database backup first; the command mutates every matched entity.
- Progress and errors are logged to the `filefield_to_mediafield` log channel.
- Deleting a media entity clears its stored hash (`hook_media_delete`).
