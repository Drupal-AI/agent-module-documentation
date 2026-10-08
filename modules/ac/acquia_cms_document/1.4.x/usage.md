<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS — Document ships a ready-made **Document media type** — a file-based media bundle for locally hosted documents (PDF, Office, and other office/text formats) with its source file field, Categories and Tags taxonomy fields, form displays, view displays, and content translation already built. It is one feature module of the Acquia CMS content model and expects its shared layer, `acquia_cms_common`, to be present.

---

Acquia CMS (now "Acquia Drupal Starter Kit") is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Instead of a site builder creating a downloadable-document media type from scratch — the source file field with its extension allowlist, the taxonomy fields, the default and media-library form displays, the default and embedded view displays, content translation — this module delivers that as installed config, so the Document type exists and is editor-ready the moment it is enabled. The media type id is `document`, its source is the core `file` plugin, and its source field `field_media_file` accepts a fixed set of document/office extensions (`csv txt rtf pdf doc docx xls xlsx ppt pptx pps odt ods odp`). A little PHP declares the five per-bundle media permissions and grants them to the distribution's `content_author` and `content_editor` roles, and on install it rewrites editor config (via an `acquia_cms_common` helper) so documents can be embedded in text formats. The `field_categories`/`field_tags` field storages and the taxonomy vocabularies they reference are owned by `acquia_cms_common`, not by this module. The value and the limitation are the same fact: it is distribution configuration, not a generic feature. On an Acquia CMS site it is exactly right; on an unrelated site you inherit the whole model and its sibling dependency. There is no settings page — you operate it by editing the shipped config entities, and it travels with a config export like any other content configuration.

---
- Add a file-based Document media type to a site.
- Let editors upload and manage locally hosted documents (PDF, Office, text).
- Get a pre-built Document type with its source file field configured.
- Restrict document uploads to a specific set of office/text extensions.
- Provide Categories and Tags taxonomy fields on documents out of the box.
- Reuse Acquia CMS's Document model across sites.
- Standardise document media across a site.
- Get default and Media Library form displays for documents.
- Get a default (thumbnail) and an embedded view display for documents.
- Embed a document link in body text via the `embedded` view mode.
- Enable content translation for document media.
- Grant document-media create/edit/delete permissions to Acquia CMS roles.
- Assign the five per-bundle document permissions to custom roles.
- Skip building the Document media type and its displays by hand.
- Adopt Acquia CMS's Document configuration as a starting point.
- Base a custom document type on this one and extend it with extra fields.
- Match the Acquia CMS content model for documents.
- Export the Document config with the rest of the site config.
- Provide a consistent document editing experience across authors.
- Organise documents by category and free-tagging for search/listing.
- Add documents through the Media Library add flow.
- Auto-create tags on the fly while tagging a document.
