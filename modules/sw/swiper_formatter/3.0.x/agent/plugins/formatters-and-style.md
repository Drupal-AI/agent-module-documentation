<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters & Views style

The module does **not** define new plugin *types*; it provides plugins for core's field
formatter and Views style types. Each renders content as a Swiper slider driven by a chosen
Swiper template (config entity).

## Field formatters (8)

Set one as a field's formatter on *Manage display*
(`core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.type`).

| Formatter id | Field types | Extends | Purpose |
|---|---|---|---|
| `swiper_formatter_image` | `image` | core `ImageFormatter` | image field → slider |
| `swiper_formatter_image_dialog` | `image` | `SwiperImages` | image slider, slides open in a modal |
| `swiper_formatter_entity` | `entity_reference` | `EntityReferenceEntityFormatter` | referenced entities → slides |
| `swiper_formatter_entity_dialog` | `entity_reference` | `SwiperEntity` | entity slider, modal slides |
| `swiper_formatter_paragraphs` | `entity_reference_revisions` | ERR entity formatter | Paragraphs → slides |
| `swiper_formatter_paragraphs_dialog` | `entity_reference_revisions` | `SwiperParagraphs` | Paragraphs slider, modal slides |
| `swiper_formatter_text` | `text`, `text_long`, `text_with_summary` | core text formatter | text deltas → slides |
| `swiper_formatter_text_dialog` | `text`, `text_long`, `text_with_summary` | `SwiperText` | text slider, modal slides |

Common formatter settings (schema `field.formatter.settings.swiper_formatter_*`), defaults
from `SwiperInterface::DEFAULT_SETTINGS`:
- `template` (default `default`) — which Swiper template config entity to use.
- `caption` — a field to render as each slide's caption (removed from the slide body).
- `destination` — token-built link destination (nullable).
- `swiper_access` — bool, in-place admin access toggle.
- image formatter adds `custom_link`; entity/paragraphs add `view_mode` + `link`.
- `*_dialog` formatters add a `dialog_*` group (`dialog_target`, `dialog_view_mode`,
  `dialog_type`, `dialog_title`, `dialog_width`/`dialog_height`, `dialog_autoresize`, and
  `ui-dialog*` CSS class overrides). The modal is served by route
  `swiper_formatter.dialog` (`/swiper-formatter/{entity_type}/{entity_id}/{view_mode}/{field}/{delta}/{field_item}`,
  controller `Controller\Dialog::dialog`, permission `access content`).

`viewElements()` builds the normal formatter output, then hands it to
`swiper_formatter.base` (`processElements()` → captions/lazy/links → `renderSwiper()`).

## Views style

`@ViewsStyle(id = "swiper_formatter")` — class `…\Plugin\views\style\SwiperFormatterStyle`,
theme `swiper_formatter`, `usesRowPlugin = TRUE`. Options (schema `views.style.swiper_formatter`):
- `template` (default `default`) — Swiper template.
- `caption` — a Views field to use as slide caption (unset from the row output).
- `custom_link` — custom link.
- `id` — the DOM id of this Swiper instance (auto-generated unique `swiper-<view>-<display>`
  so multiple sliders can coexist on a page).

Pick it under *Format* in a View. When exactly one or two fields are used and one is an
`image` field, the style switches to image mode (supports lazy loading + image-style
backgrounds via `parseLinear()`/`lazyLoad()`). It also delegates to
`swiper_formatter.base::renderSwiper()`.
