<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Icons is a base **API module** for using icons in Drupal. It defines an `icon_set` config entity, an **IconLibrary** plugin type (one plugin per icon library), a render element and a picker form element, and a `list_icon` field type with widget and formatter. Icons are rendered as CSS icon-font `<span>` elements addressed as `set_id:icon_name`, so a site can adopt several icon libraries and swap providers without changing how icons are stored.

---

Rather than binding a site to one icon library, Icons provides the abstraction: you enable a provider submodule (`icons_fontawesome`, `icons_fontello`, `icons_icomoon`) or supply your own IconLibrary plugin, then create Icon Sets at `/admin/appearance/icon_set` (gated by `administer site configuration`). Each set pairs a plugin with its settings — for the bundled JSON providers, a local library path whose metadata file (`selection.json` / `config.json` / `icon-families.json`) is parsed into the set's icon list. Once a set exists, icons appear everywhere the module wires them in: a `list_icon` field on any entity (with a styled select widget or the searchable fontIconPicker widget from `icons_iconpicker`), a `#type => 'icon'` render element for code, and built-in prefix/suffix icon pickers on menu link content items and Views menu displays that render into the menu via `hook_preprocess_menu`. Rendering is always class-based (an IconLibrary plugin's `build()` adds CSS classes and attaches the set's stylesheet); there is no inline SVG. Because Drupal 11.1 shipped a core icon API with overlapping scope, a site on current core should check whether core's own support suffices before adding this.

---

- Adopt several icon libraries on one site behind one API.
- Add Font Awesome, IcoMoon or Fontello icons to content.
- Give editors a searchable icon picker widget.
- Add an icon field to nodes, taxonomy terms or any entity.
- Render an icon from code with a `#type => 'icon'` render array.
- Add a prefix/suffix icon to a menu link.
- Add an icon to a Views menu tab or link.
- Switch icon provider without changing stored field values.
- Add a bespoke icon library by writing an IconLibrary plugin.
- Keep icon-set definitions in exportable configuration.
- Store icon choices as portable `set:name` string values.
- Group icons by set in the field-add and select UIs.
- Point an Icon Set at a locally hosted webfont library.
- Reuse one icon abstraction across modules and themes.
- Override icon markup per provider or per set via theme suggestions.
- Provide icons for a component or design system.
- Let a theme ship its own icon set plugin.
- Standardise icon handling across entity types.
- Migrate a site between icon libraries.
- Enable only the provider submodules a site actually uses.
