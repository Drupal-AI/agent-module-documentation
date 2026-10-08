<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Palette

## Create palette colors
Go to `/admin/structure/palette-colors` (permission `administer palette`) → **Add palette color**.
Each is a `palette_color` content entity with a label and a color value.

## Use the widget
On a field of type **Color Field** (`color_field_type`), open *Manage form display* for the
bundle and set the widget to **Palette** (`palette_color_widget`). Editors then pick from swatches;
the widget refreshes its selection via AJAX. The Entity Browser widget `palette_color_add` allows
adding a new palette color inline.

## Notes
- Routing requires the `administer palette` permission (the module also declares
  `administer palette_color`, marked restricted).
- Requires `color_field` and `entity_browser` enabled.
