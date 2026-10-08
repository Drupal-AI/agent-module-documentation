<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_video — how the video is rendered

The block view display renders `field_ebt_video` with the `entity_reference_entity_view`
formatter in the **`ebt_video`** media view mode. Two per-bundle media view displays (shipped as
config) decide the actual output — there is no bespoke rendering PHP, and no raw URL is placed
into markup by this module.

## Remote video (`media.remote_video.ebt_video`)

`config/install/core.entity_view_display.media.remote_video.ebt_video.yml` renders the core oEmbed
field **`field_media_oembed_video`** with the **`glightbox_media_remote_video`** formatter
(provided by `glightbox_media_video`). Settings: `display: thumbnail`, `link_text: 'View Video'`,
`glightbox_gallery: post`, `loading.attribute: eager`, `glightbox_caption: auto`. Result: a
thumbnail that opens the provider's oEmbed player in a GLightbox popup. Because the source is a
core oEmbed Media field, the video URL is validated/normalized by core Media's oEmbed provider
handling — editors do not paste raw embed markup here.

## Local video (`media.video.ebt_video`)

`config/install/core.entity_view_display.media.video.ebt_video.yml` renders the core file field
**`field_media_video_file`** with the core **`file_video`** formatter (`controls: true`,
`autoplay: false`, `loop: false`, `muted: false`, `width: 640`, `height: 480`) — a standard HTML5
`<video>` element. Both displays hide `created`, `name`, `thumbnail`, `uid`.

## Block templates

`templates/block--block-content--ebt-video.html.twig` and
`templates/block--inline-block--ebt-video.html.twig` are near-identical wrappers:

- Build `ebt-block ebt-video …` classes, attach the `ebt_video/ebt_video` library, wrap output in
  `.bg-inner` + `.ebt-container`, print the optional label as `<h2>`, then render
  `{{ content|without('field_ebt_settings') }}` (rendered field output — already escaped).
- End with `{{ styles|raw }}` — the block's design CSS **string produced by EBT Core**
  (`ebt_core` builds it and `Html::escape()`s the dynamic parts), not by this module.

`templates/field--block-content--field-ebt-video--ebt-video.html.twig` is a stock field template
printing `item.content` per item.

## Assets

- `ebt_video.libraries.yml` defines library `ebt_video` → `css/ebt-video.css` (component).
- `css/ebt-video.css` adds a 64×64 play-button overlay (`img/play.svg`) on
  `.ebt-video .glightbox-media-video` via a `::before` pseudo-element.
