<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# font_iconpicker — agent index

Provides a **Font Icon Picker** field (type + widget + formatter) and a reusable
`#type => 'font_iconpicker'` render element: a searchable visual picker that stores one CSS
icon class (`varchar(50)`) and renders it as `<i class="…">`. Icons are read from YOUR OWN
icon font's CSS — no icon set is bundled. Wraps the jQuery **fontIconPicker** library
(v3.1.1), which must be installed at `/libraries/fonticonpicker`.

Depends on core `field`. Core: `^10.3 || ^11 || ^12`. Declares **no permission of its own** —
the settings route uses core `administer site configuration`.
Configure: route `font_iconpicker.settings` → `/admin/config/user-interface/font-iconpicker`.

- **Configure the font source, class prefix, widget theme** → [configure/settings.md](configure/settings.md)
- **Add / render an icon field; use the render element** → [fields/field.md](fields/field.md)
- **Icon-list service, dynamic library, theme hook (integrate)** → [api/icon-helper.md](api/icon-helper.md)

Key facts:
- Config object `font_iconpicker.settings` — keys `css_font_path`, `class_prefix`, `additional_class`, `theme` (default `grey`).
- Service `font_iconpicker.icon_helper` (`Drupal\font_iconpicker\IconHelper`, iface `IconHelperInterface`) → `getIconsAvailable(): array`.
- Field plugin id `font_iconpicker` (type / widget / formatter); widget setting `has_search`.
- Render element `#type => 'font_iconpicker'` (`Drupal\font_iconpicker\Element\FontIconpicker`, extends core `Select`); property `#has_search`.
- Theme hook `font_icon` (template `font-icon.html.twig`); preprocess `template_preprocess_font_icon` (in `.module`).
- Dynamic library `font_iconpicker/font-custom` (const `FONT_LIBRARY_NAME = 'font-custom'`) built in `hook_library_info_alter`.
- `hook_requirements` (runtime) errors if `/libraries/fonticonpicker/js/jquery.fonticonpicker.min.js` is missing.
