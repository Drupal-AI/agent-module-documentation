Coloris Widget adds a dedicated `coloris_color` field type, a matching text-field widget, a formatter, and a reusable `coloriswidget` form element that render the [Coloris](https://coloris.js.org/) JavaScript color picker for choosing HEX/RGB/HSL colors.

---

The module defines the `coloris_color` field type (`ColorisItem`, a single `varchar(255)` `value` column, max length constrained to 36) with a rich per-field settings form: theme (`default`/`large`/`polaroid`/`pill`), light/dark/auto mode, output `format` (hex/rgb/hsl/auto/mixed), alpha/force-alpha, swatches-only, focus/select input, a clear button with custom label, an AJAX-managed list of preset swatches, inline mode, and a default color. The default widget `text_coloris` (extends `StringTextfieldWidget`) and the `coloriswidget` render element (extends core `Textfield`) turn those settings into `data-*` attributes on the input and attach the `coloris/element.coloris` library, which pulls the Coloris CSS/JS. On input, `ColorisWidget::validateFormElement()` runs a strict regex accepting only `#hex`, `rgb()/rgba()`, and `hsl()/hsla()` strings, rejecting anything else with a form error. The `coloris_color` formatter outputs the stored value as markup (splitting on `/` and using `FieldFilteredMarkup::allowedTags()`). **The Coloris library itself is loaded from a jsDelivr CDN pinned to `@latest`** (`coloris.libraries.yml` → `element.coloris.lib`), so the exact third-party script version is not pinned by the module. Depends only on core `options`; no admin config page, no permissions, no Drush.

---

- Add a color-picker field to a content type, taxonomy term, user, or any fieldable entity.
- Let editors pick colors visually instead of typing hex codes.
- Store a brand/accent color per node and render it (e.g. in a template or inline style).
- Offer a constrained palette by configuring preset swatches editors choose from.
- Force swatches-only mode so editors can only pick from approved colors.
- Capture colors with transparency using the alpha channel.
- Always emit an explicit alpha value with force-alpha.
- Output colors as HEX, RGB(A), HSL(A), auto-detected, or "mixed" (hex unless alpha < 1).
- Show a light, dark, or auto-themed picker to match the admin theme.
- Choose a picker style: default, large, polaroid, or pill thumbnail.
- Add a clear button (with a custom label) so editors can reset a color.
- Render the picker inline (always visible) rather than opening on focus.
- Set a default color used when an inline picker initializes.
- Validate entered color strings server-side to reject malformed values.
- Use the `coloriswidget` render element in a custom form to get a Coloris-powered input.
- Reuse the same field for theme settings, campaign colors, or event tags.
- Let users set a personal profile/avatar accent color.
- Provide a color field for design-token or style-guide content.
- Adjust the gap between input and dialog via the margin setting.
- Focus or select the value input automatically when the dialog opens.
- Toggle output format from within the picker via format-toggle buttons.
- Self-host the Coloris asset instead of the CDN by overriding the `element.coloris.lib` library.
- Display a chosen color's raw value with a field formatter.
- Support multi-value color fields (multiple swatches per entity).
