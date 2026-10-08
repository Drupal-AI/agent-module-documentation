<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Font Icon Picker adds a field (type, widget, formatter) and a reusable `font_iconpicker` form element whose widget is a searchable visual icon chooser, driven by whatever custom icon font a site already uses rather than by a bundled icon set.

---

Most Drupal icon modules ship a fixed library — Font Awesome, Bootstrap Icons — and lock the site to it. Font Icon Picker inverts that: you point it at your own icon font's stylesheet on the settings form at `/admin/config/user-interface/font-iconpicker` (giving the CSS path, a class prefix, an optional extra class, and one of four widget themes), and it reads the icon classes straight out of that CSS. The `font_iconpicker.icon_helper` service parses the stylesheet for classes matching the prefix; the picker element (a core Select subclass wrapping the jQuery fontIconPicker library, v3.1.1, installed at `/libraries/fonticonpicker`) presents them visually with an optional search box. The chosen value is stored as a single class string in a `varchar(50)` field column and rendered by the formatter through the `font_icon` theme hook as an `<i>` element carrying that class. It depends only on core `field`, exposes one settings route gated by `administer site configuration`, and declares no permission of its own; `core_version_requirement` of `^10.3 || ^11 || ^12` already spans Drupal 12. The trade-off of the bring-your-own-font approach is that the icons an editor sees are only as good as the font's CSS — the picker lists exactly the prefixed classes it finds there.

---

- Let editors pick an icon from the site's own icon font.
- Add an icon field to a content type or other entity.
- Use a bespoke corporate icon set in Drupal without bundling one.
- Reuse the `#type => 'font_iconpicker'` element in a custom form.
- Show a visual picker instead of a class-name text field.
- Turn on a search box when the font has many icons.
- Keep icon choices consistent with the design system.
- Render a chosen icon through the `font_icon` Twig template.
- Apply an extra required class (e.g. IcoMoon's `icon`) to every rendered icon.
- Switch the picker's skin between Bootstrap, grey, dark-grey and inverted themes.
- Support a different icon font by re-pointing the CSS path.
- Prevent typos in hand-entered icon classes.
- Install the icon font via the supplied composer.libraries.json merge file.
- Match icons to a brand's design tokens.
- Provide icons for a landing-page component library.
- Preview icons live while editing.
- Move away from a hard-coded icon list.
- Read the available icon list programmatically via the icon_helper service.
- Give a card or CTA component an editor-chosen icon.
- Prepare an icon field for Drupal 12.
