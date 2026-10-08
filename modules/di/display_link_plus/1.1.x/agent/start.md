<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Link Plus (display_link_plus) — agent index

A single **Views area handler** (`@ViewsArea("display_link_plus")`) that you add to a view's
**Header** or **Footer** to render a link to *another display in the same view*. It improves on
core's `display_link` area plugin by running an **access check at render time** (`#access` comes from
`$view->access($display_id)`) so the link only appears to users who can reach the target display. It
also lets a site builder override the link label, add CSS classes (e.g. to style it as a button),
open the target in a **modal** or **off-canvas tray** dialog at a chosen width, map the view's
contextual-filter arguments into query parameters, and optionally append a `destination` parameter so
the target form returns the user to the listing. It only links to **path-based displays** (anything
extending `PathPluginBase` — `page`, `feed`, etc.); block/attachment/embed displays are filtered out
of the option list and rejected again at render.

Mechanism: `hook_views_data()` in `display_link_plus.views.inc` registers the area under
`$data['views']['display_link_plus']`; the plugin class
`src/Plugin/views/area/DisplayLinkPlus.php` (extends `AreaPluginBase`, uses
`RedirectDestinationTrait`) defines the options, builds the settings form, and in `render()`
assembles a `#type => 'link'` render array pointing at `$view->getUrl(NULL, $display_id)` with the
computed query. There is no runtime user input path — everything is configured per view by an admin.

- Depends on: `drupal:views` (core). No other modules, no composer libraries, no PHP constraint.
- Core: `^8.8 || ^9 || ^10 || ^11` (info.yml). Package: **Views**.
- No settings page / `configure` route — all configuration lives in the area handler's options form
  per view. No permissions, no `*.services.yml`, no routes, no drush, no plugin types defined.
  Provides config schema.
- Ships `display_link_plus_update_9000()` — a one-time update hook that turns **on**
  `append_destination` for every existing `display_link_plus` header/footer area (it defaults **off**
  for newly added instances).

## What you'd do → where

- **Add the link to a view header/footer, and every option/config key, render behavior, dialog
  targets, arguments-mapping, destination append, and the path-based-display constraint** →
  [views/area-handler.md](views/area-handler.md)

## Key facts (real machine names)

- Views area plugin id: `display_link_plus` (annotation `@ViewsArea`), class
  `Drupal\display_link_plus\Plugin\views\area\DisplayLinkPlus`, base
  `Drupal\views\Plugin\views\area\AreaPluginBase`.
- Views data hook: `display_link_plus_views_data()` registers `$data['views']['display_link_plus']`
  with `area` id `display_link_plus` (`display_link_plus.views.inc`).
- Option / config keys (`defineOptions()`): `display_id`, `label`, `class`, `target`
  (`'' | tray | modal`), `width` (default `'600'`), `append_destination` (bool, default `FALSE`),
  `arguments_mapping` (sequence of `{enabled, query_string, is_multiple}`).
- Config schema types: `views.area.display_link_plus` and `display_link_plus_argument_mapping`
  (`config/schema/display_link_plus.views.schema.yml`).
- Injected core services (via `create()`): `access_manager`, `current_user`.
- Update hook: `display_link_plus_update_9000()` (`display_link_plus.install`).
- Dialog wiring in `render()`: adds `use-ajax` class plus `data-dialog-type=modal` (modal) or
  `data-dialog-renderer=off_canvas` + `data-dialog-type=dialog` (tray), with
  `data-dialog-options={"width":N}`.
