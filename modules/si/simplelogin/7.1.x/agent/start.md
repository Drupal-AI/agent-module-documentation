# Simple Login — agent index

Restyles the anonymous **login / register / password / `/user`** pages with a background
image or color, a centered form card, and placeholder inputs. All config in one object. No
dependencies, no plugins, no Drush, no own permissions (form uses `administer site configuration`).

- **All settings keys, the config route & permission** →
  [configure/settings.md](configure/settings.md)
- **Themed paths, the `page--simplelogin` template, theme override, `hook_simplelogin_paths_alter`** →
  [theming/pages.md](theming/pages.md)

Key facts:
- Config object `simplelogin.settings`; form `/admin/config/simplelogin` (route
  `simplelogin.admin_settings_form`), permission `administer site configuration`.
- Keys: `background_active` (bool image-vs-color), `background_image` (managed file id seq),
  `background_color` (string, default `#00bfff`), `background_opacity` (bool),
  `button_background` (bool), `wrapper_width` (int, default 360), `unset_active_css` (bool),
  `unset_css` (string), `visually_hidden_labels` (bool, default true).
- Only affects **anonymous** users on `/user`, `/user/login`, `/user/password`, `/user/register`
  (extendable via `hook_simplelogin_paths_alter`).
- Template `page--simplelogin.html.twig` (override in your theme's `templates/`).
