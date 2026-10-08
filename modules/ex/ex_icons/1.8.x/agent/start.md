# External-use Icons (ex_icons) — agent index

Discovers `<symbol>` icons from any module/theme `dist/icons.svg` sprite and exposes them as plugins,
rendered with `<svg><use href>`. Ships no icons. No dependencies, no permissions, no global config page
(`configure` null). Provides a plugin type (`ex_icons`), a config schema (field plugins), and one Drush
command.

- **Field API: `ex_icon` field type, `ex_icon_select` widget, `ex_icon_default` / `ex_icon_link`
  formatters** → [configure/fields.md](configure/fields.md)
- **Rendering & extension: `ex_icons.manager` plugin manager, SVG discovery, the `ex_icon` theme hook &
  Twig function, the `ex_icon_select` form element, Drush, `hook_ex_icons_alter`** →
  [api/icons.md](api/icons.md)

Key facts:
- Sprites are read from `<module_or_theme>/dist/icons.svg` (constant `ExIconsManager::BASENAME =
  'dist/icons'`). Each `<symbol id viewBox>` becomes an icon; `<title>` becomes the (translatable) label.
- Icon URL form: `<file_url>?<sha256-16>#<id>`; rendered as `<svg{{attributes}}><use href="{{url}}"/></svg>`.
- Definitions cached (`cache.discovery`, tag `ex_icons`); auto-cleared on module/theme install/uninstall;
  `drush cache-clear ex-icons` clears manually. Fallback plugin id `ex_icon_null`.
- SVG sprites are extension-shipped code (trusted), not user uploads.
