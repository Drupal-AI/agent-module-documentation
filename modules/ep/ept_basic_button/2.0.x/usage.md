<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Paragraph Types (EPT): Basic Button ships a single Paragraphs type, `ept_basic_button`, that renders one styled link/button as a page-building component. It is one of the ~28 standalone EPT modules and depends on `ept_core` for its shared design settings.

---

Enabling the module installs a `ept_basic_button` Paragraphs type with four fields: a required Link field (`field_ept_basic_button_link`), an optional Title (`field_ept_title`, text_long), an optional Text/body (`field_ept_text`, text_long), and the family's shared settings field (`field_ept_settings`, an `ept_settings` field type from `ept_core`). A custom field widget (`EptSettingsBasicButtonWidget`, extending `ept_core`'s `EptSettingsDefaultWidget`) adds a "Link options" details group with per-button controls: open-in-new-tab, add-nofollow, title/background colors, optional custom hover colors, alignment (left/center/right), shape (square/round/circle), size (small/medium/large), a stretched toggle, and a custom CSS class name. Colors are validated as hex, custom classes against a strict identifier regex. On render, `hook_preprocess_paragraph` calls the `ept_basic_button.generate_custom_css` service to turn the per-paragraph color settings into a scoped inline `<style>` block keyed to `.paragraph-id-{id}`, and the Twig template (`paragraph--ept-basic-button--default.html.twig`) maps the alignment/shape/size/stretched settings to `ept-*` CSS classes. The module also ships a view CSS library (`ept_basic_button_view`) and a small colorpicker form JS. There is no admin settings form of its own — global colors and breakpoints live in `ept_core.settings` (Configuration » Content authoring » Extra Paragraph Types (EPT) settings). Add the paragraph to any entity that has a Paragraphs (entity reference revisions) field.

---

- Add a call-to-action button as a standalone paragraph in a layout/stacked page built with Paragraphs.
- Place a "Read more" / "Contact us" / "Download" button between content sections without custom theming.
- Let content authors pick per-button background and title colors from a colorpicker, validated as hex.
- Give a button custom hover colors (distinct title + background on hover) without touching CSS.
- Choose button shape — square, round (rounded corners), or circle — per instance.
- Choose button size — small, medium, or large — per instance.
- Align a button left, center, or right within its container.
- Stretch a button to the full width of its container (full-width CTA).
- Open a link in a new tab (`target="_blank"`) via a checkbox.
- Add `rel="nofollow"` to a button link for SEO control via a checkbox.
- Attach arbitrary custom CSS class names to a button for theme-specific styling.
- Reuse `ept_core`'s shared design options (margins/padding/border, background color/image/video, container width, breakpoints) that come with every EPT paragraph.
- Standardize button styling across a site by installing only this paragraph type instead of a full page-builder.
- Build landing pages entirely from EPT paragraphs, mixing Basic Button with EPT Text, Hero, Image, etc.
- Provide editors a no-code way to add branded buttons inside long-form content.
- Translate/keep buttons per-language when using Paragraphs on translatable entities.
- Combine a title, descriptive text, and a button in one reusable component.
- Swap the button's markup or classes by overriding `paragraph--ept-basic-button--default.html.twig` in a theme.
- Install alongside sibling EPT modules to assemble a component library while keeping each type optional.
- Use as a lighter alternative to `ept_bootstrap_button` when you do not want Bootstrap-specific button classes.
- Migrate button content between pages by copying the paragraph (revisioned via Paragraphs).
- Drive consistent brand colors by leaving per-button colors empty so the `ept_core` global default applies.
