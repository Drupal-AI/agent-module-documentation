# Mechanism: how the override is applied

No route, controller, or event/exception subscriber renders the pages. The module only
supplies **values** to core's existing `system.site` handling.

## Config factory override
- `SystemPageConfigOverride` (service `system_page_override.config_factory_override`,
  tagged `config.factory.override`, deps: `system_page_override.manager`, `language_manager`).
- `loadOverrides($names)` acts only on `system.site`. For the current interface language it
  reads the three stored targets via `SystemPageManager::getOverride()` and, for any that are
  set, injects them into the overridden config as:
  - `system.site:page.front`
  - `system.site:page.404`
  - `system.site:page.403`
- Cache metadata: context `languages:language_interface`, tag `config:system.site`.
- Because these are the same keys core's Site Information form writes, Drupal's normal front
  page controller and `CustomPageException*` (403/404) handling serve the target path — and that
  path is resolved through core's usual routing/access, so the target keeps its own access control.

## State storage (SystemPageManager, service `system_page_override.manager`, dep `@state`)
- Key format: `system_page_override:<page>:<langcode>`; value is a path string, always `/node/<id>`
  when set from the node form (`createPath()` = `'/node/' . $id`); the overview form can store any path text.
- `override($page,$lang,$path)` sets the key; `revert($page,$lang)` deletes it; `getOverride()`,
  `isOverridden()`, `isOverride($page,$lang,$path)` read it.
- Every `override()`/`revert()` calls `clearFrontpageCache()` → invalidates cache tags
  `config:system.site`, `route_match`, `http_response`.

## Node form wiring
- `system_page_override.module`: `hook_form_node_form_alter` delegates to
  `SystemPageOverrideNodeFormExtension` (class-resolved). It adds the checkboxes and appends a
  static `::submit()` handler to each non-preview submit button; that handler calls
  `SystemPageManager::override()` / `revert()` per page per language based on checkbox values.
