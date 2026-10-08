# Configure Charts Blocks

Enable with `drush en charts_blocks -y`. Requires `charts` plus at least one library submodule
(e.g. `charts_highcharts`) to actually render.

## Two block plugins

| Block id | Admin label | Class | Data entry |
|---|---|---|---|
| `charts_block` | Charts block | `ChartsBlock` | AJAX data-collector table (labels + series values) |
| `charts_canvas_block` | Chart (Canvas) | `ChartsCanvasBlock` | CSV or JSON in a textarea; no AJAX table |

Both extend core `BlockBase`, store their chart configuration in the **block config**, and
render through the Charts `chart` render element (`Drupal\charts\Element\Chart` /
`BaseSettings`), so they inherit the site's library backend, chart types, color palette, alter
hooks, and accessible-table fallback.

## Placing a block

Add via **Admin → Structure → Block layout** (`/admin/structure/block`), or drop it into a
**Layout Builder** section or a **Drupal Canvas** layout. The block form lets you set: chart
library, chart type, title/subtitle, colors, legend, tooltips, dimensions, axis titles, and
the data itself. Standard core block-visibility conditions (path, role, content type) apply.

## Which block to use

- Use **`charts_block`** for normal block placement — its data-collector table is the friendliest editor.
- Use **`charts_canvas_block`** inside **Drupal Canvas**: it omits the AJAX table (which is
  unreliable in Canvas' component form) and takes CSV/JSON in a textarea instead, and it skips
  the built-in preview because Canvas renders a live component preview.

Config schema: `config/schema/charts_blocks.schema.yml`. Block config exports/deploys with the
containing block or layout.
