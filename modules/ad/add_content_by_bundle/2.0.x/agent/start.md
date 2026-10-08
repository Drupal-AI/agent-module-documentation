<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add Content by Bundle — agent index

A single **Views area handler** (`add_content_by_bundle`) that renders an "add content" link
in a view's **header or footer**, pointing at the add-form of a chosen bundle. No configure
route, no permissions, no Drush, no services beyond a `hook_views_data` implementation, no
plugin types. All state lives inside the view config under `header`/`footer`.

- **Add & configure the area (all option keys, where they are stored, drush/config)** →
  [configure/views-area.md](configure/views-area.md)
- **How it resolves the add URL per entity type, access checks, modal/tray, tokens, group** →
  [api/behavior.md](api/behavior.md)

Key fact: the handler id is `add_content_by_bundle` (registered via
`hook_views_data()` on `views.add_content_by_bundle`). In a view it appears at
`display.display_options.<header|footer>.add_content_by_bundle` with options
`type` (entity type), `bundle` (bundle machine name, stored as a plain string),
`label`, `class`, `target` (`''`/`tray`/`modal`), `width`, `destination`, `params`,
`login_redirect`, `group`, and `form_mode`.
