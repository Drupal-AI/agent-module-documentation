<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Accordion adds an "Accordion/FAQ" Paragraph type built on the jQuery UI Accordion plugin, letting editors build collapsible accordion sections wherever Paragraphs are used.

---

Part of the Extra Paragraph Types (EPT) family, this module ships two Paragraph types installed as default config: `ept_accordion` (the wrapper) and `ept_accordion_section` (each collapsible item, with a title and body/text field). The wrapper carries a nested `field_ept_accordion` paragraph-reference field plus a `field_ept_settings` (an `ept_settings` field from `ept_core`) rendered by the module's `ept_settings_accordion` widget. That widget exposes accordion options that are passed to `drupalSettings` and consumed by `js/jquery_ui_accordion/jquery_ui_accordion.js`: a visual `styles` preset (default / text only / plus-minus icons left / plus-minus icons right), `collapsible`, `closed`, `opened`, `closed_in_tablet`, `closed_in_mobile`, `active` (zero-based open panel index), `disable`, and jQuery UI `heightStyle` (auto/fill/content). Styling presets load matching CSS libraries (`text_only`, `plus_minus_left`, `plus_minus_right`). It depends on `ept_core` (which provides the shared EPT settings, colors and breakpoints config at Configuration → Content authoring → EPT settings), `paragraphs`, and `jquery_ui_accordion`. There is no module config page or permissions of its own; the two Paragraph types and their fields are the deliverable and can be placed on any paragraph-reference field. Uninstalling the module intentionally leaves the Paragraph types in place.

---

- Add an FAQ section (question/answer accordion) to a page via Paragraphs.
- Build collapsible content blocks inside a Layout Builder or paragraph-based landing page.
- Create a "How it works" accordion where only one step is open at a time.
- Let editors choose a plus/minus icon style (left or right) for the accordion toggles.
- Use a text-only accordion style with no icons.
- Start the accordion with all panels closed (collapsible + all-closed).
- Start with a specific panel open using the zero-based `active` index.
- Force all panels open on desktop but collapse them on tablet or mobile.
- Set the jQuery UI `heightStyle` to make all panels equal height (`fill`) or fit content.
- Disable the accordion interaction (render static) when needed.
- Nest multiple accordion sections, each with its own title and rich-text body.
- Reuse the accordion Paragraph type across content types that share a paragraphs field.
- Provide a consistent accordion component across a site without custom theming.
- Combine with other EPT paragraph types (tabs, tiles, columns) for page building.
- Inherit global EPT colors and responsive breakpoints from EPT Core.
- Give non-developers a click-to-configure collapsible UI with no code.
- Override the accordion Twig templates (`paragraph--ept-accordion*`) for custom markup.
- Localize/translate accordion titles and bodies through the standard Paragraph translation flow.
- Present product specs or documentation as expandable sections.
- Keep Paragraph types after uninstall for content consistency (by design).
