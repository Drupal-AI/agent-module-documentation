<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Reference Selection (dynamic_reference_selection) — agent index

Makes one entity-reference field **dependent on another field's value**. You add a
`dynamic_reference_selection_views` **selection handler** to the child reference field and point it at
a Views **Entity Reference** display plus a **parent field**. The parent field's current value is
passed as the view's first contextual-filter **argument**, so the child's referenceable entities are
whatever the view returns for that argument (e.g. Country → City, Genre → Song). At edit time a
`hook_field_widget_single_element_form_alter` wires a Form-API `#ajax` callback onto the parent
widget; when the parent changes, the callback re-runs the view and pushes new `<option>`s into the
child widget over AJAX (custom command `updateOptionsCommand`). Works with **Select list** and
**Check boxes/radio buttons** widgets (and, with `autocompleteclose`, the autocomplete widget);
supports multi-value fields, Paragraphs subforms, and referencing the parent **by UUID** instead of
entity ID.

The module also ships a small **`DynamicReferenceSelectionReactsOn`** plugin type + event used
internally to let other code alter the reference element during the widget form-alter.

- Depends on: nothing declared in `info.yml`. **Requires core Views at runtime** (`Drupal\views\Views`)
  — enable `views` (undeclared implicit dependency).
- Core: `^10 || ^11`. Package: none declared. No `composer.json`.
- No settings page / `configure` route, **no routes at all**, no permissions, no drush, no config
  schema files. All configuration is per-field (the reference field's handler settings).
- Defines one plugin type: **`DynamicReferenceSelectionReactsOn`**
  (manager `plugin.manager.dynamic_reference_selection.reacts_on`). Provides one core-plugin instance:
  the `dynamic_reference_selection_views` **EntityReferenceSelection** handler.

## What you'd do → where

- **Set up a dependent (parent→child) reference field / the handler settings keys** →
  [configure/dependent-fields.md](configure/dependent-fields.md)
- **Understand the selection handler internals, the AJAX callback, UUID/Paragraphs/multi-value
  handling, the SelectionInterface methods** → [plugins/selection.md](plugins/selection.md)
- **Add a "reacts on" plugin / subscribe to the form-field-alter event to change the element** →
  [plugins/reacts-on.md](plugins/reacts-on.md)
- **Call the util service, read the hook, the AJAX command, the JS library** →
  [api/internals.md](api/internals.md)

## Key facts (real machine names)

- Selection handler (field `handler` value): **`dynamic_reference_selection_views`** — attribute
  `#[EntityReferenceSelection(id: "dynamic_reference_selection_views", group:
  "dynamic_reference_selection_views", weight: 0)]`, class
  `Plugin\EntityReferenceSelection\DynamicReferenceSelectionViewsSelection` (implements
  `SelectionInterface`, `ContainerFactoryPluginInterface`).
- Handler settings live under `handler_settings['dynamic_reference_selection_view']` with keys:
  `view_name`, `display_name`, `arguments` (array), `parent_field`, `reference_parent_by_uuid` (bool).
  Form-time key: `view_and_display` (`view:display`, split at validate).
- AJAX callback (bound as `#ajax['callback']`):
  `DynamicReferenceSelectionViewsSelection::updateDependentField` (event `change`, or
  `autocompleteclose` for the autocomplete widget). AJAX command id `updateOptionsCommand`
  (`Ajax\UpdateOptionsCommand`, JS `js/update-options-command.js`).
- Hook: `dynamic_reference_selection_field_widget_single_element_form_alter()` (`.module`).
- Library: `dynamic_reference_selection/dependentField` (attaches `core/drupal.ajax`).
- Services: `dynamic_reference_selection.util` (`Util\DynamicReferenceSelectionUtil`, public `$request`,
  method `getBundleEditableFields()`), `plugin.manager.dynamic_reference_selection.reacts_on`
  (`Plugin\DynamicReferenceSelectionReactsOnManager`, parent `default_plugin_manager`).
- Plugin type `DynamicReferenceSelectionReactsOn`: dir `Plugin/DynamicReferenceSelectionReactsOn`,
  annotation `Annotation\DynamicReferenceSelectionReactsOn`, interface
  `DynamicReferenceSelectionReactsOnInterface`, base `DynamicReferenceSelectionReactsOnPlugin`, alter
  hook `dynamic_reference_selection_reacts_on_info`, cache key
  `dynamic_reference_selection_reacts_on_plugins`.
- Bundled reacts-on plugin: **`form_field_alter`** (`FormFieldAlter`), `eventName`
  `dynamic_reference_selection.form_field_alter`, `priority` 1000, `hasTargetEntity`/`hasTargetBundle`
  TRUE. Event class `Events\DynamicReferenceSelectionEvent` (extends Symfony `GenericEvent`).
