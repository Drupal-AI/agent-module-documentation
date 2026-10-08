<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Kit — component reference

All seven components are core `@Block` plugins under
`src/Plugin/Block/<Name>/<Name>.php`, extending `Drupal\layout_builder_kit\Plugin\Block\LBKBaseComponent`.
Each ships a Twig template registered via its `*EventSubscriber` (Hook Event Dispatcher `theme` event)
and CSS/JS via `layout_builder_kit.libraries.yml`. Shared fields on every component: `title`,
`display_title`, `classes` (CSS class string, added to the wrapper `<div>`).

## Rich Text (LBK) — `lbk_rich_text`
- Field: `text_format` (core CKEditor `text_format` element).
- Stored: `rich_text_component_fields.text_format` (`value` + `format`).
- Template `LBKRichText.html.twig` renders it as `{'#type':'processed_text'}` — HTML filtered by the
  chosen text format.

## Image (LBK) — `lbk_image`
- Fields: `title_position` (top/bottom), `image` (managed_file, required), `image_style`
  (none/thumbnail/medium/large), `image_alignment` (left/center/right), `overlay_text`
  (`text_format`), `overlay_position` (none/bottom).
- Upload dir + allowed extensions come from the module settings config.
- On build, the uploaded file is set permanent and rendered via `#theme => image` or
  `image_style`. Overlay text rendered via `processed_text`.
- Stored: `image_component_fields.*`.

## Icon Text (LBK) — `lbk_icon_text`
- Fields: `image` (managed_file), `media_position` (left/right), `alignment` (left/center/right),
  `link` (free-text URL, maxlength 200), `text` (`text_format`).
- Template `LBKIconText.html.twig` wraps the image and/or title in `<a href="{{ link }}">…</a>` when
  a link is set; body text rendered via `processed_text`.
- Stored: `icon_text_component_fields.*`. `blockValidate()` deliberately accepts any string for
  `link` ("accept all strings as valid").

## Video (LBK) — `lbk_video`
- Fields: `video_radio_options` (radios: 0 = Video URL, 2 = Video Fields), `video_url`
  (text, validated with `UrlHelper::isValid(..., TRUE)`), `video_field` (select of eligible
  string/text/link/file/video_embed_field fields on the current entity/bundle).
- `getVideoEmbedUrl()` recognises `vimeo.com/`, `youtube.com/watch`, `youtu.be/`,
  `youtube.com/embed` and rewrites to a `player.vimeo.com` / `youtube.com/embed` URL; anything else
  returns an empty string. The result is placed in an `<iframe src>`.
- For a `video_embed_field` source the rendered field markup is output directly; for a `file` source
  a `<video>` element points at the file URL.
- Field rendering checks `$entity->access('view')` before reading a field.
- Stored: `video_component_fields.*`.

## Render (LBK) — `lbk_render`
- Fields: `render_type` (node/media), `node_id` / `media_id` (entity_autocomplete),
  `view_mode_node` / `view_mode_media` (selects). JS (`LBKRender.js`) toggles which inputs show.
- On build, loads the chosen entity and renders it with
  `entityTypeManager->getViewBuilder(type)->view($entity, $view_mode)`, then `renderer->render()`,
  output as `{{ entity }}` in `LBKRender.html.twig`.
- Media rendering requires the core Media module (guarded).
- Stored: `render_component.*` (config carries a `version` marker, currently "1.1").

## Tab (LBK) — `lbk_tab`
- AJAX form builds an unlimited list of tabs; each tab is either `custom_text` (a `text_format`
  field) or `block` (a select of content blocks, module/system plugin blocks, or node fields).
- Buttons: "Add custom text", "Add block", "Remove last tab" (all AJAX). Plus a `tabs_default_text`
  string shown when there are no tabs.
- On build: custom-text tabs render via `processed_text`; block tabs load and render the chosen
  `BlockContent`/`Block`/node field. Front-end tab switching via `LBKTab.js` (jQuery).
- Stored: `lbk_tab.tab_content[]` (`type`, `name_tab`, and either `text_format` or `name`).

## Book Navigation (LBK) — `lbk_book_navigation`
- Field: `toc_url` (free-text "Table of Contents URL", maxlength 200).
- Requires the core **Book** module (injects `book.outline_storage`). Only renders on a Book-type
  node's layout: shows the active section's parent title, sibling child links, an optional
  Table-of-Contents link (built with `Url::fromUri($toc_url)` via the `LinkProvider` service), and a
  "next section" link.
- `getBookDescription()` reads `field_book_description` from the Book node if present.
- Stored: `book_navigation_component_fields.toc_url`.

## Services

- `layout_builder_kit.link_provider` (`LinkProvider`) — helper wrapping `Link::fromTextAndUrl()`,
  used by Book Navigation.
- Seven `event_subscriber_lbk_*` services — the theme-registration subscribers described above.
