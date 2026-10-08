<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — ept_basic_button

No dedicated admin form (`info.yml` has no `configure`). Configuration is: (1) the installed
Paragraphs type + fields, (2) the per-paragraph "Link options" widget, (3) `ept_core` global
settings. All config is installed on enable from `config/install/`.

## Paragraphs type

`ept_basic_button` (label "EPT Basic Button"), no behavior plugins. Add it to any entity that has a
Paragraphs / entity_reference_revisions field (e.g. a node's paragraph field), then fill the fields
below per instance.

## Installed fields (default form/view display)

| Field | Machine name | Type | Required | Notes |
|---|---|---|---|---|
| Button Link | `field_ept_basic_button_link` | `link` (core) | yes | title required (`title: 2`), any link type (`link_type: 17`); rendered as the `<a>` |
| Title | `field_ept_title` | `text_long` | no | rendered in an `<h2>` above the button when non-empty |
| Text | `field_ept_text` | `text_long` | no | body text, printed via `content|without(...)` block |
| Paragraph settings | `field_ept_settings` | `ept_settings` (from `ept_core`) | no | holds all the design/link options below |

## Per-button settings — the "Link options" widget

Widget `ept_settings_basic_button` (`EptSettingsBasicButtonWidget`, extends `ept_core`'s
`EptSettingsDefaultWidget`). It renders the shared `ept_core` design options (CSS box:
margins/padding/border; background color/image/video; container width; breakpoints) plus a **Link
options** details group with these keys (stored under `field_ept_settings.0.ept_settings`):

| Key | Control | Default | Effect |
|---|---|---|---|
| `open_in_new_tab` | checkbox | off | adds `target="_blank"` to the link |
| `add_nofollow` | checkbox | off | adds `rel="nofollow"` to the link |
| `title_color` | textfield (hex) | `#ffffff` | button text color (generated inline CSS) |
| `background_color` | textfield (hex) | `ept_core_background_color` global | button background (generated inline CSS) |
| `custom_hover_colors` | checkbox | off | reveals the two hover-color fields |
| `hover_title_color` | textfield (hex) | empty | text color on hover (only if custom_hover_colors) |
| `hover_background_color` | textfield (hex) | empty | background on hover (only if custom_hover_colors) |
| `alignment` | radios | `left` | maps to `ept-align-{left,center,right}` class |
| `shape` | radios | `square` | maps to `ept-shape-{square,round,circle}` class |
| `size` | radios | `medium` | maps to `ept-size-{small,medium,large}` class |
| `stretched` | checkbox | off | maps to `ept-stretched` (full-width) class |
| `custom_class_name` | textfield | empty | extra CSS class(es) on the `<a>`, space-separated |

Validation (from `ept_core`): color fields use `Color::validateHex` (must be a valid hex color);
`custom_class_name` uses `EptGenericValidator::validateClassElement`, which rejects any class not
matching `^[a-zA-Z][a-zA-Z0-9_-]*$`. Note a legacy typo key `stetched` is still read by the
template for backward compatibility alongside `stretched` (widget writes `stretched`).

`massageFormValues()` flattens the `link_options` subtree back up into `ept_settings` on save.

## Global settings (ept_core)

Primary/secondary colors and mobile/tablet/desktop breakpoints live at
**Configuration » Content authoring » Extra Paragraph Types (EPT) settings**
(`ept_core.settings`; key `ept_core_background_color` is the fallback button background). These
apply to every EPT paragraph unless overridden per instance. Set via
`drush cget ept_core.settings` / `drush cset ept_core.settings <key> <value>`.
