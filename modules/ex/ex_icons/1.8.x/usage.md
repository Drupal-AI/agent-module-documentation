Bridges SVG sprite-sheet icons into Drupal: any module or theme that ships a `dist/icons.svg` sprite has its `<symbol>` icons auto-discovered as plugins, then usable via a Twig function, a theme hook, a form element, and Field API (icon field type, picker widget, formatters). The module ships no icons itself.

---

`ExIconsManager` (a plugin manager) scans every installed module and theme directory for a `dist/icons.svg` file and parses each `<symbol id="…" viewBox="…">` into an icon plugin definition (id, width/height from the viewBox, optional `<title>` label, and a web URL of the form `path/to/icons.svg?<hash>#<id>`). Rendering uses external-referencing SVG (`<svg><use href="…#id"/></svg>`) via the `ex_icon` theme hook / `template_preprocess_ex_icon`, which also computes a missing width or height from the icon's aspect ratio and sets `role`/`aria-hidden` for accessibility. Front-end code can render icons with the `ex_icon(id, attributes, title)` Twig function, the `#type => 'ex_icon'` render element, or the `ex_icon_select` form element (a radios-based visual picker). Field API integration adds the `ex_icon` field type (stores an icon id + optional text alternative), the `ex_icon_select` widget, and two formatters: `ex_icon_default` (renders the icon, also works on plain string/list_string fields) and `ex_icon_link` (renders a link field *as* an icon, with rel/target options and token-replaced title). Definitions are cached and auto-cleared when modules/themes are installed/uninstalled; `drush cache-clear ex-icons` clears them manually. `hook_ex_icons_alter` lets code modify the discovered definitions.

---

- Let editors pick an icon from a visual grid when filling in a content field.
- Add an "icon" field to a content type (e.g. a call-to-action icon, a menu icon).
- Render a link field as just an icon (e.g. social links shown as icon buttons).
- Output an icon inline in a Twig template with `{{ ex_icon('shopping-cart', { height: 20 }) }}`.
- Use `#type => 'ex_icon'` in a render array to place an icon programmatically.
- Provide a theme's own icon set by shipping `dist/icons.svg` — no PHP needed.
- Collapse many icon HTTP requests into one shared sprite sheet for HTTP/1.1 performance.
- Give icons accessible semantics: a `<title>`/text alternative sets `role="img"`, otherwise `presentation`.
- Auto-size an SVG to its content by supplying only width or height (the other is derived from the viewBox).
- Add a required or optional text alternative to icon fields for accessibility compliance.
- Display an icon field with a fixed width/height across a view mode.
- Open an icon-link in a new window or add `rel="nofollow"` via the link formatter.
- Use tokens in an icon-link's text alternative (e.g. entity title) for meaningful labels.
- Apply an icon formatter to an existing plain string/list_string field without changing storage.
- Offer a site-wide, extension-provided icon vocabulary that stays in sync as modules/themes change.
- Clear the icon definitions cache after updating a sprite sheet with `drush cache-clear ex-icons`.
- Alter or relabel discovered icon definitions in code via `hook_ex_icons_alter()`.
- Build a custom form with a graphical icon chooser using the `ex_icon_select` element.
- Keep icon markup DRY by referencing symbols instead of inlining SVG per use.
- Version icon URLs with a content hash so browsers re-fetch only when the sprite changes.
- Support multiple providers (several modules/themes each shipping their own sprite) simultaneously.
