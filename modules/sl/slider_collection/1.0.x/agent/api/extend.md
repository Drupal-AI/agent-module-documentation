<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension API — base classes & adding a slider library

The base module defines no plugin type. A library integration is a **submodule** that (a) subclasses
`SliderCollectionSliderBase` and registers it as a service to shape settings, and (b) subclasses
`SliderCollectionViewsStyleBase` to register a Views style. `sc_swiper` and `sc_tinyslider` are the
two reference implementations.

## `SliderCollectionSliderBase` (settings service base)

`Drupal\slider_collection\SliderCollectionSliderBase` — abstract, no dependencies. Extend it and
declare it as a service (e.g. `sc_swiper.swiper: { class: Drupal\sc_swiper\SwiperBase }`).

| Member | Kind | Purpose |
|---|---|---|
| `getSliderGeneralSettings()` | protected, concrete | Returns the shared default option array: `loop=FALSE`, `speed=1500`, `autoplay=FALSE`, `breakpointMobile=1`/`itemsMobile=1`, `breakpointTablet=768`/`itemsTablet=1`, `breakpointDesktop=1200`/`itemsDesktop=1`. Merge your library defaults onto this. |
| `defaultSettings(): mixed` | abstract | Return the full default option set for your library (typically `[...] + $this->getSliderGeneralSettings()`). |
| `formattedSettings(array $settings): array` | abstract | Transform saved option values into the exact option object the JS library expects. |

Convention seen in both reference services: `formattedSettings()` first drops any key not present in
`defaultSettings()`, then **type-casts** every value — `(bool)`, `(int)`, `(string)` — and maps the
responsive `breakpoint*`/`items*`/`spaceBetween*` keys into the library's own `breakpoints` /
`responsive` structure. This casting is what keeps arbitrary values out of the emitted JSON.

## `SliderCollectionViewsStyleBase` (Views style base)

`Drupal\slider_collection\SliderCollectionViewsStyleBase` — abstract, extends
`Drupal\views\Plugin\views\style\StylePluginBase`, implements `CacheableDependencyInterface`.
Subclass it and add the `#[ViewsStyle(...)]` attribute (id, title, `theme`, `display_types: ['normal']`).

- `usesRowPlugin = TRUE`, `usesRowClass = TRUE` (each row becomes a slide, row classes allowed).
- `defineOptions()` seeds one option per key returned by your `getDefaultSettings()`.
- `buildOptionsForm()` renders the **common** slider fields — subclasses call `parent::` then add
  library-specific fields. Common fields:

| Option key | Widget | Meaning |
|---|---|---|
| `autoplay` | checkbox | Auto-advance slides |
| `speed` | number (ms) | Slide animation speed |
| `loop` | checkbox | Seamless looping |
| `breakpointMobile` / `itemsMobile` | number / number (step 0.25) | Mobile breakpoint px + items shown |
| `breakpointTablet` / `itemsTablet` | number / number (step 0.25) | Tablet breakpoint px + items shown |
| `breakpointDesktop` / `itemsDesktop` | number / number (step 0.25) | Desktop breakpoint px + items shown |

- Caching: `getCacheTags()` → `view_id:<id>`, `view_display_id:<display>`; `getCacheMaxAge()` →
  `Cache::PERMANENT`; `getCacheContexts()` → `url.query_args:<json of formatted settings>`,
  `url.path`; `render()` attaches all three onto `$build['#cache']`.
- Abstract to implement: `getDefaultSettings(): array` (delegate to your settings service's
  `defaultSettings()`) and `getFormattedSettings(): array` (delegate to `formattedSettings()`).

## Wiring the render (preprocess pattern)

Neither base class emits markup; the submodule's `hook_theme` + `template_preprocess_*` does. The
established pattern (see `sc_swiper.module`):

```php
$settings = \Drupal::service('sc_swiper.swiper')->formattedSettings($options);
$variables['attributes']['id'] = Html::getUniqueId('swiper-' . Crypt::randomBytesBase64(8));
// Emitted as a data attribute, JSON.parse()'d by the library's init JS. JSON_FORCE_OBJECT
// keeps numeric breakpoint keys as object properties.
$variables['attributes']['data-swiper'] = json_encode($settings, JSON_FORCE_OBJECT);
$variables['attributes']['class'][] = 'swiper';
```

The template loops `rows`/`content` and prints `{{ row.content }}` / `{{ item }}` (Twig
auto-escaped, standard Views/entity render output) inside a `.swiper-slide` wrapper. Dispatch the
matching alter event (see [../events/settings.md](../events/settings.md)) before building attributes
so integrators can adjust the option object.

## Who can build sliders

Building a slider means editing a **View** (`administer views`) or configuring a **field display**
(`administer <entity-type> display`) — administrator-level permissions. There is no editor-facing
UI and no per-slide free-text field defined by this project.
