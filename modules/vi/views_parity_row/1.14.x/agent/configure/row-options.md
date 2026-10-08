<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Views Parity Row on a view

There is no global settings page. You select the row plugin and set its options **inside a view's
display**, under *Format → Show*.

## Select the row plugin

In the view's **Format** section, set **Show** to **"<Entity type> (alternate)"** — the plugin id is
`views_parity_row_entity:<entity_type>` (e.g. `views_parity_row_entity:node` for a content/node view).
It only appears for the entity type the view is based on (any entity type with Views integration and a
view builder). The view must be an **entity** row context (not "Fields").

## Row option keys

Open the row settings ("Settings" next to Show). The form (`EntityRow::buildOptionsForm`) offers:

**Base**
- `view_mode` — the **primary** view mode used for normal rows (core Entity-row option).

**Cadence (every X rows)**
- `views_parity_row_enable` (checkbox) — turn cadence alternation on.
- `views_parity_row.frequency` (int, default `2`) — switch to the alternate mode every N rows.
- `views_parity_row.start` (int, default `0`) — first row index (0-based) the cadence applies from.
- `views_parity_row.end` (int, default `0`) — stop applying at this index; **`0` means no end** (apply
  to the end of the result set).
- `views_parity_row.view_mode` (string, default `default`) — the **alternate** view mode.

**Per-row (fixed slots)**
- `views_parity_row_per_row_enable` (checkbox) — turn per-row alternation on.
- `views_parity_row_per_row.view_mode_1` … `view_mode_20` — an explicit view mode for each of the first
  20 rows (empty = no override → falls back to `view_mode` / cadence result).

Per-row takes precedence: if a per-row `view_mode_<n>` is set for a row, it overrides the cadence result
for that row (see `plugins/entity-row.md`).

## Where it is stored (config)

Inside the view config entity `views.view.<id>`, on the display's row plugin:

```yaml
display:
  default:
    display_options:
      row:
        type: views_parity_row_entity:node
        options:
          view_mode: teaser                 # primary
          views_parity_row_enable: true
          views_parity_row:
            frequency: '3'
            start: '0'
            end: '0'
            view_mode: full                 # alternate every 3rd row
          views_parity_row_per_row_enable: false
          views_parity_row_per_row: {  }
```

Schema: `views.row.views_parity_row_entity:*` (`config/schema/views_parity_row.views.schema.yml`),
type `views_entity_row` plus the `views_parity_row_enable` boolean and the `views_parity_row` mapping.
(The per-row keys are read by the plugin; the shipped schema formally documents the cadence keys.)

## Read / set via drush

```bash
# inspect a view's row plugin config
drush cget views.view.MYVIEW display.default.display_options.row

# set the row plugin + cadence programmatically
drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("MYVIEW");
  $d = $v->get("display");
  $d["default"]["display_options"]["row"] = [
    "type" => "views_parity_row_entity:node",
    "options" => [
      "view_mode" => "teaser",
      "views_parity_row_enable" => true,
      "views_parity_row" => ["frequency" => "3", "start" => "0", "end" => "0", "view_mode" => "full"],
      "views_parity_row_per_row_enable" => false,
      "views_parity_row_per_row" => [],
    ],
  ];
  $v->set("display", $d)->save();
'
```

After saving, rebuild caches (`drush cr`) and the listing renders every 3rd row (from `start`) in the
`full` view mode and the rest in `teaser`.
