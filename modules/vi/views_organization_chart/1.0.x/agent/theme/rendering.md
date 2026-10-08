<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: template, preprocess, library & assets

How a view's rows reach the Highcharts organization chart in the browser.

## Template

`templates/views-style-views-organization-chart.html.twig` — theme hook
`views_style_views_organization_chart`. It renders almost nothing itself; Highcharts draws into
the empty div:

```twig
<figure class="highcharts-figure">
  <div id="{{ chart_id }}" class="views-view-organization"></div>
  {% if description %}<p class="highcharts-description">{{ description }}</p>{% endif %}
</figure>
```

- `chart_id` = `"{view_id}-{display_id}"` (also the drupalSettings key and the JS lookup id).
- `description` = the view's stored `description` (Twig auto-escapes it).

## Preprocess — the data build

`template_preprocess_views_style_views_organization_chart(&$variables)` in
`views_organization_chart.module` does the real work:

1. Attaches the library `views_organization_chart/views_organization_chart`.
2. `chart_id = view->id() . '-' . view->current_display`.
3. Builds `levels[]` from `options['levels_color']` (`explode(',')`) as `(object){level, color}`.
4. Loads the core `thumbnail` image style once.
5. Loops `view->result`; for each row:
   - `parent = view->field[parent_field]->getValue($row)` (`current()` if array, else `0`).
   - `nodes[$id]['id'] = row->_entity->id()`.
   - if `parent` truthy and `parent != row entity id` → append edge `data[] = [parent, id]`.
   - if `image_field` set → load the file, `nodes[$id]['image'] = thumbnail->buildUrl(file uri)`.
   - if `name_field` set → `nodes[$id]['name'] = field->advancedRender($row)`.
   - if `title_field` set → `nodes[$id]['title'] = field->advancedRender($row)`.
   - if `name` empty → promote `title` into `name`.
6. Attaches drupalSettings under the chart id:
   ```php
   $variables['view']->element['#attached']['drupalSettings'][$chart_id] = [
     'data'   => $data,                 // array of [fromId, toId] edges
     'levels' => $levels,               // [{level, color}, …]
     'nodes'  => array_values($nodes),  // [{id, name, title?, image?}, …]
     'title'  => $view->getTitle(),
   ];
   ```

Node labels are produced by Views' field render pipeline (`advancedRender`) and passed to the
client only through `drupalSettings` (Drupal JSON-encodes it into the
`drupal-settings-json` script element). No row value is written into the page markup or into a
JS string by this module.

## JavaScript

`js/views-organization-chart.js` — `Drupal.behaviors.organization`, wrapped in `once('organization', '.views-view-organization')`. For each chart div it reads
`drupalSettings[id].{levels,nodes,data,title}`, copies them onto a shared Highcharts config
(`series[0].type = 'organization'`, `keys: ['from','to']`, default color `#007ad0`, white data
labels, `chart.height = 600`, `chart.inverted = true`), then calls `Highcharts.chart(id, config)`.
Labels render as SVG text (no `useHTML`); `exporting.allowHTML` only affects the export module.

## Library & asset source

`views_organization_chart.libraries.yml` → library `views_organization_chart`:

- **JS (external, from the Highcharts CDN, protocol-relative `//code.highcharts.com/…`, `type: external`, `minified: true`, `crossorigin: anonymous`, no SRI hash):**
  - `highcharts.js`
  - `modules/sankey.js`
  - `modules/organization.js`
  - `modules/exporting.js`
  - `modules/accessibility.js`
- **JS (local):** `js/views-organization-chart.js`
- **CSS (component):** `css/views-organization-chart.css` (sizes `.highcharts-figure` to `min 360px / max 800px`, plus data-table styling).
- **Dependencies:** `core/drupalSettings`, `core/jquery`, `core/once`.

The Highcharts runtime is fetched from `code.highcharts.com` at page load rather than bundled with
the module, so the chart requires outbound access to that host (and Highcharts' own licensing terms
apply). There is no local copy and no `configure`/settings surface to change the source.
