# Configure scripts

No dedicated settings form / `configure` route. You manage individual snippets from the **script**
config-entity collection.

## Admin UI

- List: `/admin/structure/scripts` (route `entity.script.collection`, menu *Structure › JavaScript Snippets*).
- Add: `/admin/structure/scripts/add`, Edit: `/admin/structure/scripts/manage/{script}`, Delete: `.../delete`.
- Collection + settings form require permission **`administer scripts`** (`restrict access: true`); add/edit/delete
  go through the entity access handler (create/update/delete also effectively need that admin permission).

## The `script` config entity

Config name `script_manager.script.<id>`. Exported keys (`config_export`): `id`, `label`, `snippet`,
`position`, `visibility`.

| Field | Form element | Meaning |
|---|---|---|
| `label` | textfield (required, ≤64) | Human name, e.g. "Google Analytics". |
| `id` | machine_name (≤64) | Entity id; immutable after creation. |
| `position` | select (required) | `top` → rendered in `hook_page_top`; `bottom` → `hook_page_bottom`; `hidden` → never rendered. |
| `snippet` | textarea (required) | The HTML/JavaScript emitted **verbatim/unescaped** on the page (see api/placement.md). |
| `visibility` | vertical tabs | Core condition plugins (request path, role, language, …), same UX as block visibility. |

Visibility: conditions are stored as a `ConditionPluginCollection`. At render time the
`ScriptAccessControlHandler` resolves them with **AND** logic for the `view` operation; if a required
plugin context is missing, access is forbidden and uncacheable (mirrors core block behaviour). An empty
visibility set = always visible (on non-admin routes).

## Module settings

Config `script_manager.settings` has one key, `enabled_visibility_plugins` (sequence of condition plugin
ids). Default `{}` means **all** condition plugins filtered for the `script_manager` context are offered
on the form; set an explicit list to restrict the choices. There is no admin form shipped for this — edit
it via config.

## Create a script via config (Drush)

```php
// drush php:eval — a GA snippet at the bottom of every non-admin page, all pages.
\Drupal::entityTypeManager()->getStorage('script')->create([
  'id' => 'ga',
  'label' => 'Google Analytics',
  'position' => 'bottom',
  'snippet' => "<script>console.log('hi');</script>",
  'visibility' => [],
])->save();
```

To scope it, populate `visibility` with a condition plugin's config, e.g.
`'visibility' => ['request_path' => ['id' => 'request_path', 'pages' => '/blog/*', 'negate' => false]]`.

Import as YAML instead by placing `script_manager.script.ga.yml` (with `id/label/snippet/position/visibility`
+ `langcode/status/dependencies`) in your config sync directory and running `drush cim`.
