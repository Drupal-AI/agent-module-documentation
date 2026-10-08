Media Crowdriff adds a Drupal **media source** for [Crowdriff](https://crowdriff.com/) so editors can paste a Crowdriff embed code and reuse the resulting gallery/asset anywhere core Media works — entity reference fields, the Media Library, and CKEditor.

---

The module plugs into core Media with three plugins and one theme hook, and ships **no settings form, configure route, permissions, Drush commands, or config schema of its own**. Its media source plugin (`media_crowdriff`, allowed field type `string_long`) lets you create a Media type whose assets are Crowdriff embeds; a bespoke Media Library add form (`MediaCrowdriffMediaForm`, an `AddFormBase` subclass) provides an "Embed Code" textarea so editors paste the fragment copied from Crowdriff's share/embed dialog. A validation constraint (`media_crowdriff`) rejects anything that does not contain a Crowdriff id matching the regex `/(cr-init__|cr__init-)[a-z0-9]{8,}/`. A field formatter (`media_crowdriff`, for `string_long` fields, with `width`/`height` settings defaulting to `100%` / `900px`) extracts that id and renders the `media_crowdriff` theme hook, which emits Crowdriff's async loader `<script>` (`https://starling.crowdriff.com/js/crowdriff.js`) tagged with the embed id. Stored values are the raw embed code; the formatter only reveals the embed at display time. Setup is entirely core-Media UI: create a Media type, choose **Media Crowdriff** as its source, and use it like any other media source.

---

- Create a "Crowdriff" media type so editors can embed Crowdriff galleries as reusable media assets.
- Let editors paste a Crowdriff embed code into the Media Library and get a validated media entity.
- Embed a Crowdriff visual UGC gallery inside a node's entity-reference media field.
- Insert a Crowdriff gallery into body copy through the CKEditor media-embed (Insert Media) button.
- Reuse one Crowdriff asset across many pages by referencing the same media entity.
- Validate on save that a pasted fragment actually contains a Crowdriff id (`cr-init__…` / `cr__init-…`).
- Reject empty or malformed Crowdriff embed codes with a clear editor-facing error message.
- Render a Crowdriff embed at a fixed width/height (e.g. `640px` × `480px`) via the formatter settings.
- Render a Crowdriff embed full-width (`100%`) with the shipped default formatter settings.
- Centralise UGC/social-gallery management in Crowdriff while surfacing it in Drupal.
- Add Crowdriff galleries to landing pages built with Layout Builder media blocks.
- Give a marketing team a self-service way to drop approved Crowdriff galleries into content.
- Store the raw Crowdriff embed code as the canonical value and let the formatter inject the loader script.
- Use Crowdriff media in Views that list media entities of the Crowdriff type.
- Provide a media-library tab dedicated to Crowdriff embeds alongside image/video sources.
- Attach a Crowdriff gallery to a product or campaign page as a referenced media item.
- Standardise how Crowdriff embeds are added so every editor uses the same validated flow.
- Swap a Crowdriff gallery site-wide by editing one media entity's embed code.
- Show a Crowdriff gallery in a modal or sidebar by placing the media field there.
- Keep Crowdriff's async loader script scoped to the embed via the `media_crowdriff` template.
- Migrate existing hard-coded Crowdriff `<script>` snippets into managed media entities.
- Give non-technical editors a textarea that accepts the exact fragment from Crowdriff's embed dialog.
- Combine Crowdriff media with core Media's revisioning, access, and translation.
- Distinguish Crowdriff assets from other media by their dedicated media type and source.
