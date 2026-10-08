<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Files by Media (feeds_files_by_media) — agent index

**Feeds fetcher/parser/source that imports files into an entity by reading a Media field defined on the feed type.**

- **Version:** 1.0.x
- **Core:** ^9.4 || ^10.0 || ^11 · **Depends on:** feeds · **Package:** Custom
- **Plugins:** Fetcher `media_field` ("Fetch Resource from media field"), Parser `MediaFieldParser`, Source `file_of_media_field` exposing sources: target file id / file name / media item id / name / uuid of the media field.
- **Fetcher config:** `media_field_machine_name` (the media field on the feed type).
- **Security:** No routes, services or permissions; no outbound HTTP (files come from local media entities → no SSRF). Runs inside Feeds' own permission model. No findings.

See [configure/setup.md](configure/setup.md)
