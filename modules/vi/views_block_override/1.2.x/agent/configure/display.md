<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the "Block with overrides" display

## Adding the display

In the Views UI, add a new display and pick **"Block with overrides"** (plugin id `views_block_override`). It behaves like a normal Block display but exposes extra per-instance overrides. Place the resulting block via Block Layout, Layout Builder, or a Block Field.

## Allow options (display level)

In the display's *Block settings → Allow settings* (`buildOptionsForm`, section `allow`), on top of core's **Items per page** you can enable:

| Allow key | Label | Enables per-block override of |
|---|---|---|
| `contextual_filter` | Contextual filters | the view's contextual arguments |
| `exposed_sort` | Exposed sort | sort field + direction |
| `pager_id` | Pager ID | the pager id (multi-pager pages) |
| `more_link_text` | More link text | the "more" link label |
| `more_link_custom_url` | More link URL | the "more" link target URL |

Only enabled options appear in the block form. `optionsSummary()` lists the enabled ones in the display summary. Stored under `display_options.display_extenders`-style `allow` mapping (schema `views.display.views_block_override`).

## Per-block form fields (`blockForm()`)

For each enabled allow option the block configuration form shows:

- **contextual_filter** — one control per view argument, gated by an "Override <arg>" checkbox:
  - default: `textfield` for the value.
  - if the argument has a validator `entity:<type>`: `entity_autocomplete` (`#target_type` set; `#selection_settings[target_bundles]` applied when `validate_options.bundles` is set).
  - if the validator targets a `*_type` (bundle) entity: `radios` (single) or `checkboxes` (when `break_phrase` is on), options = the bundle labels.
- **exposed_sort** — `sort_by` select (built from the view's sort handlers, using exposed label or machine name) + `sort_order` select (ASC/DESC).
- **pager_id** — an "Override pager ID" checkbox + a `number` field (min 0).
- **more_link_text** — a `textfield`.
- **more_link_custom_url** — a `textfield`.

## Save (`blockSubmit()`)

Values land in `$form_state['override'][<derivative_id>]` and are merged into the block's own configuration:
- `contextual_filter`: per-argument, saved as `['enabled' => TRUE, 'value' => ...]` only when its override checkbox is on; removed when off.
- other types: saved when their control field is enabled, removed when disabled; plain values saved when non-empty.

## Apply at render

- `preBlockBuild($block)`:
  - **exposed_sort**: if `config['exposed_sort']['sort_by']` is set, that sort is set as the display's only sort with the chosen order.
  - **pager_id**: if `config['pager_id']['enabled']`, the display's pager `options.id` is set to the value. (Both are guarded by the `exposed_sort` allow flag in current code.)
- `execute()`:
  - **contextual_filter**: for each enabled filter, its value is placed at the matching argument index (`$view->args`); array values are joined with `+` (OR-style). `$view->setArguments()` is called.
  - **more_link_custom_url**: sets `use_more=TRUE`, `link_display='custom_url'`, `link_url=<value>`.
  - **more_link_text**: sets `use_more_text` when `use_more` is already on.

## Notes

- Multiple contextual filters combine with AND; for OR use the *Views Contextual Filters OR* module (per README).
- No permissions are added — access is governed by normal Views block placement and the block's own visibility/access.
- Block instance override values are stored in the block plugin configuration (e.g. `block.block.*` for placed blocks, or inline block/Layout Builder component config), validated by the core ViewsBlock settings schema plus this display's schema.
