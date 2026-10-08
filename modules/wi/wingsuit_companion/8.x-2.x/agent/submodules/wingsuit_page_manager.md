<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `wingsuit_page_manager` — theme negotiator for Page Manager

Forces Page Manager's layout-builder editing steps to render in the site's default frontend theme,
and adjusts the `gin_lb` toolbar/route detection for those steps. Dependency: `drupal:text`.

## Mechanism

- **`PageManagerThemeNegotiator`** (`src/Theme/`, service tag `theme_negotiator` **priority 41**,
  args `@config.factory`, `@gin_lb.context_validator`). `applies()`/`determineActiveTheme()` return
  the value of `getActiveTheme()`, which — when `gin_lb.context_validator->isLayoutBuilderRoute()`
  is true — returns `system.theme:default` (the frontend default theme). Otherwise it returns
  nothing and the negotiator does not apply.
- **`wingsuit_page_manager.module`**
  - `hook_gin_lb_show_toolbar_alter` — hides the gin_lb toolbar on
    `entity.page.add_step_form` / `entity.page.edit_form` when the `step` route parameter ends with
    `layout_builder`.
  - `hook_gin_lb_is_layout_builder_route_alter` — marks those same Page Manager layout-builder steps
    as Layout Builder routes so gin_lb treats them correctly.

No routes, entities, config, or permissions of its own. Note: despite depending only on
`drupal:text`, it references the `gin_lb` service and hooks, so it is effectively usable only with
`gin_lb` and `page_manager` present.
