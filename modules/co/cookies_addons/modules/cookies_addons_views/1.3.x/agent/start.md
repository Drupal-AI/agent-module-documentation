<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Views (cookies_addons_views) — agent index

Submodule of **Cookies Addons**. Gates a **Views display** (by view id + display id) behind a COOKiES
consent service. Package COOKiES. Core `^9.2 || ^10 || ^11`. Depends on `cookies:cookies` and
`drupal:views`. License GPL-2.0-or-later. Version 1.3.3.

- **Config, route, hooks and mechanism** → [config/settings.md](config/settings.md)

## What it provides

- `cookies_addons_views_preprocess_views_view()` — replaces the view `rows` with a placeholder
  `<div class="cookies-addons-views-placeholder" cookies-service view-id display-id data-args>` and
  attaches the JS library when the display is gated.
- `cookies_addons_views_views_pre_render()` — for gated views, unsets
  `$view->element['#attached']['drupalSettings']['views']` and `$view->element['#viewsreference']` to
  avoid duplicated settings; `cookies_addons_views_module_implements_alter()` moves this hook to run
  last.
- Helper `_cookies_addons_views_is_restricted($view_id, $display_id)` — FALSE on POST; parses
  `cookies_addons_views.settings:views` (`view|display|service` triples), reads the `cookiesjsr`
  request cookie (`json_decode`) and returns FALSE if that service is already accepted, else returns
  the service when view+display match.
- Controller `CookiesAddonsViewsController::getView($view_id, $display_id, $service, $arguments)`
  (`src/Controller/CookiesAddonsViewsController.php`) — builds a `#type => view` render element with
  `#arguments` from `$arguments` (as `field_value`), returns an `AjaxResponse` `ReplaceCommand`;
  attaches `leaflet/*` libraries when `$service === 'leaflet'`. View display access is still enforced
  by the core `#type => view` element.
- Form `SettingsForm` (`src/Form/SettingsForm.php`) — one textarea `views`.
- Routes: `cookies_addons_views.get_view` (POST, `access content`);
  `cookies_addons_views.settings_form` (permission `administer cookies_addons_views configuration` —
  **undefined project-wide; the form is unreachable until that permission exists**).
- Config schema `cookies_addons_views.settings` (`views: text`). Library
  `cookies_addons_views/cookies-addons-views`. Menu/task links under the COOKiES config group.
- No permissions file, services, plugins, Drush.

Privacy/consent gate, not access control.
