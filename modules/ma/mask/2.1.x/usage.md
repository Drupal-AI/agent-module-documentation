<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mask Field restricts what users can type into text inputs by applying an input mask (via the jQuery Mask Plugin), so values like phone numbers, ZIP codes, dates and IP addresses are forced into an allowed format as the user types.

---

The module works two ways. On **field widgets**, it implements `hook_field_widget_third_party_settings_form()` to add a "Mask settings" fieldset to supported widgets on a bundle's *Manage form display* page; out of the box it supports the `string_textfield` (Text field) and `telephone_default` (Telephone) widgets, and other modules can register more widgets by shipping a `<module>.mask_field_widgets.yml` file (a YAML-discovered `mask_field_widget` plugin type managed by `plugin.manager.mask_field_widget`). The chosen mask and options (`value`, `reverse`, `clearifnotmatch`, `selectonfocus`) are stored as a `third_party_settings.mask` entry on that widget's component in the `entity_form_display` config. For **custom forms**, it exposes a Form API `#mask` property on `textfield` and `tel` render elements (via `hook_element_info_alter()` and `Drupal\mask\Helper\ElementHelper`), and the set of element types can be extended by other modules. At render time the settings become `data-mask-*` HTML attributes; a small JS behavior (`js/mask.js`) reads them and calls jQuery Mask. The mask *pattern language* is configurable at `admin/config/content/mask` (route `mask.settings`, permission `administer mask module`): a table of translation symbols maps a placeholder character to a regex (shipped locked defaults: `0`/`9`/`#` = a digit, `A` = letter or number, `S` = a letter), plus flags for optional/recursive. The jQuery Mask library is loaded from a CDN by default (`use_cdn: true`) or from a local `public://` file. Masking is a **client-side UX aid only** — it does not enforce the format server-side.

---

- Force a phone-number field to accept only `(00) 0000-0000` as the user types.
- Mask a ZIP/postal-code text field to a fixed digit format.
- Constrain a date text field to `00/00/0000` (dd/mm/yyyy) input.
- Format an IP-address text field with the right dots and digit groups.
- Apply a credit-card-style grouping mask to a text input.
- Mask a Telephone (`telephone_default`) field on a contact content type.
- Add an input mask to a plain Text field (`string_textfield`) on any bundle.
- Add a `#mask` property to a custom form's textfield to format user input.
- Mask a `tel` element in a bespoke Form API form.
- Apply the mask right-to-left (`reverse`) for money/decimal-style inputs.
- Clear an input automatically if the user leaves it not matching the mask (`clearifnotmatch`).
- Select the whole field value on focus (`selectonfocus`) for quick re-entry.
- Define a custom placeholder symbol (e.g. a letter class) in the module's pattern table.
- Restrict a serial/reference code field to letters-and-numbers using the `A` symbol.
- Standardise data entry so stored values are consistently formatted.
- Reduce validation errors by preventing malformed input at entry time.
- Register masking support for a third-party field widget via `<module>.mask_field_widgets.yml`.
- Extend Form API masking to additional element types through `ElementHelper`.
- Serve the jQuery Mask Plugin from a local file instead of the CDN for privacy/offline use.
- Configure whether a mask symbol is optional or repeats recursively.
- Provide editors an obvious format hint by constraining keystrokes.
- Mask product SKU fields to a company-specific pattern.
- Enforce a consistent membership-number format on a registration form.
- Format a tax-ID / national-ID text field as it is typed.
