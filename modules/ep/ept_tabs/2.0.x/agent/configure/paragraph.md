<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Tabs — Paragraph types, fields, widget, and rendering

There is **no settings form** for this module. Everything is delivered as two Paragraph types and
their fields (default config in `config/install/`), configured through the standard Paragraphs and
Field UI. Global defaults (colors, container widths, breakpoints) live in **EPT Core** at
`/admin/config/content/ept` (`ept_core.settings`).

## Paragraph types

- **`ept_tabs`** — the wrapper ("EPT Tabs"). Place it on any `entity_reference_revisions` /
  Paragraphs field (e.g. a landing-page body).
- **`ept_tabs_item`** — one tab ("EPT Tabs Item"). Not placed directly; referenced by the wrapper.

Neither type declares behavior plugins. `hook_requirements` (`ept_tabs.install`) blocks installation
unless a **"Page" content type** exists.

## Wrapper fields (`ept_tabs`)

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_tabs` | `entity_reference_revisions` → paragraph | Cardinality **-1** (unlimited); target bundle `ept_tabs_item`. The list of tabs. |
| `field_ept_title` | `text` (formatted) | Optional heading rendered above the tab set. |
| `field_ept_text` | `text_long` | Optional intro text (present in config; hidden by default display). |
| `field_ept_settings` | `ept_settings` (from `ept_core`) | Rendered by the `ept_settings_tabs` widget. |

## Tab-item fields (`ept_tabs_item`)

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_tab_title` | `text` (formatted), **required** | The clickable tab label. Formatted on purpose (README FAQ) so titles can carry `<i>` icons, bold/italic, or responsive-visibility CSS classes. |
| `field_ept_tab_content` | `list_string`, cardinality 1 | Selector: `text` \| `page` \| `block` \| `views`. Decides which content field below is used. |
| `field_ept_tab_text` | `text_long` | Used when content = `text`. |
| `field_ept_tab_page` | `entity_reference` → node | Used when content = `page`. Restricted to the `page` bundle by default; add more bundles at the field settings form for `field_ept_tab_page`. |
| `field_ept_tab_block` | `block_field` (cardinality 1) | Used when content = `block`. Requires `block_field`. |
| `field_ept_tab_views` | `viewsreference` → view (cardinality 1) | Used when content = `views`. Requires `viewsreference`. |

### Content selector behaviour

`EptTabsHooks` (`src/Hook/EptTabsHooks.php`) implements
`hook_field_widget_single_element_(entity_reference_paragraphs|paragraphs)_form_alter`: for an
`ept_tabs_item` subform it attaches `#states` so only the field matching the selected
`field_ept_tab_content` value is visible. A `hook_form_alter` on `node_paragraphs_page_edit_form`
appends the submit validator `_ept_tabs_form_validation` (in `ept_tabs.module`), which iterates the
tabs and calls `setErrorByName` if the field required by the selected content type is empty (e.g.
content=`views` but `field_ept_tab_views` empty → "Field \"Tab views\" is required.").

## The `ept_settings_tabs` widget

Class `Drupal\ept_tabs\Plugin\Field\FieldWidget\EptSettingsTabsWidget` (id `ept_settings_tabs`)
extends `ept_core`'s `EptSettingsDefaultWidget`, so it inherits all EPT **Design options** (ID/anchor,
margins/padding/borders, border color/style/radius, background color, background media image/video,
background image position/size, overlay, edge-to-edge, container width, additional CSS classes) and
**Title options** (wrapper tag, strip tags). It adds tab-specific options and sets
`pass_options_to_javascript = TRUE` (required so `ept_core` publishes the options to JS):

| Option | Type | Meaning |
|--------|------|---------|
| `styles` | radios | Visual preset: `default`, `without_header_background`, `minimalist_tabs`, `tabs_like_buttons`, `vertical_tabs`, `vertical_tabs_rotated`. Non-default presets attach the matching CSS library and add an `ept-tabs-<preset>` class. |
| `active` | number | Zero-based index of the panel that is open. Negative counts back from the last panel. |
| `collapsible` | checkbox | Allow the active panel to be closed (all panels closable). |
| `closed` | checkbox | Start with all panels collapsed (JS sets `active = false`). |
| `disable` | checkbox | Disable the jQuery UI tabs interaction (render static). |
| `heightStyle` | radios | jQuery UI height mode: `auto` / `fill` / `content` (default `content`). |

## Front-end assembly

1. `ept_core`'s `paragraph_view` hook camel-cases the bundle and publishes each paragraph's options as
   `drupalSettings.eptTabs['paragraph-id-<id>'] = { paragraphClass: 'paragraph-id-<id>', options }`
   (only because `pass_options_to_javascript` is TRUE).
2. `js/jquery_ui_tabs/jquery_ui_tabs.js` (`Drupal.behaviors.eptTabs`) iterates `drupalSettings.eptTabs`,
   creates an `#ept-tabs-<class>` container with a `<ul class="tabs-<class>">`, moves each item's
   `.ept-tab-title` into the `<ul>` (wrapped in `<li><a href="#…">`) and each `.ept-tab-content` into
   a panel `<div>`, then calls `$('#ept-tabs-<class>').tabs(options)` mapping the widget options above
   (`active`, `collapsible`, `disable`, `heightStyle`; `closed` → `active:false`). `heightStyle` is
   passed through `Drupal.checkPlain`. Guarded by `once('reorderBlocks', …)` and a `tabs-added` class.
3. Library `ept_tabs/jquery_ui_tabs` depends on `core/drupal`, `core/jquery`, `core/once`,
   `core/drupalSettings`, and `jquery_ui_tabs/tabs`.

## Templates

Registered via `hook_theme_registry_alter` (`EptTabsHooks::themeRegistryAlter`) and shipped in
`templates/`:

- `paragraph--ept-tabs--default.html.twig` — wrapper. Adds the `ept-tabs-<style>` class, conditionally
  attaches the preset CSS library, renders the optional title (honouring EPT Core's `title_wrapper` /
  `strip_tags` title options), prints the remaining content, and — like every EPT paragraph — emits
  `{{ styles|raw }}`, the per-paragraph `<style>` block produced by `ept_core`'s `GenerateCSS` service
  from the Design options.
- `paragraph--ept-tabs-item--default.html.twig` — one tab: a `.ept-tab-title` and `.ept-tab-content`
  (the markup the JS reorders into the tab set).
- `field--paragraph--field-ept-tabs--ept-tabs.html.twig` — field wrapper adding `ept-tabs-wrapper`.

## Where the config lives

`config/install/` ships the two `paragraphs.paragraphs_type.*`, the `field.storage.*` /
`field.field.*` for every field above, and the default form/view displays. Nothing is exported to an
admin settings form; edit through Structure → Paragraph types and the Field UI.
