<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `views_vvjb` style plugin — options reference

Config object `views.style.views_vvjb` (schema in `config/schema/vvjb.schema.yml`).
Defaults come from `Drupal\vvjb\VvjbConstants`. The options form is built in sectioned
`details` groups by `BasicCarousel::buildPatternSections()`, then flattened on submit
(`flattenFormValues()`) into the flat keys below. Each key is emitted to the DOM as the
`data-*` attribute shown (see `VvjbConstants::DATA_ATTRIBUTE_MAP`) and read by the JS.

## Layout
| Key | Type | Default | Bound | data attr |
|---|---|---|---|---|
| `orientation` | string | `horizontal` | `horizontal` \| `vertical` \| `hybrid` | `data-orientation` |
| `items_small` | int | `1` | min 1 | `data-items-small` |
| `items_big` | int | `3` | min 1 | `data-items-big` |
| `gap` | int (px) | `16` | min 0 | `data-gap` |
| `item_width` | int (px) | `0` (auto) | min 0 | `data-item-width` |

`hybrid` = vertical below the responsive breakpoint, horizontal above. `items_small` /
`items_big` are treated as *maximums*; JS reduces visible slides to fit the viewport.

## Behavior
| Key | Type | Default | Bound | data attr |
|---|---|---|---|---|
| `slide_time` | int (ms) | `5000` | 0–15000, step 1000; **0 disables autoplay** | `data-slide-time` |
| `looping` | bool | `true` | — | `data-looping` (`1`/`0`) |
| `enable_pause_on_hover` | bool | `true` | — | `data-enable-pause-on-hover` |
| `enable_touch_swipe` | bool | `true` | — | `data-enable-touch-swipe` |
| `enable_keyboard_nav` | bool | `true` | — | `data-enable-keyboard-nav` |

`validateOptionsForm()` re-checks `slide_time` is within 0–15000.

## Controls (visibility)
| Key | Type | Default | data attr |
|---|---|---|---|
| `show_play_pause` | bool | `true` | `data-show-play-pause` |
| `show_progress_bar` | bool | `true` (form) | `data-show-progress-bar` |
| `show_page_counter` | bool | `true` | `data-show-page-counter` |

## Navigation
| Key | Type | Default | Bound | data attr |
|---|---|---|---|---|
| `navigation` | string | `both` | `arrows` \| `dots` \| `both` \| `none` | `data-navigation` |
| `dot_style` | string | `circle` | `circle` \| `bar` \| `square` | (wrapper class `bar-dots`/`square-dots`) |
| `scrollable_dots_width` | int (px) | `0` (off) | 0, or 120–700 | `data-scrollable-dots-width` |

`dot_style` and `scrollable_dots_width` only apply when `navigation` is `dots` or `both`
(form `#states`). `scrollable_dots_width` is validated to be 0 or within 120–700.

## Accessibility / Responsive
| Key | Type | Default | Bound | data attr |
|---|---|---|---|---|
| `pause_on_reduced_motion` | bool | `true` | — | `data-pause-on-reduced-motion` |
| `breakpoints` | string | `992` | `576` \| `768` \| `992` \| `1200` \| `1400` | `data-breakpoints` |

`buildLibraryList()` attaches the matching responsive CSS library
`vvjb/vvjb__{breakpoint}` on top of the shared `vvjb` library.

## Deep linking (from `vvj_core` base)
| Key | Type | Default | data attr |
|---|---|---|---|
| `enable_deeplink` | bool | `false` | `data-deeplink-enabled` |
| `deeplink_identifier` | string | `''` | `data-deeplink-id` |

`deeplink_identifier` is schema-constrained to `/^[a-z][a-z0-9-]*[a-z0-9]$/`, max 20
chars, and must not be a reserved word (`carousel`, `slide`, `vvjb`, `vvj`). Produces
shareable slide fragments like `#carousel-{identifier}-{n}`. **Requires** `navigation`
to include dots (`dots` or `both`) — enforced in `validateOptionsForm()`.

`unique_id` (int) is auto-generated per instance to namespace DOM ids/classes.
