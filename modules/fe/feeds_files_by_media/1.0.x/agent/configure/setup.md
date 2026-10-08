<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importing files from a Media field with Feeds

1. **Enable** `feeds_files_by_media` (Feeds is a hard dependency).
2. **Create a feed type** (Structure → Feed types).
3. **Fetcher:** choose *Fetch Resource from media field* and set **Machine name of the media field** in its settings (e.g. `field_source_media`).
4. **Parser:** choose *Media field parser*.
5. **Add the media field** to the feed type: create a media-reference field whose machine name matches the fetcher setting from step 3.
6. **Mapping** (feed type → Mapping tab):
   - Add a mapping from source **Target file id of the media field** to your destination file/image field.
   - Open that mapping's configuration and set **Reference by → File Id**.
   - Optionally map file name, media item id/name/uuid sources for labels or references.
7. **Run** the import from the feed. Files are taken from the already-uploaded media entities referenced on the feed — nothing is fetched remotely.

Available mapping sources (from `MediaFieldSource`): `target_file_id_of_media_field`, `target_file_name_of_media_field`, `target_media_item_id_of_media_field`, `target_media_item_name_of_media_field`, `target_media_item_uuid_of_media_field`.
