<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Repeat widget

`src/Plugin/Field/FieldWidget/EntityRepeatWidget.php` — `@FieldWidget(id = "entity_repeat",
label = "Entity Repeat widget", field_types = { "date_recur" })`. Extends
`Drupal\date_recur_modular\Plugin\Field\FieldWidget\DateRecurModularAlphaWidget`. It is the alpha
recurrence widget with an added "generate clones" toggle.

## Enable it

No install-time config. Add a **Date Recur** (`date_recur`) field to a bundle, then on the bundle's
**Manage form display** set that field's widget to *Entity Repeat widget*. There is no formatter and
no field type in this module — it only replaces the form widget.

## formElement()

Calls `parent::formElement()`, then only if `entityRepeatAccess($entity)` passes:
- `unset($element['ends_mode']['#options']['infinite'])` — removes the infinite-recurrence option
  ("not viable" for generation), so a bounded occurrence set is enforced.
- unsets `ends_mode` `#default_value` and reorders options so `date` is first.
- adds `$element['entity_repeat_enabled']` — a `checkbox`, title *"Replicate this entity for each of
  the generated dates"*.
- sets `$element['#theme'] = 'entity_repeat_widget'`.

If access fails, the element is returned unchanged (no checkbox added), so an unprivileged user gets
the plain Date Recur widget with no way to trigger generation.

## entityRepeatAccess(EntityInterface $entity)

Returns TRUE when the current user has `repeat any {bundle} {entity_type_id}`, OR is the entity owner
(`$account->id() == $entity->getOwner()->id()`) and has `repeat own {bundle} {entity_type_id}`. These
permission names are produced by `EntityRepeatPermissions` (see
[../permissions/permissions.md](../permissions/permissions.md)).

## validateModularWidget()

Static; calls `parent::validateModularWidget()` first, then:
- reads `$form_state->getValue($fieldname)[0]['entity_repeat_enabled']`; if falsy, returns (nothing
  generated). Because the checkbox is only added to the form when access passes, an unprivileged
  submission has no such value and short-circuits here.
- when enabled, sets `$entity->data['entity_repeat_enabled'] = 1` on the form's entity — the flag the
  save-time subscriber later checks (see [../api/generation.md](../api/generation.md)).
- validates the recurrence inputs: `start` and `end` must be `DrupalDateTime`; when `mode` is not
  `once`/`multiday`, an `ends_mode` is required, and `ends_date` (a `DrupalDateTime`) is required for
  ends_mode `date` while `ends_count` is required for ends_mode `count`. Errors set via
  `$form_state->setError()`.

## Theme / template

`entity_repeat_theme()` (`entity_repeat.module`) declares theme `entity_repeat_widget`
(`render element => widget`). `template_preprocess_entity_repeat_widget()` adds the CSS class
`date-recur-modular-alpha-widget` and attaches library
`date_recur_modular/date_recur_modular_alpha_widget`. Template
`templates/entity-repeat-widget.html.twig` lays out `widget.mode`, `daily_count`, `start`/`end`/
`time_zone`, `weekdays`, `ordinals`, the `ends_mode`/`ends_count`/`ends_date` block, and finally
`widget.entity_repeat_enabled`. All values are Form API render elements (auto-escaped).
