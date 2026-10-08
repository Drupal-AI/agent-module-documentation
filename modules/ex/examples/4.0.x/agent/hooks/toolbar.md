# hook_toolbar() — the "Examples" tray

`examples_toolbar()` in `examples.module` is the only behavior the parent module contributes. It
adds a top-level **Examples** toolbar item (`#type: toolbar_item`, `#weight: 99`) whose tray lists a
link for each *installed* example submodule plus an "Enable Examples" shortcut.

How it builds the list:
1. `_examples_toolbar_routes()` returns a hard-coded `[module => route_name]` map (28 entries).
2. For each entry it checks `\Drupal::moduleHandler()->moduleExists($module)`; skips modules that
   are not installed.
3. It pulls the module label/description from `extension.list.module`
   (`getExtensionInfo($module)`), `Html::escape()`s both, and builds a link to `Url::fromRoute($route)`
   with a per-module CSS class (`Html::getClass($module)`).
4. Appends an **Enable Examples** link to `system.modules_list` (the Extend page) with fragment
   `edit-modules-example-modules`.
5. Attaches library `examples/examples.icons` for the tray-link icons.

The tray render array uses `#theme => 'links__toolbar_example'`. Requires core `toolbar` to be
enabled (declared as the module's only dependency).

## Submodule → tray route map (`_examples_toolbar_routes()`)

| Submodule | Route linked in the tray |
| --- | --- |
| `ajax_example` | `ajax_example.description` |
| `batch_example` | `batch_example.form` |
| `block_example` | `block_example.description` |
| `cache_example` | `cache_example.description` |
| `config_entity_example` | `entity.robot.list` |
| `config_simple_example` | `config_simple_example.description` |
| `content_entity_example` | `entity.content_entity_example_contact.collection` |
| `cron_example` | `cron_example.description` |
| `dbtng_example` | `dbtng_example.generate_entry_list` |
| `email_example` | `email_example.description` |
| `events_example` | `events_example.description` |
| `field_example` | `field_example.description` |
| `field_permission_example` | `field_permission_example.description` |
| `form_api_example` | `form_api_example.description` |
| `hooks_example` | `hooks_example.description` |
| `js_example` | `js_example.info` |
| `menu_example` | `examples.menu_example` |
| `node_type_example` | `config_node_type_example.description` |
| `page_example` | `page_example.description` |
| `pager_example` | `pager_example.page` |
| `plugin_type_example` | `plugin_type_example.description` |
| `queue_example` | `queue_example.form` |
| `render_example` | `render_example.description` |
| `session_example` | `session_example.form` |
| `stream_wrapper_example` | `stream_wrapper_example.description` |
| `tabledrag_example` | `tabledrag_example.description` |
| `tablesort_example` | `tablesort_example.description` |
| `testing_example` | `testing_example.description` |

Not in the map (installed but no tray link): `action_example`, `image_example`, `theming_example`.
`action_example` has no page of its own; `image_example` and `theming_example` expose their own
routes (e.g. `image_example.styles`, `theming_example.entry`) — visit those directly.
