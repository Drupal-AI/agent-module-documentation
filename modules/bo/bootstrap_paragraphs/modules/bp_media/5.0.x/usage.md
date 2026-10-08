<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Media ships a ready-made `bp_media` Paragraph bundle that places a core Media entity — an image or a remote video — into a Bootstrap-styled section, optionally wrapped in a link, with a heading and the suite's shared width/background/margin/padding controls.

---

The module is **config plus one Twig template**: no services, no plugins, no permissions, no settings form and no configure route. Unlike its sibling bundles it depends on core `media` **and** `media_library`. Installing it imports `paragraphs.paragraphs_type.bp_media` and seven field instances. Only one has a storage of its own: `bp_media`, an `entity_reference` (cardinality 1) targeting `media`, whose handler settings restrict the target bundles to `image` and `remote_video` with `auto_create: false`. The other six — `bp_header`, `bp_link`, `bp_width`, `bp_background`, `bp_margin`, `bp_padding` — reuse storages owned by the parent `bootstrap_paragraphs` module. The form display uses the core **`media_library_widget`** for the media reference (so editors pick from the Media library rather than uploading inline), `link_default` for the link, `string_textfield` for the header, and `options_select` for the four list fields, of which `bp_background`, `bp_margin`, `bp_padding` and `bp_width` are tucked into a collapsed `field_group` **Styles** details element. The view display renders the referenced media with `entity_reference_entity_view` in the `default` view mode, the link with `link_separate`, and every list field with the `list_key` formatter so the raw value string reaches the template. `bp_media.module` implements only `hook_theme()` (registering `paragraph__bp_media`) and `hook_help()`. The template attaches the parent's `bootstrap_paragraphs/bootstrap-paragraphs` library, builds its class list directly from the stored field values, adds a `paragraph--id--<pid>` class, and — when `bp_link` is set — wraps the whole rendered media in an `<a>`, which is how you make a clickable image or video poster.

---

- Drop a Media-library image into a page without adding an image field to every content type.
- Embed a remote video (YouTube/Vimeo via core's `remote_video` media type) inside a page section.
- Make an image clickable by filling in the paragraph's Link field.
- Give a media section an `<h2>` heading via the shared `bp_header` field.
- Reuse one media entity across many pages instead of re-uploading the same file.
- Constrain editors to approved media types — the field only allows `image` and `remote_video`.
- Widen the allowed media types (e.g. add `document`) by editing `field.field.paragraph.bp_media.bp_media` handler settings.
- Set section width per instance (`paragraph--width--tiny` … `paragraph--width--full`).
- Apply one of 58 shared background classes to a media section.
- Add vertical spacing with the shared `bp_margin` values (`mt-3 mb-3`, `mt-5`, …).
- Add internal padding with the shared `bp_padding` values (`pt-3 pb-3`, `pt-5`, …).
- Keep the four styling selects out of the way in a collapsed "Styles" field group.
- Force editors through the Media library UI rather than ad-hoc uploads (`media_library_widget`).
- Change the view mode used to render the referenced media by editing the view display's `bp_media` formatter settings.
- Enable the Media bundle on an existing node paragraphs field by adding `bp_media` to its target bundles.
- Nest media sections inside a `bp_columns` or `bp_callout` paragraph for richer layouts.
- Build an image gallery row by placing several `bp_media` paragraphs inside a columns bundle.
- Override `paragraph--bp-media.html.twig` in a theme to change the media section markup.
- Target one media section in CSS or JS via its generated `paragraph--id--<pid>` class.
- Create media paragraphs programmatically during a migration with `Paragraph::create(['type' => 'bp_media', …])`.
- Audit which nodes embed media by querying paragraph entities of type `bp_media`.
- Swap the media widget for the plain autocomplete on sites that do not want the Media library modal.
- Hide `bp_link` from the form display on sites where media should never be clickable.
- Ship media-section configuration as exported config so it deploys identically across environments.
- Give a marketing team a single reusable "hero media" building block instead of bespoke fields.
