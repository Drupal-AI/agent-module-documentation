# Internals — services, hook, AJAX command, library

## Services (`dynamic_reference_selection.services.yml`)

- **`dynamic_reference_selection.util`** → `Util\DynamicReferenceSelectionUtil`.
  Args: `config.factory`, `entity_field.manager`, `plugin.manager.field.field_type`, `request_stack`.
  - Public property `$request` = the current request (set in the constructor from the request stack);
    the selection handler reads request parameters through it (`$this->util->request->get(...)`).
  - `getBundleEditableFields($entityType, $bundle, array $field_types_ids = [])` — returns
    `['field_name' => "Type label: Field label [field_name]"]` for configurable fields
    (`FieldConfig`) plus base `title`. Used to populate the **Parent field** select in the handler
    form. Optional `$field_types_ids` filters by field type.
- **`plugin.manager.dynamic_reference_selection.reacts_on`** →
  `Plugin\DynamicReferenceSelectionReactsOnManager` (`parent: default_plugin_manager`). See
  [../plugins/reacts-on.md](../plugins/reacts-on.md).

## Hook (`dynamic_reference_selection.module`)

`dynamic_reference_selection_field_widget_single_element_form_alter(&$element, FormStateInterface
$form_state, $context)` — the only hook. It:

1. Resolves the entity being edited (from `$context['items']` if it's an
   `EntityReferenceFieldItemListInterface`, else from the form object).
2. Scans the entity's field definitions for any field using handler
   `dynamic_reference_selection_views` whose `parent_field` equals the current field → collects those
   as **child** fields.
3. If the current field has children, attaches `#ajax` (callback
   `DynamicReferenceSelectionViewsSelection::updateDependentField`, `event` `change` — or
   `autocompleteclose` when the widget is an `EntityReferenceAutocompleteWidget` with a `target_id`),
   carrying `br_children` (the child field names), and attaches library
   `dynamic_reference_selection/dependentField`.
4. Forces `#multiple = TRUE` for cardinality −1 child `select`/`select2` widgets so multi-value stays
   multi-value even with no initial options.
5. Dispatches the `dynamic_reference_selection.form_field_alter` event (see
   [../plugins/reacts-on.md](../plugins/reacts-on.md)) and writes the possibly-altered element back.

## AJAX command (`src/Ajax/UpdateOptionsCommand.php` + `js/update-options-command.js`)

- PHP `UpdateOptionsCommand($elementId, array $options, $formatter, bool $multiple)` →
  `render()` returns `['command' => 'updateOptionsCommand', 'method' => 'html', 'elementId', 'options',
  'formatter', 'multiple']`.
- JS `Drupal.AjaxCommands.prototype.updateOptionsCommand` rebuilds the target widget in place:
  - **`SELECT`**: clears `element.options`, re-adds `new Option(value, key)`, re-applies previously
    selected values, sets `multiple` when `response.multiple`, dispatches a `change` event.
  - **`FIELDSET.form-checkboxes` / `.form-radios`**: rebuilds the checkbox/radio inputs and labels
    (skipping the `_none` option), re-checking previously selected values, dispatches `change`.
  - Option labels are inserted with `document.createTextNode(...)` / `new Option(...)` — text only,
    not HTML.

## Library (`dynamic_reference_selection.libraries.yml`)

`dependentField`: `js/update-options-command.js`, dependency `core/drupal.ajax`.

## Absent surface (don't look for it)

No `*.routing.yml` (no custom routes/controllers), no `*.permissions.yml`, no `*.links.*.yml`, no
`config/` (no install config or schema), no drush commands, no `composer.json`, no settings form. The
AJAX behaviour rides entirely on core's Form-API `#ajax` (the `/system/ajax` route) inside the entity
edit form.
