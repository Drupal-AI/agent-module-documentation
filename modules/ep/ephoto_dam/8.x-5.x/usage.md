<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ephoto DAM adds a CKEditor 5 button that lets editors browse their Ephoto digital-asset-management library and embed remote images, videos and documents directly into content.

---

Ephoto DAM (module machine name `ephoto_dam`, package "Ephoto Dam") is a connector for the Ephoto Dam SaaS digital-asset-management platform. It ships a CKEditor 5 plugin whose toolbar button opens the Ephoto asset chooser (served by your Ephoto server), and a text-format filter that turns the chosen assets into `<img>` or `<iframe>` embed markup on the rendered page. The only Drupal-side configuration is the URL of your Ephoto server; authentication with Ephoto happens in the browser against that server. The module depends on core `ckeditor5` and `system`, targets Drupal 10 and 11, and has an optional `ephoto_dam_field` submodule that adds an Ephoto asset field type for storing asset URLs on entities instead of embedding them inline.

---

- Embed images from an Ephoto Dam library into a node body via CKEditor 5.
- Embed Ephoto-hosted videos as responsive iframes inside rich text.
- Embed Ephoto-hosted documents (PDF and similar) as iframe previews.
- Give content editors a single "Ephoto Dam" toolbar button that opens the DAM chooser.
- Point Drupal at your organisation's Ephoto server by setting one Server URL.
- Standardise the display width of imported images, videos and documents per text format.
- Show captions under embedded media, built from an editor-defined caption format.
- Auto-populate captions from Ephoto file metadata fields using `[fieldName]` placeholders.
- Enable click-to-zoom on embedded images for site visitors.
- Toggle zoom per image with a right-click context menu inside the editor.
- Keep brand consistency by sourcing all media from one central Ephoto library.
- Let a communications team maintain assets in Ephoto while editors reuse them in Drupal.
- Reference remote assets rather than uploading copies into Drupal's file system.
- Add the Ephoto button to any text format (for example Full HTML) that uses CKEditor 5.
- Restrict who can embed assets by controlling which roles get the enabling text format.
- Attach Ephoto asset URLs to entities as structured field data (via the `ephoto_dam_field` submodule).
- Support multiple asset versions on a field when Ephoto version support is enabled.
- Localise the editor UI (French and Spanish translations are bundled).
- Configure per-format image, video and document display sizes without code.
- Provide editors a searchable path to existing brand assets from within the WYSIWYG.
- Migrate an inline-embed workflow toward a fielded workflow using the submodule.
- Preview thumbnails of selected assets while editing a field.
- Keep media governance centralised while still publishing through Drupal.
