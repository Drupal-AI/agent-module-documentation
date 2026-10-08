<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Field Widget event

`src/Plugin/ECA/Event/FieldWidgetActionsEvent.php` (`FieldWidgetActionsEvent extends EventBase`),
attribute `#[EcaEvent(id: 'eca_field_widget_actions', deriver: FieldWidgetActionsEventDeriver, version_introduced: '1.0.0')]`.
The deriver (`FieldWidgetActionsEventDeriver`) just returns `FieldWidgetActionsEvent::definitions()`.

## The single derivative
`definitions()` declares one:
- key/derivative `eca_field_widget` → full plugin id `eca_field_widget_actions:eca_field_widget`.
- label "ECA Field Widget", `event_name` = `FieldWidgetActionsEvents::FIELD_WIDGET_ACTION`
  (`'eca_field_widget_actions.field_widget_action'`, defined in `src/FieldWidgetActionsEvents.php`),
  `event_class` = `Event/FieldWidgetEvent`, `tags` = `Tag::RUNTIME`.

Add this event to an ECA model to make the model appear as a Field Widget Action button (see
[field-widget-action.md](field-widget-action.md) for how the button is derived).

## Config: `fill_strategies` ("Restrict by widget kind")
Only on the `eca_field_widget` derivative. `defaultConfiguration()` = `['fill_strategies' => '']`.
`buildConfigurationForm()` renders a single-value `select` whose options are
`'' => '- No restriction -'` plus `FieldWidgetSupport::fillStrategies()`:
- `editor` — Editor / text fields
- `select` — Select list
- `buttons` — Checkboxes or radio buttons
- `compound` — Compound fields (Address, Link, Smart Date, ...)

`submitConfigurationForm()` stores `trim((string) $form_state->getValue('fill_strategies'))`.
Stored as the chosen strategy string (the `FILL_*` constant), not the widget IDs it maps to; the
deriver expands it at read time. Schema: `eca.event.plugin.eca_field_widget_actions:eca_field_widget`
in `config/schema/…schema.yml` declares `fill_strategies: string`. Empty string = offer on every
field widget.

## Wildcard / matching
- `generateWildcard($eca_config_id, $ecaEvent)` returns `"{eca_config_id}.{event_id}"` — the event
  ID is prefixed with the ECA model ID so cloned models with identical event IDs do not collide
  (issue #3588904). This wildcard becomes the FieldWidgetAction derivative ID.
- `appliesForWildcard()` returns TRUE only when the dispatched `FieldWidgetEvent`'s `getEventId()`
  equals the wildcard.

## Tokens (`getData()`, `#[Token]`)
Available in the model when this event fires:
- `entity` — the `ContentEntityInterface` being edited.
- `field_name` — the field the button is attached to.
- `field_key` — the item index (delta), 0-based; `''` when the button covers the whole widget.
When the underlying event is a `TokenGenerateEvent`, `getData()` defers to its data first.

## The event object — `src/Event/FieldWidgetEvent.php`
`FieldWidgetEvent extends Symfony Event` (`@internal`). Constructed with `eventId`, `entity`,
`fieldName`, `fieldKey`. Getters for each, plus `getWidgetValue()` / `setWidgetValue(array|string)`
— `widgetValue` starts NULL and is what the "Set field widget value" action writes and the
FieldWidgetAction plugin reads back.
