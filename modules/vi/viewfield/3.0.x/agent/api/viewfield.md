# Field type / widget / formatter internals

Viewfield defines Field API plugins only (no services, no plugin manager, no hooks).
Extend by subclassing these plugins.

## Field type — `viewfield` (`ViewfieldItem`)

`Drupal\viewfield\Plugin\Field\FieldType\ViewfieldItem extends EntityReferenceItem`.

- `default_widget = viewfield_select`, `default_formatter = viewfield_default`,
  `list_class = EntityReferenceFieldItemList`.
- Storage `target_type` forced to `view` (`defaultStorageSettings`); the target-type select is
  hidden in `storageSettingsForm`.
- Columns beyond the inherited `target_id`: `display_id` (varchar_ascii 255), `arguments`
  (varchar 255), `items_to_display` (varchar 255). Matching typed-data properties are
  `display_id`, `arguments`, `items_to_display` (plus inherited `entity`).
- Field settings default: `force_default => 0`, `allowed_views => []`,
  `allowed_display_types => ['block' => 'block']`.
- Helper methods usable when subclassing the widget: `getViewOptions($filter = TRUE)`,
  `getDisplayOptions($entity_id, $filter = TRUE)`, `getDisplayTypeOptions()` (all backed by
  `Drupal\views\Views::getEnabledViews()` / `Views::pluginList()`).
- `getPreconfiguredOptions()` returns `[]` (no preconfigured field options).
- `fieldSettingsFormValidate()` enforces a default value when `force_default` is checked.

## Widget — `viewfield_select` (`ViewfieldWidgetSelect`)

`extends OptionsSelectWidget`, `field_types = {viewfield}`. Builds the view select
(`target_id`) with an Ajax `change` callback `ajaxGetDisplayOptions()` that rebuilds the
`display_id` options; the display/arguments/items fields are `#states`-gated to be visible only
when a view is chosen. Argument tokens use `token_tree_link` scoped to the host entity type.
Attaches library `viewfield/viewfield`.

## Formatters

- `viewfield_default` (`ViewfieldFormatterDefault extends FormatterBase`) — runs the view:
  `Views::getView($target_id)`, `access($display_id)`, `setArguments()`, `setDisplay()`,
  optional `setItemsPerPage()` + pager disable (`views\...\pager\None`), `preExecute()`,
  `execute()`, `buildRenderable()`. Renders through the `viewfield` / `viewfield_item` theme
  hooks. `processArguments()` parses the argument string (quote-aware, `/`-split) and runs
  `\Drupal::token()->replace()` against the host entity. Settings: `view_title`,
  `always_build_output`, `empty_view_title`.
- `viewfield_rendered` (`ViewfieldFormatterRenderedEntities extends ViewfieldFormatterDefault`)
  — reuses the same execution but renders each result row's `_entity` via the entity view
  builder in `view_mode`; single cardinality only; injects `entity_type.manager` and
  `entity_display.repository`.
- `viewfield_title` (`ViewfieldFormatterTitle extends FormatterBase`) — no execution; prints
  view title, display name, and arguments (debug).

## Other pieces (not extension APIs)

- `src/Normalizer/ViewfieldNormalizer.php` — REST/serialization normalizer for the field item.
- `src/Plugin/migrate/field/d7/ViewField.php` — Drupal 7 → 10/11 migrate field plugin.
- `src/ViewfieldServiceProvider.php` — registers the normalizer.
- Theme hooks `viewfield` and `viewfield_item` (templates in `templates/`), overridable in a theme.
