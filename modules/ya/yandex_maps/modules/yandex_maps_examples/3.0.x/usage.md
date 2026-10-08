Demo submodule for Yandex.Maps: exposes a few example routes that render `yandex_map` elements (plain map, clustered placemarks, and an editable map form) so developers can see the API in action.

---

`yandex_maps_examples` is a developer/reference submodule with no config, permissions, schema, or reusable
API of its own. It registers three routes (all `access content`): `/yandex-maps-examples/theme` renders
several `#theme => 'yandex_map'` variants (default map, satellite, a single Point object, plus the
clusterize example) each dumped with its render array; `/yandex-maps-examples/theme/clusterize` renders a
single clustered-placemarks map; and `/yandex-maps-examples/form` renders a `YandexMapsExampleForm` with a
`#type => 'yandex_map'` multi-object editable element (click to add, double-click to remove) that
`debug()`s the submitted values. Enable it only to learn or troubleshoot the parent module; it is not
meant for production.

---

- See a working `#theme => 'yandex_map'` render array for a basic map.
- View a satellite-type Yandex map example.
- View a map rendered from a single GeoJSON Point object.
- See how clustered placemarks look with `map_clusterize`.
- Inspect the exact render-array structure printed above each example map.
- Try the editable `#type => 'yandex_map'` form element (add/remove point/line/polygon).
- Observe submitted map geometry via the form's `debug()` output.
- Copy a starting point for embedding a Yandex map in custom code.
- Verify the parent module's JS/library is wired up correctly after configuring an API key.
- Use as a smoke test that Yandex.Maps loads on the site.
- Reference the clusterize example's multi-point GeoJSON payload.
- Learn the coordinate order (`longlat`) expected by the element.
- Demonstrate the map element to stakeholders quickly.
- Confirm map controls/behaviors render as expected.
- Provide QA a fixed URL to test map rendering.
