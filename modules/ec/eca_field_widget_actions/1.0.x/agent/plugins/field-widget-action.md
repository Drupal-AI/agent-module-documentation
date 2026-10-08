<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA FieldWidgetAction plugin (the button)

`src/Plugin/FieldWidgetAction/EcaFieldWidget.php` — `EcaFieldWidget extends FieldWidgetActionBase`
(from field_widget_actions). Attribute `#[FieldWidgetAction(id: 'eca_field_widget', label: 'ECA Field Widget',
widget_types: [], field_types: [], category: 'ECA Field Widgets', deriver: EcaFieldWidgetDeriver)]`.
This is the button field_widget_actions offers on "Manage form display"; one derivative is produced
per enabled ECA model that uses the `eca_field_widget_actions:eca_field_widget` event.

## Deriver — `EcaFieldWidgetDeriver.php` (`ContainerDeriverInterface`)
`getDerivativeDefinitions()`:
- Reads `state.get('eca.subscribed')[FIELD_WIDGET_ACTION]`; nothing subscribed → no derivatives.
- For each subscribed ECA model (loaded via `entity_type.manager` storage `eca`; skipped if missing
  or `!status()`), for each used event whose plugin id is `eca_field_widget_actions:eca_field_widget`:
  - derivative id = the wildcard (`{eca_id}.{event_id}`, model-ID-prefixed — issue #3588904).
  - reads the event's `fill_strategies`:
    - `compound` → `widget_types: []`, `field_types: compoundFieldTypes()`.
    - `''` (no restriction) → `widget_types: []` (matches everything).
    - a DOM strategy → `widget_types: FieldWidgetSupport::widgetTypesForStrategy($strategy)` (falls
      back to `[$strategy]` if empty).
- `compoundFieldTypes()` probes every installed field type via
  `FieldWidgetSupport::isCompoundFieldType()`, sorts, memoizes per build, and — fail-closed — returns
  `[FILL_COMPOUND]` (a sentinel that matches nothing) rather than `[]` when none are found.

## Cache invalidation — `src/Hook/EcaEntityHooks.php`
Attribute hooks `#[Hook('entity_insert')]` / `#[Hook('entity_update')]` (insert delegates to
update). When a saved `Eca` entity uses the `eca_field_widget_actions:eca_field_widget` event, it
calls `plugin.manager.field_widget_actions` → `clearCachedDefinitions()` so the derived buttons
refresh. Service injected with `#[Autowire(service: 'plugin.manager.field_widget_actions')]`.

## Button config — `direct_fill` ("Fill the field directly")
`defaultConfiguration()` = `['direct_fill' => FALSE]`. `buildConfigurationForm()` adds a checkbox;
`submitConfigurationForm()` casts to bool. Schema:
`field_widget_action.plugin.eca_field_widget:*.*` → `direct_fill: boolean` (scoped to this plugin so
it does not leak onto unrelated field widget actions — see schema comments / `generateWildcard`).
When off, the model's value is shown in the field_widget_actions suggestions dialog; when on, it is
written straight into the widget.

## Runtime — `getAjaxCallback()` = `executeWidget`, library `field_widget_actions/commands`
`dispatchWidgetEvent($entity, $field_name, $field_key)` fires the ECA event once via
`eca.trigger_event`→`dispatchFromPlugin('eca_field_widget_actions:eca_field_widget', $derivativeId, …)`
(NULL delta becomes `''`) and returns `FieldWidgetEvent::getWidgetValue()`. `executeWidget()`:
- If the pressed element carries `#eca_compound_fill` → the event already ran in the submit phase, so
  it only returns the rebuilt widget via `buildCompoundFillResponse()` (avoids double model runs).
- Else builds the entity (`buildEntity()`), dispatches the event, and if `direct_fill` is on calls
  `buildDirectFillResponse()`; if that returns NULL it falls back to `returnSuggestions()`.

### Direct fill DOM strategies — `buildDirectFillResponse()`
Empty/`[]`/`''` value → NULL (show suggestions). Otherwise switches on
`FieldWidgetSupport::fillStrategy($widget_type)` (widget type resolved by `resolveWidgetType()` from
the form display renderer):
- `FILL_SELECT` → `FillSelectCommand` against a 4-spelling `select[name=…]` selector list, value list
  from `toValueList()`.
- `FILL_BUTTONS` → `FillCheckboxesOrRadiosCommand` (only if `class_exists`, issue #3578204) with base
  name `{field}[widget]`.
- default (editor/uncataloged) → `FillEditorCommand` on `[data-drupal-selector=…]` with the scalar
  string; non-scalar or no selector → NULL (suggestions).
`toValueList()` splits a non-array on commas, trims, drops blanks/non-scalars, de-duplicates.

### Compound fill (server-side rebuild)
For compound field + non-cataloged widget + `direct_fill`, `usesCompoundFill()` is true and
`actionButton()` attaches `compoundFillSubmit` (`#executes_submit_callback = TRUE`,
`#eca_compound_fill = TRUE`). `compoundFillSubmit()` builds the entity, dispatches the event, and
`applyCompoundValue()` writes onto `$entity`:
- delta NULL (whole field): `$entity->set($field_name, $value)`.
- per-item, mapping/scalar: `$items->set((int)$delta, $value)`.
- per-item, list: sets a run of items starting at `$delta`.
A write that throws is logged (channel `eca_field_widget_actions`) and surfaced as a messenger error.
Then the form is pointed at the entity, the field is dropped from user input (so the rebuild reads
`#default_value` from the entity), `updateItemsCount()` bumps unlimited-cardinality
`items_count` if needed, and `setRebuild()` is called. `buildCompoundFillResponse()` returns a
`ReplaceCommand` for the field/group wrapper plus `MessageCommand`s (messages are carried manually
because replacing the region discards the messages area); if the model produced nothing or the write
failed it returns the suggestions dialog instead.

## Widget/field-type catalog — `src/FieldWidgetSupport.php` (`@internal`, final)
Single source of truth for the fill strategies. `FILL_EDITOR|SELECT|BUTTONS|COMPOUND`.
`WIDGET_TYPES` maps cataloged widget IDs to strategies: string/text text(area/field) +
`text_textarea_with_summary` → editor; `options_select`, `chosen_select`, `cshs`,
`tagify_select_widget` → select; `options_buttons` → buttons. Methods: `fillStrategies()` (labels),
`widgetTypes()`, `fillStrategy(?$widget_type)` (NULL when uncataloged — never returns `compound`),
`widgetTypesForStrategy($strategy)`, `isCompound(FieldStorageDefinition)` (compound = stored,
non-computed property count ≠ 1; 0 counts as compound), `isCompoundFieldType($field_type)` (probes a
bare `BaseFieldDefinition`; `custom` is force-listed in `ALWAYS_COMPOUND_FIELD_TYPES`; a throwing
probe is treated as compound).
