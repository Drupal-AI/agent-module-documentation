<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Files by Media extends the Feeds module so an import can pull files out of a feed type's own Media field instead of a remote URL or upload.

It provides three Feeds plugins: a fetcher ("Fetch Resource from media field") configured with the machine name of a media field on the feed type, a parser ("Media field parser") that reads the referenced media items, and a source plugin exposing mapping sources such as target file id, file name, media item id/name/uuid of the media field. During import, the fetcher returns a lightweight result carrying the configured field name; the parser resolves the media entities and yields per-item sources you map onto the destination entity's file/image or reference fields.

The module is a developer/site-builder integration driven entirely through the Feeds UI; it has no routes, controllers, services or permissions of its own, and performs no outbound HTTP — files come from already-uploaded local media entities, so there is no SSRF or remote-fetch surface. Typical setup: create a feed type, select this fetcher and parser, set the media field machine name, add a matching media field to the feed type, and map "Target file id of the media field" onto the destination file/image field (Reference by → File Id).
---
Feeds Files by Media imports files into an entity by reading a Media field on the Feeds feed type.
---
- Enable the module (requires the Feeds module).
- Create a Feeds feed type for the import.
- Select the "Fetch Resource from media field" fetcher.
- Select the "Media field parser" parser.
- Set the media field machine name in the fetcher configuration.
- Add a media field to the feed type using that machine name.
- Map "Target file id of the media field" onto a file/image field.
- Set the mapping's "Reference by" to File Id.
- Map "Target file name of the media field" where a name is needed.
- Map "Target media item id of the media field" to reference the media entity.
- Map "Target media item name of the media field" for labels.
- Map "Target media item uuid of the media field" for stable references.
- Import images into nodes from attached media.
- Populate an entity's file field from an existing media library item.
- Run the import via the Feeds UI.
- Schedule recurring imports through Feeds' periodic import.
- Reuse the same media field across multiple feed types.
- Combine with other Feeds parsers for mixed-source imports.
- Migrate legacy media references into file/image fields.
- Troubleshoot mappings using Feeds' import log.
