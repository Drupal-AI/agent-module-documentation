<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LB Theme Switcher — configure

Switches the active front-end theme to a Layout Builder-capable theme (e.g. Open Y
Carnation) when a visitor views Layout Builder pages, so LB components render in a
theme that supports them while the rest of the site keeps its custom theme.

## Settings form
Route `lb_theme_switcher.form` — `/admin/openy/settings/theme-switcher`
(permission `administer site configuration`). Config `lb_theme_switcher.settings`:
- **theme_name** — the installed, enabled theme to switch to on LB pages (validated
  against the theme handler).
- **handle_http_exception_routes** — also use it on 404/403 error pages.
- **handle_webform_routes** — also use it on `entity.webform.canonical` and
  `webform.user_submissions`.

## When the theme applies (LayoutBuilderThemeNegotiator, priority 1001)
`applies()` returns FALSE on admin routes. Otherwise it switches when:
- the route is `layout_builder.overrides.node.view` / `layout_builder.defaults.node.view`, or
- a node canonical view where the node has `field_use_layout_builder` truthy, or the
  LB overrides field is present;
- optionally on the configured 404/403 and webform routes.

For AJAX requests it honours `ajax_page_state[theme]` when the accompanying
`theme_token` validates against the CSRF generator (empty token falls through to
the configured theme), matching core's AJAX theme handling.

## Requirements / notes
- Effectively requires `layout_builder` (uses `OverridesSectionStorage`); not listed
  in info.yml dependencies. Intended for the Open Y / YMCA Website Services stack.
- Attaches an `lb_theme_switcher/lb_styling` library on every page
  (`hook_preprocess_page`).
