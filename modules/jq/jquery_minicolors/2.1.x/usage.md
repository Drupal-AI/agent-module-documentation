jQuery MiniColors adds a color-picker field widget (`jquery_minicolors_widget`) for plain-text (`string`) fields, turning a normal text input into a jQuery MiniColors swatch/hex/RGB picker on entity edit forms.

---

The module provides a single field widget plugin, `jquery_minicolors_widget`, that extends core's `StringTextfieldWidget` and applies to `string` (Text plain) fields. Selected on a field's *Manage form display*, it renders the text input with class `mini-colors` and a set of `data-*` attributes read from the widget settings, which the bundled `js/jquery-minicolors.js` uses to initialise the MiniColors picker. It has a rich per-widget settings form (stored under `field.widget.settings.jquery_minicolors_widget`): `control` (hue/brightness/saturation/wheel), `format` (hex/rgb), `opacity`, `swatches` (pipe-separated colors), `position`, `theme` (default/bootstrap), `inline`, `animation_speed`/`animation_easing`, `change_delay`, `letter_case`, `show_speed`/`hide_speed`, `keywords`, plus core's textfield `size` and `placeholder`. It stores the chosen color as a plain string in the field (e.g. `#ff0000`) — no separate field type. It relies on the external **jQuery MiniColors** JavaScript library (v2.2.4) which must be installed at `/libraries/jquery-minicolors/` (a `hook_requirements()` check reports missing files on the status page). No admin config page, no permissions, no Drush.

---

- Let editors pick a hex color for a "brand color" text field via a swatch picker.
- Provide an RGB color picker on a field by setting the widget format to `rgb`.
- Offer preset brand colors as clickable swatches on a color field.
- Add an opacity/alpha slider to a color input (`opacity` on).
- Use a color wheel control instead of a hue slider (`control: wheel`).
- Render the picker inline (always open) rather than as a dropdown (`inline`).
- Constrain color entry to uppercase or lowercase hex (`letter_case`).
- Position the picker dropdown (bottom left/right, top left/right).
- Theme the picker with the bootstrap skin (`theme: bootstrap`).
- Give a "background color" field a friendly visual input instead of raw hex typing.
- Add a color picker to a paragraph/component field for per-section theming.
- Collect a color value on a webform-style string field for later CSS use.
- Store a chosen color as a plain string usable directly in inline styles/tokens.
- Provide accent-color selection on a user profile string field.
- Set a placeholder and input size on the color text field.
- Tune the picker animation speed/easing and show/hide speed.
- Allow keyword values (e.g. `transparent`, `inherit`) via the `keywords` setting.
- Add a color picker to a taxonomy term field (e.g. category color).
- Let a media entity carry a dominant-color string chosen with the picker.
- Standardise color entry across content types with one reusable widget.
- Migrate a hand-rolled color input to a configurable MiniColors widget.
- Give marketing a quick visual color selector without a custom module.
- Capture link/button colors as strings for a design-token field.
