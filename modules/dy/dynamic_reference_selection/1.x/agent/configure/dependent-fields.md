# Configure a dependent (parent → child) reference field

Goal: the options of a **child** entity-reference field depend on the current value of a **parent**
field on the same entity form (e.g. pick a Country, then only its Cities appear).

## Prerequisites

1. Enable `dynamic_reference_selection` and core **`views`** (Views is required at runtime but is
   *not* declared in `info.yml`).
2. A **parent** field already on the bundle (any field whose value can drive the filter — commonly
   another entity-reference field, but a list/text field works too).
3. A **View** on the *child* entity type with an **Entity Reference** display, whose **first
   contextual filter** accepts the parent value (an entity ID, or a UUID — see below). This view is
   the data source; the module does **not** build its own entity query.

## Steps

1. Add/locate the **child** reference field. Go to its field settings
   (`admin/structure/…/fields/…`), **Reference type / Reference method** =
   **"Dynamic Reference Selection: Make field dependent using views"** (handler machine name
   `dynamic_reference_selection_views`).
2. Fill the handler form (`buildConfigurationForm`, `DynamicReferenceSelectionViewsSelection.php:288`):
   - **View used to select the entities** (`view_and_display`) — required `select`; only views whose
     `base_table`/`data_table` matches the field's `target_type` and that expose an
     `entity_reference_display` are listed.
   - **Parent field** (`parent_field`) — required `select`; the field this one depends on. Options
     come from `dynamic_reference_selection.util:getBundleEditableFields()`, excluding `title` and the
     child field itself.
   - **Reference parent by UUID instead of entity ID?** (`reference_parent_by_uuid`) — check when the
     view's contextual filter expects a UUID (for config portability).
   - **View arguments** (`arguments`) — optional comma-separated list appended *after* the parent
     value as further contextual-filter arguments.
3. In **Manage form display** set BOTH the parent and child widgets to **Select list** or
   **Check boxes/radio buttons**. The handler prints a notice that it "do not works for autocomplete
   form widget" — autocomplete is only partially handled (`autocompleteclose` event; the child options
   are still refreshed but the parent must resolve to an entity id).

## Stored configuration (field config `handler_settings`)

Validated/massaged in `settingsFormValidate()` (`.php:94`) into:

```yaml
handler: dynamic_reference_selection_views
handler_settings:
  dynamic_reference_selection_view:
    view_name: my_child_view          # from view_and_display, before the ':'
    display_name: entity_reference_1  # after the ':'
    arguments: []                     # trimmed array from the comma list
    parent_field: field_country
    reference_parent_by_uuid: false
```

## What happens at runtime

- **Initial form load / server-side option list:** `getReferenceableEntities()` reads the parent
  value (from the current request or the entity), passes it as the view's first argument, executes the
  Entity Reference display, and returns `[bundle][entity_id] => label]`.
- **When the parent changes:** the module's `hook_field_widget_single_element_form_alter` has attached
  `#ajax` (callback `DynamicReferenceSelectionViewsSelection::updateDependentField`, event `change` /
  `autocompleteclose`) to the parent widget and the `dynamic_reference_selection/dependentField`
  library. The callback re-runs the child view with the new parent value and returns an
  `updateOptionsCommand` AJAX command that rebuilds the child `<select>`/checkboxes/radios in the
  browser, preserving any still-valid current selection.
- **Multi-value child fields** (cardinality −1) are forced to stay `#multiple` even when they start
  with no options (`.module:87`).
- **Paragraphs:** `updateDependentField` walks nested `subform` parents to find the most-deeply-nested
  paragraph and resolves the child there.

## Notes / gotchas

- No dedicated config page — everything is on the reference field's handler settings.
- Access to the referenceable entities is whatever the chosen **View** enforces (its access plugin +
  filters); the handler delegates listing to Views (like core's Views selection handler).
- If the view can't be found/accessed, `getReferenceableEntities()` returns nothing (and the widget
  shows no options).
