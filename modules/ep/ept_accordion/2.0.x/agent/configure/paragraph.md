<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accordion Paragraph type & widget options

## Paragraph types (installed as default config)
- `ept_accordion` — the accordion wrapper. Fields:
  - `field_ept_accordion` — paragraph reference to `ept_accordion_section` items (the panels).
  - `field_ept_settings` — an `ept_settings` field (from `ept_core`) edited by the
    `ept_settings_accordion` widget (options below).
- `ept_accordion_section` — one collapsible panel; carries a title field and a text/body field
  (`field_ept_accordion_title`, `field_ept_accordion_text`).

Place accordions by adding a Paragraphs (reference revisions) field to a content type and allowing the
`ept_accordion` type, or nest it inside another paragraph field.

## Widget: `ept_settings_accordion`
`@FieldWidget(id="ept_settings_accordion", field_types={"ept_settings"})`, extends
`EptSettingsDefaultWidget`. It sets a hidden `pass_options_to_javascript = TRUE` and exposes these
settings (stored inside the `ept_settings` value, read by the JS):

| Option | Type | Notes |
|---|---|---|
| `styles` | radios | `default`, `text_only`, `plus_minus_left`, `plus_minus_right` (loads the matching CSS library). |
| `collapsible` | checkbox | Allow all panels closed at once (default on). |
| `closed` | checkbox | Start all closed (requires `collapsible`). |
| `opened` | checkbox | Start all opened (mutually constrained with `closed` via `#states`). |
| `closed_in_tablet` | checkbox | Collapse on tablet (visible when `opened`). Breakpoint from EPT settings. |
| `closed_in_mobile` | checkbox | Collapse on mobile (visible when `opened`). |
| `active` | number | Zero-based index of the initially open panel; negative counts from the end. |
| `disable` | checkbox | Disable the accordion (render static). |
| `heightStyle` | radios | jQuery UI `auto` / `fill` / `content` (default `content`). |

The style-preset help text links to preview images under the module's `images/help/`. Front-end
behavior is driven by `js/jquery_ui_accordion/jquery_ui_accordion.js` (library `ept_accordion/jquery_ui_accordion`,
depending on `jquery_ui_accordion/accordion`).

## Theming
Templates: `paragraph--ept-accordion--default.html.twig`,
`paragraph--ept-accordion-section--default.html.twig`,
`field--paragraph--field-ept-accordion--ept-accordion.html.twig`. The module registers/point these via
`hook_theme_registry_alter` (`EptAccordionHooks::themeRegistryAlter`). Override in your theme for
custom markup.

Global look (primary/secondary colors, mobile/tablet/desktop breakpoints) is inherited from EPT Core
(`ept_core.settings`, route `ept_core.settings`).
