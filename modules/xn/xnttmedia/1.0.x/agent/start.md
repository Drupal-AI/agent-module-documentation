<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Entities Storage Client for media files (xnttmedia) — agent index

**An External Entities storage client exposing media files as external entities, enriched with getID3 metadata.**

- **Version:** 1.0.x (1.0.0-beta3) — core `^9 || ^10 || ^11`; depends on `external_entities` (>=3.0.0-beta4) and the `james-heinrich/getid3` library.
- **Plugin:** `@StorageClient('xnttmedia')` `MediaFiles extends Files`; `parseFile()` merges `\getID3()->analyze()` output (+ `CopyTagsToComments`) into field data when getID3 is present, else warns/logs and returns base file data.
- **Extensions:** wide media/image/archive set (mp3, flac, wav, mp4, mkv, avi, jpg, png, pdf, zip, …).
- **Config:** none of its own — selectable as a storage client when creating an External Entity type; `hook_requirements()` reports getID3 presence.
- **Security:** no routes/permissions/secrets; reads local files via the External Entities `Files` client. No network or mutating endpoints.
