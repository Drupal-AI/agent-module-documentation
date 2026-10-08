# Examples for Developers — agent index

A container/teaching project: the top-level `examples` module does almost nothing itself. It
bundles 31 self-contained tutorial submodules, each demonstrating **one** Drupal core API with
richly-commented, working, tested code. Enable the one you want to study, read its `src/`, then
uninstall. Do NOT leave enabled on a production site.

The parent module only: implements `hook_toolbar()` (`examples_toolbar()`) to add an "Examples"
tray that links to whichever example submodules are installed, ships one CSS library
(`examples/examples.icons`) for the tray icons, and provides a reusable
`DescriptionTemplateTrait` the examples use to render their intro pages.

Dependency: core `toolbar`. Composer also requires `drupal/hal:^2.0` and PHP `^8.1`; suggests
`drupal/devel`. No settings page (`configure` null). The parent defines **no** permissions, Drush
commands, plugin types, routes, or config schema of its own — those all live in the submodules.

- **How the "Examples" toolbar tray is built + the submodule→route map** → [hooks/toolbar.md](hooks/toolbar.md)
- **The reusable `DescriptionTemplateTrait` (how each example renders its intro page)** → [api/description_template_trait.md](api/description_template_trait.md)

## Bundled example submodules (`modules/<name>/`)

Enable each independently (Extend page or `drush en <name>`); most add a menu/route you can visit,
then you read the code. Every submodule except `theming_example` depends on `examples:examples`
(plus its own core module deps).

| Submodule | Demonstrates |
| --- | --- |
| `action_example` | Providing actions bound to triggers (Action plugins) |
| `ajax_example` | AJAX-enabled forms and callbacks |
| `batch_example` | Defining Batch API operations |
| `block_example` | Defining custom block plugins |
| `cache_example` | Using the Cache API |
| `config_entity_example` | Creating a configuration entity type (the "robot" entity) |
| `config_simple_example` | A custom translatable simple-config form |
| `content_entity_example` | Creating a content entity type (the "contact" entity) |
| `cron_example` | `hook_cron()` and related scheduling patterns |
| `dbtng_example` | The database API (dynamic queries / DBTNG) |
| `email_example` | Sending and altering Drupal mail (`hook_mail`) |
| `events_example` | Subscribing to and dispatching events |
| `field_example` | Field API: custom field type/widget/formatter plugins |
| `field_permission_example` | A field with field-level access control |
| `form_api_example` | The Form API (several form patterns) |
| `hooks_example` | Implementing, defining, and invoking hooks |
| `image_example` | image.module APIs (image styles/effects) |
| `js_example` | Attaching and using JavaScript |
| `menu_example` | Defining menu links and routed menu callbacks |
| `node_type_example` | Providing a node content type from a module |
| `page_example` | Displaying a page at a given route/URL |
| `pager_example` | Paginated render-array tables with a pager |
| `plugin_type_example` | Defining a custom plugin type + manager |
| `queue_example` | Using the Queue API |
| `render_example` | The Render API (render arrays) |
| `session_example` | Using the session / private tempstore |
| `stream_wrapper_example` | Implementing a stream wrapper |
| `tabledrag_example` | Building draggable (tabledrag) forms |
| `tablesort_example` | Sortable table output (tablesort) |
| `testing_example` | Core testing frameworks (Unit/Kernel/Functional) |
| `theming_example` | Theming: hooks, templates, preprocess, render |

## Key facts
- Parent code is only `examples_toolbar()` + the `_examples_toolbar_routes()` helper in `examples.module`.
- Reusable trait: `Drupal\examples\Utility\DescriptionTemplateTrait` (`src/Utility/DescriptionTemplateTrait.php`).
- Library: `examples/examples.icons` → `css/examples.icons.css` (styles the toolbar tray links).
- Info dependency: `drupal:toolbar`. `core_version_requirement: ^10.6 || ^11.0`.
- 28 of the 31 submodules appear in the toolbar tray; `action_example`, `image_example`, and
  `theming_example` are not wired into the tray (visit their own routes instead).
- Each submodule lives at `web/modules/contrib/examples/modules/<name>/` with its own `.info.yml`,
  routing, `src/`, templates, and tests — read that source when you need the actual API detail.
