<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Video ships a ready-made **Video media type** for remotely hosted video — a core oEmbed source limited to **YouTube** and **Vimeo**, with its source field, taxonomy fields, form and view displays, an embed view mode, and its media permissions all pre-built. It is one feature module of the Acquia CMS (Acquia Drupal Starter Kit) distribution.

---

Acquia CMS is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Instead of a site builder hand-building a video asset type — the oEmbed source and provider allowlist, the "Remote video URL" field, the categories/tags references grouped in a fieldset, a thumbnail-first default display and a separate embedded player display, the per-bundle permissions — this module installs that configuration as a unit so the Video type exists and is editor-ready the moment it is enabled. It carries almost no code: a role-presave hook auto-grants the Video permissions to the distribution's `content_author` and `content_editor` roles, `hook_install` rewrites the text-editor config so the media-library video embed works, and two update hooks maintain an optional Site Studio template pack. The value and the limitation are the same fact: it is distribution configuration, not a generic feature. It encodes Acquia's opinions and expects its siblings — chiefly `acquia_cms_common`, which supplies the `categories`/`tags` vocabularies and field storages — to be present. On an Acquia CMS site it is exactly right; on an unrelated site it is a strong set of assumptions, usable as a starting point but inheriting the whole model. Because it is configuration, what it does is fixed by that config, and extending it means adding fields and adjusting displays as with any media type; it travels with a config export like any other.

---
- Add a YouTube/Vimeo Video media type to a site without building it by hand.
- Let editors add a remote video by pasting its URL into a "Remote video URL" field.
- Restrict embedded video to an allowlist of oEmbed providers (YouTube, Vimeo).
- Add more providers by extending `media.type.video` `source_configuration.providers`.
- Get a thumbnail-first default media display for video out of the box.
- Get a separate `embedded` view mode that renders the actual oEmbed player at 960×540.
- Reuse Acquia CMS's Video content model across sites.
- Categorise and tag video with the shared `categories`/`tags` vocabularies.
- Auto-grant Video create/edit/delete permissions to Acquia CMS content roles.
- Grant `edit any`/`delete any video media` to an editor role.
- Provide a consistent Video editing form with a grouped Taxonomy fieldset.
- Enable Video media as part of an Acquia CMS install.
- Translate Video media items (content translation is enabled on the bundle).
- Base a custom video media type on this pre-built one.
- Extend the Video media type with extra fields and displays.
- Wire the media-library video embed button into CKEditor automatically.
- Provide a "Video component" view mode for Site Studio layouts.
- Export the Video media configuration with the rest of the site config.
- Standardise how remote video is stored and displayed site-wide.
- Skip manually configuring oEmbed thumbnails and revisions for video.
- Match the Acquia CMS media model when migrating content in.
- Give a new Acquia CMS site an editor-ready video asset type on enable.
