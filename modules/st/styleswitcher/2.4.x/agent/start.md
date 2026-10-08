<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style Switcher (styleswitcher) — agent index

Lets site visitors pick between alternate CSS stylesheets ("styles") and remembers the
choice in a cookie. Admins define named custom styles (each a label + a CSS file path or
external URL); themes can also provide styles via a `styleswitcher:` key in their `.info.yml`.
A block renders the switch links; when JS is enabled the active stylesheet is swapped live,
otherwise a redirect route persists the choice server-side.

- No module dependencies. Core requirement `^9.5 || ^10 || ^11`. `.info.yml` carries the legacy
  packaging string `version: '8.x-2.4'`.
- Configure route: `styleswitcher.admin` → `/admin/config/user-interface/styleswitcher`.
- Defines 1 permission, 1 block plugin, config schema, a ParamConverter, a local-task deriver,
  and D7 migrations. No Drush commands. No plugin *types* defined.

Solution docs:
- **Define/manage the switchable styles (admin form + theme .info.yml)** → [configure/styles.md](configure/styles.md)
- **Enable/reorder/default styles per theme** → [configure/styles.md](configure/styles.md)
- **Turn the fade overlay on/off (global settings)** → [configure/settings.md](configure/settings.md)
- **Place the switcher block / understand live-switch runtime** → [blocks/styleswitcher.md](blocks/styleswitcher.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)
- **Public helper functions, hooks, ParamConverter** → [api/functions.md](api/functions.md)

Key facts:
- Config objects (plain config, NOT config entities): `styleswitcher.custom_styles` (key `styles`),
  `styleswitcher.styles_settings` (key `settings`, per-theme weight/status/is_default),
  `styleswitcher.settings` (key `enable_overlay`, plus legacy `7206_theme_default`). All have schema.
- Permission: `administer styleswitcher` (gates every admin route).
- Block plugin id: `styleswitcher_styleswitcher` (admin label "Style Switcher").
- Admin routes: `styleswitcher.admin`, `styleswitcher.config_theme` (`/settings/{theme}`),
  `styleswitcher.style_add` (`/add`), `styleswitcher.style_edit` (`/custom/{style}`),
  `styleswitcher.style_delete` (`/custom/{style}/delete`).
- Runtime routes (no admin permission — switching is not privileged): `styleswitcher.switch`
  (`/styleswitcher/switch/{theme}/{type}/{style}`) and `styleswitcher.css` (`/styleswitcher/css/{theme}`),
  both `no_cache: TRUE` and gated by core `_access_theme: 'TRUE'`; `{style}` upcasts via the
  `styleswitcher_style` ParamConverter.
- Service: `styleswitcher.param_converter` (`\Drupal\styleswitcher\ParamConverter\StyleswitcherStyleConverter`).
- A "blank" style (`custom/default`, path NULL) always exists and just removes other styles' effect.
