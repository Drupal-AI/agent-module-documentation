# Configure Views Fields On/Off

No admin settings page — you configure it inside a View. In a View with fields, add **Global:
On/Off Form** (a field) or **Global: On/Off Filter** (a filter). Both use plugin id
`views_fields_on_off_form`.

## Field handler (`Global: On/Off Form`)

Always exposed (`isExposed()` returns TRUE). Options (`views.field.views_fields_on_off_form` schema):

| Option | Values | Meaning |
|---|---|---|
| `fields` | list of field ids | Which of the View's fields the visitor may toggle. The options list only offers fields **positioned before** this handler in the field list. |
| `exposed_select_type` | `checkboxes` \| `radios` \| `select` \| `multi_select` | Exposed widget. `multi_select` renders a multiple `<select>`. |
| `default_enabled` | bool | If checked, the listed fields show by default; if unchecked they start hidden. |

The exposed element key is the handler's own field id; a hidden `fields_on_off_hidden_submitted=1`
element is added so a submit with nothing checked is distinguishable from a fresh load.

## Filter handler (`Global: On/Off Filter`)

Extends Views `InOperator`. You must tick **"Expose this filter to visitors…"** for it to appear.
Options (`views.filter.views_fields_on_off_form` schema, plus inherited InOperator options):

| Option | Values | Meaning |
|---|---|---|
| `value` | list of field ids | The toggleable fields (InOperator values = the View's field labels). |
| `operator` | `in` \| `not in` | `not in` inverts: selected fields are the ones **hidden**. |
| `exposed_select_type` | `checkboxes`/`radios`/`select`/`multi_select` | Exposed widget (default `select`). |
| `bypass_hook_views_pre_view` | bool (default FALSE) | If TRUE, apply via `hook_preprocess_views_view()` (calls the plugin's `preprocess()`) instead of `hook_views_pre_view()`. Leave FALSE unless an earlier-reading module (e.g. Charts) needs the fields resolved before render. |

## How the toggle is applied

`views_fields_on_off_get_selected()` reads the visitor selection from `request->request` (POST, for
AJAX) then `request->query` (GET). In `hook_views_pre_view()`:
- **Field path** (`_views_fields_on_off_process_field`): if the hidden-submitted marker is present,
  every configured field not in the selection gets `exclude = 1`; otherwise (fresh load) the
  `default_enabled` flag decides. The On/Off field itself is always excluded from output.
- **Filter path** (`_views_fields_on_off_process_filter`): for exposed, non-default selections, each
  field in `value` gets `exclude` set based on membership and the `in`/`not in` operator.

Both handlers' `query()` are intentionally empty — the module only sets `exclude` on fields already
added to the display, so it can hide configured columns but never surfaces un-added data.

## Notes

- With `bypass_hook_views_pre_view = TRUE`, `views_fields_on_off_preprocess_views_view()` calls the
  filter plugin's `preprocess()`, which `unset()`s the non-selected fields from `$view->field`.
- Pairs well with Views Data Export (export only selected columns) and Charts (choose series).
