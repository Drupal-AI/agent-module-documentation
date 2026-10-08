<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Paragraph Types (EPT): Core is the shared base for the EPT family of Paragraph modules — it provides the reusable "EPT Settings" field, shared paragraph fields, and the CSS/JS that turn per-paragraph design options into rendered styling.

---

EPT Core does not itself add a ready-to-use paragraph; it is the toolkit that every `ept_*`
paragraph module (and modules scaffolded by the Starterkit) builds on. It defines the
`ept_settings` field type (`EptSettingsItem`) with a rich **default widget**
(`ept_settings_default`) and a **simple widget** (`ept_settings_simple`) plus a formatter
(`ept_settings_default`), and ships three shared paragraph field storages —
`field_ept_settings`, `field_ept_text`, `field_ept_title`. The EPT Settings field captures
per-paragraph **design options** (margins/borders/padding "boxes", border colour/style/radius,
background colour, background media/image style, edge-to-edge, container width) and a
"pass options to Javascript" flag. At render time the `ept_core.generate_css`
(`GenerateCSS::generateFromSettings()`) and `ept_core.generate_js`
(`GenerateJS::generateFromSettings()`) services convert those settings into scoped CSS and JS
for each paragraph, and `EptCoreHooks` (OOP hooks: `preprocess_paragraph`,
`theme_suggestions_paragraph_alter`, `entity_view_alter`, etc.) wires them into the paragraph
render pipeline. Global defaults — brand colours, responsive breakpoints (mobile/tablet/desktop)
and named container widths (xxSmall…xxLarge) — live in config `ept_core.settings` (schema in
`config/schema/ept_core.schema.yml`), edited at `/admin/config/content/ept-core`. It depends on
Paragraphs, Media, Field Group and Media Library Form Element, and bundles the colorpicker,
YouTube player, parallax and video-background JS libraries used by EPT paragraphs.

---

- Provide the shared "EPT Settings" design-options field to a custom paragraph type.
- Give editors per-paragraph control of margins, borders and padding without code.
- Let editors set a background colour or background media/image on a paragraph.
- Offer a container-width / edge-to-edge choice per paragraph section.
- Set site-wide brand colours (primary/secondary + button text colours) for EPT paragraphs.
- Define responsive breakpoints (mobile/tablet/desktop) used across EPT paragraphs.
- Configure named container widths (xxSmall through xxLarge) for consistent layouts.
- Reuse the `field_ept_title` and `field_ept_text` fields across many paragraph types.
- Generate scoped per-paragraph CSS from design options via the GenerateCSS service.
- Generate per-paragraph JS (e.g. parallax, video background) via the GenerateJS service.
- Build a landing-page builder on Paragraphs with consistent design controls.
- Base a new `ept_*` paragraph module on EPT Core's field + services.
- Provide a colorpicker widget for choosing paragraph colours.
- Add a YouTube/video background to a paragraph using the bundled player libraries.
- Add a parallax background effect to a paragraph section.
- Attach the EPT Settings field to an existing paragraph type to add design options.
- Choose between the full (default) and simple EPT Settings widget per form display.
- Keep design-option data structured and translatable on each paragraph.
- Theme EPT paragraphs via the module's paragraph template suggestions.
- Standardise section spacing and backgrounds across an editorial team.
- Export EPT global settings as configuration for deployment across environments.
- Validate HEX colour inputs on the settings form (EptGenericValidator).
- Serve as the dependency layer so individual EPT paragraph modules stay small.
- Pair with the Starterkit submodule to scaffold brand-new EPT paragraph modules.
- Switch a paragraph to edge-to-edge full-width rendering.
- Apply a border radius/style and background image style to a paragraph.
