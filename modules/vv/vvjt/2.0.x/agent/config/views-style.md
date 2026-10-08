<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `views_vvjt` style plugin — options reference

Config object `views.style.views_vvjt` (schema in `config/schema/vvjt.schema.yml`).
Defaults come from `Drupal\vvjt\VvjtConstants`. The options form is built in sectioned
`details` groups by `Tabs::buildPatternSections()` (Layout / Animation / Styling /
Responsive) plus the base's shared Advanced, Deep-Linking, and Token sections, then
**flattened on submit** (`flattenFormValues()`) into the flat keys below. Unlike vvjb,
values are consumed directly by the Twig template (`options.*`), not mapped to `data-*`.

## Row contract (how tabs are built)
The style requires the **Fields** row style (`requiresFieldsRow()` = `TRUE`, inherited).
The row template `views-view-vvjt-fields.html.twig` renders `first_field.content`, then a
literal `<div class="vvjt-separator"></div>`, then the remaining fields. The main
template splits each rendered row on that marker:

- **first field → tab button** (label). Its stripped text also becomes the button's
  `aria-label`.
- **remaining fields → tab pane** (content).

So order fields deliberately: field 1 is the clickable tab; everything after is the panel.

## Layout
| Key | Type | Default | Bound |
|---|---|---|---|
| `tabs_position` | string | `top` | `top` \| `right` \| `bottom` \| `left` |
| `wrap_tabs` | bool | `false` | on = wrap overflowing buttons; off = auto-scroll |
| `max_width` | int (px) | `300` | min 0 (`0` = auto); required |
| `max_height` | int (px) | `0` | min 0 (`0` = auto); vertical layouts only; required |

`left`/`right` are vertical layouts; `top`/`bottom` horizontal. `max_width` applies to
the buttons container (vertical) or each button (horizontal). `max_height` caps the
vertical buttons container only (not the pane).

## Animation
| Key | Type | Default | Bound |
|---|---|---|---|
| `animation` | string | `a-bottom` | `none` \| `a-top` \| `a-bottom` \| `a-left` \| `a-right` \| `a-zoom` \| `a-opacity` |

Tabs offer an extra `a-opacity` preset beyond vvj_core's shared set. Reduced-motion users
see no animation regardless.

## Styling
| Key | Type | Default | Bound |
|---|---|---|---|
| `background_buttons` | string | `#ECECEC` | HTML color (`#type => color`); emitted as CSS var `--bg-buttons` |
| `background_panes` | string | `#F7F7F7` | HTML color; emitted as CSS var `--bg-panes` |
| `disable_background` | bool | `false` | on = ignore both colors (form `#states` disable the pickers) |

## Responsive
| Key | Type | Default | Bound |
|---|---|---|---|
| `available_breakpoints` | string | `992` | `576` \| `768` \| `992` \| `1200` \| `1400` |

Breakpoint at which **vertical** tabs (left/right) collapse to horizontal.
`buildLibraryList()` attaches `vvjt/vvjt-vertical` + `vvjt/vvjt__{breakpoint}` for
vertical positions, or `vvjt/vvjt-horizontal` otherwise, on top of the shared `vvjt`
library. (The form deliberately re-assigns `#options` to just these five to avoid the
base registry's `all` value leaking, which has no backing vvjt CSS.)

## Advanced (from base)
| Key | Type | Default |
|---|---|---|
| `enable_css` | bool | `true` |

When on, adds `vvjt/vvjt-style` (the visual layer). Uncheck to supply your own theme CSS.

## Deep linking (from `vvj_core` base)
| Key | Type | Default |
|---|---|---|
| `enable_deeplink` | bool | `false` |
| `deeplink_identifier` | string | `''` |

When enabled, tab buttons become `<a href="#tabs-{identifier}-{n}">` anchors and the
JS syncs the URL hash. `deeplink_identifier` is **required** when deep linking is on,
schema-constrained to `/^[a-z][a-z0-9-]*[a-z0-9]$/` (max 20 chars), slug-normalized on
submit (transliterate → lowercase → strip), and rejected if it equals a reserved word:
`tabs`, `tab`, `vvjt`, `vvj` (`VvjtConstants::DEEPLINK_RESERVED_WORDS`). When disabled,
any stored identifier is cleared.

`unique_id` (int) is auto-generated per instance to namespace DOM ids
(`vvjt-{id}`, `vvjt-button-{id}-{n}`, `vvjt-pane-{id}-{n}`).
