<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slideshow routes, controller & Swiper JS

Controller: `src/Controller/SlideshowController.php` (extends `ControllerBase`, injects
`entity_type.manager` in `create()`). Routes: `entity_gallery_slideshow.routing.yml`.

## Routes (`entity_gallery_slideshow.routing.yml`)

Both share the same path shape and param requirements
(`entity_id: \d+`, `slide_id: \d+`, `pager: 0|1`, `progress_bar: 0|1`,
`options.no_cache: TRUE`):

| Route id | Path | Controller method |
|---|---|---|
| `entity_gallery_slideshow.slideshow.ajax` | `/ajax/gallery/{entity_type}/{entity_id}/{field_name}/{slide_id}/{view_mode}/{pager}/{progress_bar}/{modal_title}` | `getSlideshowAjax()` |
| `entity_gallery_slideshow.slideshow.nojs` | `/nojs/gallery/{entity_type}/{entity_id}/{field_name}/{slide_id}/{view_mode}/{pager}/{progress_bar}/{modal_title}` | `getSlideshowNojs()` (title `getSlideshowNojsTitle()`) |

The formatter links its gallery items to the **`.nojs`** route with `class="use-ajax"`; core's
AJAX dialog system rewrites that request to the `.ajax` route, so JS visitors get the modal and
non-JS visitors get the plain `.nojs` page.

## `getSlideshowAjax()` — the modal slideshow

- Loads the parent entity: `entityTypeManager->getStorage($entity_type)->load($entity_id)`; throws
  `NotFoundHttpException` unless it is an `EntityInterface` that `hasField($field_name)`.
- Collects `$parent_entity->{$field_name}->referencedEntities()` and renders each with the
  requested `view_mode` via the entity's view builder; each is wrapped in a `swiper-slide`
  container inside a `swiper-wrapper`, all inside a `.entity-gallery-slideshow` container carrying
  `data-slide=<slide_id>` and attaching library `entity_gallery_slideshow/slideshow`
  (`max-age: 0`).
- If `pager`, adds a `swiper-pagination` element; always adds `swiper-button-prev`/`-next`; if
  `progress_bar`, adds a `swiper-scrollbar`.
- Returns an `AjaxResponse` with an `OpenModalDialogCommand` (`t('Slideshow')` heading, options:
  `title` = `urldecode($modal_title)`, `closeText`, `modal: TRUE`,
  `dialogClass: 'gallery-slideshow-dialog'`, `width: '90vw'`).

## `getSlideshowNojs()` — no-JS fallback

- Same parent load/validation, and additionally requires
  `$parent_entity->{$field_name}->get($slide_id)?->entity` to be an entity, else 404.
- Renders that **single** requested entity with `view_mode`, cached with tags
  `["{$entity_type}_list"]`.
- Appends an `item_list` of Previous/Next links (to the same `.nojs` route with `slide_id ± 1`),
  bounded by `0` and `$parent_entity->{$field_name}->count()`.
- `getSlideshowNojsTitle()` returns `"@entity_label | Page @index of @count"`.

## Libraries & Swiper JS

`entity_gallery_slideshow.libraries.yml`:

- `entity_gallery_slideshow` — `css/entity-gallery-slideshow.css` (grid CSS; note the `version:`
  value is the literal `1.x,` with a trailing comma).
- `swiper` — CSS + JS from `//cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.*` (external CDN).
- `slideshow` — `js/slideshow.js`, dependencies `core/once` + `entity_gallery_slideshow/swiper`.

`js/slideshow.js` (`Drupal.behaviors.entitySlideshow`): `once('entity-gallery-slideshow',
'.entity-gallery-slideshow')` → `new Swiper(el, settings)` with `loop:true`, `spaceBetween:10`,
fraction pagination, prev/next navigation, draggable scrollbar, and a11y messages. It then calls
`slideTo(el.dataset.slide)` to jump to the clicked item, and a `swiperA11y()` helper that sets
`tabindex=-1` on `a, button` in inactive slides (updated on `slideChange`) for accessibility.
