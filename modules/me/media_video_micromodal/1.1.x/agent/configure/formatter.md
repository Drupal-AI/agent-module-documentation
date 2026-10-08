# micromodal_field_formatter

The module's only feature. Configured on *Structure → Media types → {type} → Manage display*
(no global settings page). Requires the media type to expose the core oEmbed URL field
`field_media_oembed_video` (i.e. the core `remote_video` type, or a copy of it).

## Where it applies
`isApplicable()` restricts the formatter to fields on **`media`** entities. In practice you set it on
one of three fields of the remote-video media type, and the behavior branches on field type:

| Field you format | Field type | Trigger rendered | Relevant setting |
|---|---|---|---|
| Thumbnail (oEmbed auto image) | `image` | styled `<img>` | `thumbnail_image_style` |
| A custom thumbnail (image/media ref) | `entity_reference` | styled `<img>` | `thumbnail_image_style` |
| Name (or another string field) | `string` | text link | `string_classes`, `link_text`, `caption_swap` |

## Settings (schema `field.formatter.settings.micromodal_field_formatter`)
- `thumbnail_image_style` (string) — image style for image/media-reference triggers. **If empty for an
  image/media trigger, nothing renders** (the settings summary prints a warning).
- `string_classes` (string) — space-separated extra CSS classes added to the text link `<span>`
  (only for `string` fields). Escaped with `Html::escape()`.
- `link_text` (string, translatable) — custom text for the link instead of the media name. Supports
  **tokens** when the `token` module is enabled (token type = the media entity type).
- `caption_swap` (bool) — adds a `caption-swap` class and attaches the `caption_swap` library, which at
  runtime replaces the link contents with the enclosing `<figure>`'s `<figcaption>` and removes the
  figcaption. Meant for CKEditor media embeds that carry a caption.

## What it outputs
For each media item that has `field_media_oembed_video`, `viewElements()`:
1. Reads the remote video URL from `field_media_oembed_video`.
2. Rebuilds the signed **local** oEmbed iframe URL via
   `Url::fromRoute('media.oembed_iframe', [], ['query' => ['url' => $video_url, 'max_width' => 0,
   'max_height' => 0, 'hash' => IFrameUrlHelper::getHash(...)]])` (uses the site `PrivateKey`), so the
   modal loads Drupal's own hashed oEmbed endpoint, not the raw remote URL.
3. Builds the trigger (styled thumbnail image, or a text link/span).
4. Renders theme hook `media_video_micromodal` with `#media`, `#view_mode`, `#modal_id` (unique id
   `modal-media-<mid>-<delta>-<field>`), `#linked_item`, `#iframe_src`.

Template `templates/media-video-micromodal.html.twig` outputs a `.modal.micromodal-slide` dialog
containing `<iframe src="{{ iframe_src }}">` and a trigger `<a data-micromodal-trigger="{modal_id}">`.
Theme suggestions: `media_video_micromodal__{entity_type}_{bundle}` and
`…__{entity_type}_{bundle}_{view_mode}` — override per bundle/view mode.

## Libraries
- `media_video_micromodal/micromodal` — **external** `https://unpkg.com/micromodal@0.4.10/dist/micromodal.min.js`.
- `media_video_micromodal/micromodal_libraries` — `js/micromodal-init.js` (calls `MicroModal.init()`,
  resets the iframe `src` on close to stop playback) + `css/micromodal.css`.
- `media_video_micromodal/caption_swap` — attached only when `caption_swap` is on.

## Using it in CKEditor and Views
- **CKEditor:** enable Media Library, check the "Embed media" filter on the text format, and under the
  filter's "View modes selectable" include the view mode(s) whose display uses this formatter. Insert
  via "Insert from Media Library", then Edit Media to pick the view mode (tick Caption for Caption Swap).
- **Views:** add a "Rendered entity" field/row using a media view mode configured with the formatter.

## Notes
- The library loads from a public CDN (unpkg). For an offline/locked-down site, override the
  `micromodal` library to a self-hosted copy via `hook_library_info_alter()`.
- `link_text` runs through `Html::escape()` before optional token replacement.
