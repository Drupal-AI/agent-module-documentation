# Yandex.Maps Examples — agent index

Developer/demo submodule of `yandex_maps`. No config, permissions, schema, or reusable API — just three
example routes (all `access content`) that render `yandex_map` elements. Depends on `yandex_maps`.
Enable only to learn or troubleshoot the parent module.

Routes (`yandex_maps_examples.routing.yml`):
- `/yandex-maps-examples/theme` → `YandexMapsExamplesController::themeExample()` — default/satellite/Point
  maps + the clusterize example, each with its render array printed.
- `/yandex-maps-examples/theme/clusterize` → `themeClusterizeExample()` — one clustered-placemarks map.
- `/yandex-maps-examples/form` → `YandexMapsExampleForm` — an editable `#type => 'yandex_map'`
  multi-object element (click add / double-click remove) that `debug()`s submitted values.

For the real API (element, widget, formatter, Views style, settings) see the parent:
[../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md).
