<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ds_chains` DS field plugin and its deriver

Two classes make up the display-time engine: the deriver enumerates every
chainable field into a distinct DS field, and the field plugin renders it.

## Deriver — `src/Derivative/ChainsDeriver.php`

`ChainsDeriver` (implements `ContainerDeriverInterface`) is named as the deriver
of the DS field in the plugin annotation, so DS's plugin manager asks it for one
derivative per chainable combination.

`getDerivativeDefinitions()` walks
`entityFieldManager->getFieldMapByFieldType('entity_reference')` and, for each
`entity_type_id → field_name`:

- skips computed/calculated fields (no storage definition);
- resolves the reference's `target_type` and keeps it only when the target is a
  **content entity with a view builder**
  (`entityClassImplements(ContentEntityInterface::class)` and
  `hasViewBuilderClass()`);
- for each host bundle carrying the field, reads the reference handler's
  `handler_settings['target_bundles']` (falling back to *all* bundles of the
  target type when unset);
- for each target bundle, iterates that bundle's field definitions and keeps
  those that are `isDisplayConfigurable('view')`.

Each surviving combination becomes a derivative keyed
`"{entity_type}/{bundle}/{field_name}/{chained_field_name}"` carrying:
`field_name`, `field_cardinality`, `chained_field_name`, `chained_field_title`,
`chained_field_type`, a human `title` of `"{ref label}: {chained label}"`,
`bundle`, `target_bundle`, `target_entity_type`, `entity_type`, and `view_modes`.

`getEnabledViewModes()` restricts `view_modes` to the view modes where the *host*
reference field was actually ticked: it loads the
`{entity_type}.{bundle}.{view_mode}` `entity_view_display` entities (default +
all defined view modes) and keeps only enabled displays whose
`ds_chains.fields` third-party setting contains `field_name`. A stray field name
in the map with no matching instance is logged to the `ds_chains` channel and
skipped.

Because derivatives are cache-driven, `ChainsUi::buildEntity()` calls
`plugin.manager.ds`'s `clearCachedDefinitions()` whenever the selection is saved.

## Field plugin — `src/Plugin/DsField/ChainedField.php`

`ChainedField` extends `\Drupal\ds\Plugin\DsField\DsFieldBase`; annotation
`@DsField(id = "ds_chains", deriver = "\Drupal\ds_chains\Derivative\ChainsDeriver")`.
`create()` injects the formatter plugin manager (`plugin.manager.field.formatter`),
the field manager, and the **target** entity type's view builder
(`entity_type.manager->getViewBuilder($plugin_definition['target_entity_type'])`).

Key methods:

- **`build()`** — the render. Reads the host entity's reference field
  (`field_name`); returns `[]` early if empty. It iterates each delta; for each
  it resolves `$field_item->get('entity')->getValue()` (the referenced entity)
  and renders the chosen `chained_field_name` through the target view builder's
  `viewField($items, ['label' => 'hidden', 'type' => $formatter, 'settings' => …])`.
  A delta is skipped when the referenced entity is missing, lacks the chained
  field, the chained field is empty, or the chained field's `access('view')`
  denies it. Each referenced entity is added to a `CacheableMetadata`
  dependency (rendered or skipped); if nothing rendered it returns the cache
  object, otherwise it `applyTo()`s the build. An optional
  `chain_settings.ui_limit` caps how many deltas are rendered.
- **`formatters()`** — offers only formatter plugins whose `isApplicable()`
  returns TRUE for the chained field definition
  (`formatterPluginManager->getOptions($chained_field_type)` filtered by
  `DefaultFactory::getPluginClass(...)::isApplicable(...)`).
- **`settingsForm()` / `settingsSummary()`** — embed the selected formatter's own
  settings form/summary via `getFormatterInstance()`. For an
  **unlimited-cardinality** reference field it adds the `chain_settings.ui_limit`
  number element (see [config/manage-display.md](../config/manage-display.md) for
  the schema).
- **`isAllowed()` / `validViewMode()`** — gate the field to the derivative's
  `bundle` (against the rendered entity's bundle, or the manage-display bundle)
  and to a view mode present in the derivative's `view_modes`.
- **`getTitle()`** — returns the stored `chained_field_title`.

## Notes

- Rendering is entirely delegated to core's formatter + view-builder pipeline
  with `label => hidden`; the chained field's own type constrains formatter
  choice.
- Each rendered delta is an extra entity load — the `ui_limit` on multi-value
  references exists to bound that cost.
