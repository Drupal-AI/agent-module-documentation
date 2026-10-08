<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Entities Storage Client for media files adds a storage client that lets the External Entities module treat media files on disk as external entities, decorated with ID3/media metadata via the getID3 library.
---
The module provides a `@StorageClient('xnttmedia', label "Media files with ID3 data")` that extends External Entities' built-in `Files` storage client. It defaults the file type to "media" and registers a large set of media file extensions (audio, video and image containers — mp3, flac, wav, mp4, mkv, avi, jpg, png, pdf, zip, and many more). Its `parseFile()` calls the parent file parser and then, when the getID3 PHP library is available, runs `\getID3()->analyze()` on the file and merges the extracted tags/technical metadata (via `CopyTagsToComments()`) into the entity's field data; if getID3 is missing it warns and logs but still returns the base file data.

There is no admin settings page or global config — the module simply makes a new storage-client plugin selectable when you create an External Entity type. A `hook_requirements()` check reports whether the getID3 library is detected (error if missing). Config schema is inherited from the External Entities `files` storage client.

Setup: install the getID3 library (`james-heinrich/getid3`) and the External Entities module, enable this module and rebuild caches, then create an External Entity type and choose the "Media files with ID3 data" storage client, configuring the file-source settings the parent `Files` client exposes (directory, extensions, field mapping) to surface each media file — with its ID3 metadata — as an entity.

---

- Expose media files on disk as external entities
- Enrich file external entities with getID3 metadata
- Read ID3 tags and technical data from audio/video files
- Select the 'Media files with ID3 data' storage client for an entity type
- Surface mp3/flac/wav/mp4/mkv/avi and more as entities
- Merge media metadata into external entity field data
- Build a browsable catalog of media files without importing them
- Map ID3 fields to entity fields via the parent Files client settings
- Check getID3 library availability from the status report
- Handle a wide range of media/image/archive extensions
- Fall back gracefully (warn/log) when getID3 is missing
- Reuse the External Entities Files storage configuration UI
- Present audio metadata (artist, album, duration) as entity fields
- Query media files through Views like any external entity
- Avoid duplicating media files into Drupal's database
- Add media-as-data sources to an External Entities setup
