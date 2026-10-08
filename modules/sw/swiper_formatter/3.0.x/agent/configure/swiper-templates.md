<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swiper templates (config entity) & library sources

## The config entity

`swiper_formatter` is a `@ConfigEntityType` (class `…\Entity\SwiperFormatter`,
`config_prefix: swiper_formatter`). Instances are stored as
`swiper_formatter.swiper_formatter.<id>` and exported keys are: `id`, `label`,
`description`, `status`, `breakpoint` (bool — is this a breakpoint-only template), and
`swiper_options` (the big options map). `admin_permission = administer swiper_formatter`.

- A **`default`** template ships in `config/install`. `SwiperFormatter::preCreate()`
  deep-merges the `default` template's `swiper_options` into any new template, so new
  templates inherit the full option set. **Do not delete `default`** — creating templates
  loads it.
- Optional install config also ships breakpoint demo templates
  (`breakpoint480_template`, `breakpoint960_template`, `responsive_breakpoints`).

## Admin UI / routes

Managed at **`/admin/config/content/swiper-formatter`**. Routes come from
`SwiperFormatterAdminRouteProvider` (entity `route_provider`), not routing.yml:

| Link key | Path | Route |
|---|---|---|
| collection | `/admin/config/content/swiper-formatter` | `entity.swiper_formatter.collection` |
| add-form | `/admin/config/content/swiper-formatter/add` | `entity.swiper_formatter.add_form` |
| edit-form | `/admin/config/content/swiper-formatter/{swiper_formatter}` | `entity.swiper_formatter.edit_form` |
| delete-form | `…/{swiper_formatter}/delete` | `entity.swiper_formatter.delete_form` |
| duplicate-form | `…/{swiper_formatter}/duplicate` | `entity.swiper_formatter.duplicate_form` |

There is **no** `configure` route in info.yml; the collection route above is the entry point.

## `swiper_options` shape (from `config/schema/swiper_formatter.schema.yml`)

Top-level scalars: `source` (library source: `package`|`remote`|`local`|`local_minified`),
`autoHeight`, `width`, `height`, `breakpointsBase` (`window`|`container`), `observer`,
`updateOnWindowResize`, `resizeObserver`, `direction` (`horizontal`|`vertical`), `effect`
(`slide`, `fade`, …), `loop`, `rewind`, `centeredSlides`, `speed` (ms), `slidesPerView`
(float, e.g. `1.5` or `auto`), `spaceBetween`, `slidesPerGroup`, `loopedSlides`,
`noSwipingSelector`, `mousewheel`, `grabCursor`, `simulateTouch`, `allowTouchMove`, `cssMode`.

Nested option groups (each an `enabled` bool plus sub-keys):
- `grid` → `rows`, `fill`
- `keyboard` → `onlyInViewport`, `pageUpDown`
- `autoplay` → `delay`, `disableOnInteraction`, `pauseOnMouseEnter`, `reverseDirection`, `stopOnLastSlide`, `waitForTransition`
- `navigation` → `hideOnClick`
- `pagination` → `type` (`bullets`|`fraction`|`progressbar`), `dynamicBullets`, `clickable`
- `scrollbar` → `draggable`, `dragSize`, `hide`, `snapOnRelease`
- `zoom` → `limitToOriginalSize`, `maxRatio`, `minRatio`, `panOnMouseMove`, `toggle`
- `lazy` → `checkInView`, `loadOnTransitionStart`, `loadPrevNext`, `loadPrevNextAmount`, `scrollingElement`
- `breakpoints` → a sequence; each item has `breakpoint`, `swiper_template`, `weight`, and
  per-breakpoint overrides (`slidesPerView`, `slidesPerGroup`, `spaceBetween`, `navigation`,
  `pagination`, `grid`). A breakpoint can point at another template flagged `breakpoint: true`.

These keys map 1:1 to Swiper's JS API — see https://swiperjs.com/swiper-api. The `default`
config entity (`config/install/swiper_formatter.swiper_formatter.default.yml`) is the
canonical example of every default value.

## Library source

`swiper_formatter.libraries.yml` defines four Swiper sources, selected per template via
`swiper_options.source`:
- **`package`** (default in code) — self-hosted build `js/build/swiper.bundle.min.{js,css}`.
- **`remote`** — unpkg CDN `swiper@12.1.3` (the `default` template ships with `source: remote`).
- **`local`** / **`local_minified`** — expects the library at `/libraries/swiper/`.

## Create a template in code / drush

```php
\Drupal\swiper_formatter\Entity\SwiperFormatter::create([
  'id' => 'hero',
  'label' => 'Hero',
  'swiper_options' => ['direction' => 'horizontal', 'loop' => TRUE,
    'autoplay' => ['enabled' => TRUE, 'delay' => 5000]],
])->save();   // preCreate() fills the rest from the 'default' template
```
