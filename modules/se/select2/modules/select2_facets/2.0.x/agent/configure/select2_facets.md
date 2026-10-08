# Configure the Select2 facet widget

Requires the **Facets** and **Select2** modules. There is no global settings form — you pick the
Select2 widget on an individual facet.

1. Create/edit a facet (Facets module, e.g. `/admin/config/search/facets`).
2. Set its **Widget** to **Select2** (`FacetsWidget` plugin id `select2`).
3. Configure the widget:

| Setting | Default | Meaning |
|---|---|---|
| `width` | `'100%'` | Container width — any CSS value, or `element` / `computedstyle` / `style` / `resolve` |
| `autocomplete` | `false` | Lazy-load facet values over AJAX instead of rendering them all |
| `match_operator` | `'CONTAINS'` | Autocomplete matching: `STARTS_WITH` or `CONTAINS` (only shown when autocomplete is on) |

The widget also honours standard facet settings:

- **Show only one result** → single-select (`#multiple` off) vs multi-select.
- **Show numbers** → appends result counts, e.g. `Article (12)`.

Options are built from each facet result's URL; active results are pre-selected. Selecting a
value auto-submits the facet form (`js/select2-widget.js`).

Config schema: `facet.widget.config.select2` (in `select2_facets.schema.yml`). Stored on the
facet config entity, so it exports/deploys with `drush config:export`.
