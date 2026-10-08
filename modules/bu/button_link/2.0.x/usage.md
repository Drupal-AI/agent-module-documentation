<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Button Link adds a field formatter, **"Link as Button"** (id `button_link`), for core Link fields that renders each link as a Bootstrap-style button (`<a class="btn btn-…">`) instead of a plain anchor.

---

The module is a single field formatter plugin (`ButtonLinkFormatter`) that extends core's `LinkFormatter`, so it keeps all the standard link-formatter settings (trim length, `rel`, open in new window) and adds button-specific ones on the *Manage display* form: button type (`btn_type`, e.g. `btn-primary`), size (`btn_size`, e.g. `btn-lg`), block-level (`btn_block` → `btn-block`), custom link text, extra CSS classes (`additional_class`), an optional icon class (`icon_class`, e.g. `fa fa-anchor`), and a toggle to drop the default `role="button"` attribute. Output is rendered through the `link_formatter_button_link` theme hook and the `link-formatter-button-link.html.twig` template, which builds an `<a>` with classes `btn <btn_type> <btn_size> <btn_block> <additional_class>` and a leading `<i>` for the icon. The Bootstrap CSS itself is **not** shipped — you load it via your theme; the module only emits the classes. There is no admin settings page, no permission, no config schema, and no Drush; all configuration lives per field, per view mode, in the `entity_view_display` config as the formatter's `settings`.

---

- Render a "Read more" or "Buy now" link field as a styled Bootstrap button.
- Turn a call-to-action link on an Article into a prominent primary button.
- Style a link field as a danger/warning button (e.g. a "Delete account" CTA).
- Make a hero link full-width with the block-level (`btn-block`) option.
- Show a large (`btn-lg`) button for a primary action and small (`btn-sm`) for secondary.
- Override the displayed link text regardless of the stored link title.
- Add a Font Awesome (or other) icon before the button label via the icon class.
- Add extra utility CSS classes to a button without custom code (`additional_class`).
- Open a button link in a new window by using the inherited link "target" setting.
- Add `rel="nofollow"`/`noopener` to a button link via the inherited rel setting.
- Present a "Download brochure" link as a success button on a product page.
- Convert menu-style CTA link fields across many content types consistently.
- Provide a secondary/outline style by choosing `btn-secondary` or `btn-link` type.
- Trim long URLs/labels on button links with the inherited trim-length setting.
- Drop the default `role="button"` when the anchor is genuinely a navigation link.
- Configure different button styling per view mode (teaser vs full).
- Style a paragraph's link field as a button inside a Layout Builder section.
- Emit token-replaced link text on the button (link title supports tokens).
- Build a row of action buttons from a multi-value link field.
- Match an existing Bootstrap theme's button palette using the built-in type options.
- Export the button configuration in config for deployment (it lives in the view display).
