<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content model: carousel + carousel_item

Two custom `ContentEntityType`s (both `RevisionableContentEntityBase`, revisionable,
translatable, `EntityOwnerTrait`). New/ownerless entities default owner to the anonymous user (uid 0).

## `carousel` — "Carousel" (`src/Entity/Carousel.php`)

An ordered collection referencing slides.

| Field | Type | Notes |
|---|---|---|
| `label` | string (255) | Title, required |
| `status` | boolean | Enabled/disabled (default TRUE) |
| `items` | entity_reference (`carousel_item`) | Unlimited cardinality — the ordered slide list |
| `uid` | entity_reference (user) | Author/owner |
| `created` / `changed` | created / changed | timestamps |

- `admin_permission = "administer carousel"`. Collection: `/admin/content/carousel`. Settings/field-UI base: `entity.carousel.settings` (`admin/structure/carousel`).
- `getItems()` returns `->referencedEntities()`.

## `carousel_item` — "Carousel Slide" (`src/Entity/CarouselItem.php`)

One slide. Exactly one visual source is expected but not enforced; templates check `media` → `base64_image` → `external_image` in order.

| Field | Type | Notes |
|---|---|---|
| `label` | string (255) | Slide title, required |
| `media` | entity_reference (media) | Media Library widget; resolves image/`video`/`remote_video` bundles |
| `video_options` | string | Player query params appended to YouTube/Vimeo embeds |
| `base64_image` | string_long | Inline data image pasted as base64 |
| `external_image` | link (external) | Image hosted elsewhere |
| `show_title` | boolean | default TRUE |
| `description` | **text_long** | Rich-text body — see security note below |
| `link` + `link_target` | link (int/ext) + list_string | CTA; target `_self`/`_blank`/`_parent`/`_top` |
| `item_background` | string (10) | Hex color, `color_widget`, default `#000000` |
| `background_opacity` | float | default 0.7 |
| `title_color` / `description_color` | string (10) | Hex colors, `color_widget`, default `#ffffff` |
| `text_alignment` | list_string | left/center/right/justify |
| `text_position` | list_string | flex-start/center/flex-end |
| `status` | boolean | Per-slide publish flag (default TRUE) |
| `uid` / `created` / `changed` | | ownership + timestamps |

- `admin_permission = "administer carousel_item"`. Collection: `/admin/content/carousel-item`. Settings/field-UI base: `entity.carousel_item.settings` (`admin/structure/carousel-item`).
- `getMedia()` resolves the referenced media into `{bundle, uri, alt, mime_type}`: `image` → `field_media_image`, `video` → `field_media_video_file`, `remote_video` → `field_media_oembed_video`.
- `getLink()` returns `{uri, title, target}`; `getUriFromString()` resolves `entity:` URIs to a path.

## Media / video embedding

`EasyCarouselTwigExtension` registers Twig `embed_url(url, options)` → `VideoUtils::getEmbedUrlFromVideo()`
(`src/Services/VideoUtils.php`), which detects YouTube/Vimeo by host/regex and returns a normalized
`youtube.com/embed/<id>` or `player.vimeo.com/video/<id>` URL (appending `video_options` for the
YouTube playlist-loop case). Non-YouTube/Vimeo URLs are returned unchanged. Templates render remote
videos inside a sandboxed `<iframe>`.

## Ownership lifecycle (`easy_carousel.module`)

`hook_user_cancel` unpublishes (block_unpublish) or anonymizes (reassign) a user's carousels/slides;
`hook_ENTITY_TYPE_predelete` for users deletes their carousels/slides and all revisions.
