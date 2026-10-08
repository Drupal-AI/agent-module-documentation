<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Views — configuration & mechanism

## Enable

`drush en cookies_addons_views`. Requires COOKiES (`cookies`) and core Views, plus at least one
enabled `cookies_service` entity.

## Configure

Route `cookies_addons_views.settings_form` → `/admin/config/system/cookies-addons-views`.

- `views` (textarea, config `cookies_addons_views.settings:views`) — one entry per line, format
  `view_id|view_display_id|cookies_service_machine_name`.

Config object `cookies_addons_views.settings` (schema: `views` type `text`).

Caveat: the settings-form route requires permission `administer cookies_addons_views configuration`,
which is **not defined by any `*.permissions.yml` in the project**. An undefined permission denies
everyone, so the Views settings form is effectively unreachable unless that permission is provided by
another module. (The Blocks/Paragraphs forms instead use core `administer site configuration`.)

## Runtime mechanism

1. `_cookies_addons_views_is_restricted($id, $display_id)` returns FALSE on POST or when `views`
   config is empty. Otherwise it splits the config on newlines and, for each `view|display|service`
   triple, decodes the `cookiesjsr` request cookie (`json_decode(..., TRUE)`) and returns FALSE if
   `$cookies[$service]` is truthy (already consented); else returns the service when both the view id
   and display id match.
2. `cookies_addons_views_preprocess_views_view(&$variables)` — when gated, resolves the service label
   and rebuilds `$variables` so `rows` is an `html_tag` `div` with attributes
   `cookies-addons-views-placeholder`, `cookies-service`, `service-name`, `view-id`, `display-id`,
   `data-args` (the view's `args` joined by `+`), attaching library
   `cookies_addons_views/cookies-addons-views`. It preserves `theme_hook_original`.
3. `cookies_addons_views_views_pre_render($view)` — for gated views, unsets the view's
   `drupalSettings['views']` and any `#viewsreference` marker to prevent duplicate settings/JS.
   `cookies_addons_views_module_implements_alter()` reorders this hook to run last.
4. `js/cookies-addons-views.js` (`Drupal.behaviors.cookiesAddonsViews`) — on `cookiesjsrUserConsent`
   accept, `activate()` GETs `/cookies-addons-views/get-view/{viewId}/{displayId}/{service}/{args}`
   (note: this route is `GET` from the client though defined `methods: [POST]`; the request replaces
   the placeholder); on deny, `fallback()` calls `cookiesOverlay(service)`.
5. `CookiesAddonsViewsController::getView()` — builds `['#type' => 'view', '#name' => $view_id,
   '#display_id' => $display_id, '#arguments' => array_values($args)]` where `$args['field_value']`
   is the `{arguments}` slug when non-empty. For `$service === 'leaflet'` it also
   `addAttachments(['leaflet/leaflet-drupal', 'leaflet/leaflet.fullscreen'])`. Returns an
   `AjaxResponse` `ReplaceCommand` on the placeholder selector. The `#type => view` element performs
   the view's own display access check when rendering.

## Notes

- Unlike the block/paragraph gates, the view gate also honors the raw `cookiesjsr` cookie
  server-side, so a returning visitor who already consented sees the view rendered directly.
- `{arguments}` is passed straight into the view as a single contextual-filter value.
