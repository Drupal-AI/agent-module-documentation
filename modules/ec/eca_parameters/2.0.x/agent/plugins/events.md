<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event plugin: "Requesting parameter" (`parameters:request`)

Source: `src/Plugin/ECA/Event/ParametersEvent.php`, deriver
`src/Plugin/ECA/Event/ParametersEventDeriver.php`, event objects in `src/Event/`.

## What fires it

The `parameters` module dispatches its `ParameterEvents::COLLECTIONS_PREPARATION`
(`CollectionsPreparationEvent`) whenever it prepares the list of collections to resolve a
parameter. This module's subscriber (`src/EventSubscriber/EcaParameters.php`, `onPreparation()`)
listens to it and — **only when a specific parameter name is set on that event**
(`isset($event->name)`) — dispatches a `RequestingParameterEvent` under the event name
`eca_parameters.request` (`EcaParametersEvents::REQUEST`). See
[../config/collection.md](../config/collection.md) for the collection-injection half of the same
subscriber.

The ECA event plugin `ParametersEvent` maps that to the ECA event definition `request`:

```
label:        Requesting parameter
event_name:   eca_parameters.request
event_class:  Drupal\eca_parameters\Event\RequestingParameterEvent
tags:         Tag::READ | Tag::BEFORE | Tag::CONFIG
id:           parameters:request   (deriver-generated)
```

`RequestingParameterEvent` (`src/Event/RequestingParameterEvent.php`) is marked `@internal` and
just wraps the original `CollectionsPreparationEvent` (accessor `getPreparationEvent()`).

## Configuration (per event in a model)

`defaultConfiguration()` / `buildConfigurationForm()` add a single required field
**`parameter_name`** — the machine name of the requested parameter to react to (e.g.
`my_eca_parameter`). Leave matching to a wildcard by not restricting it.

## Wildcard matching

- `generateWildcard()` returns the trimmed configured `parameter_name`, or `*` if none.
- `appliesForWildcard()` returns TRUE when the incoming event's requested name
  (`$event->getPreparationEvent()->name`) equals the wildcard, or when the wildcard is `''`/`*`
  (match all requests).

So one model can target a single parameter by name, another can react to every parameter lookup.

## Tokens exposed

`buildEventData()` (annotated with ECA `#[Token]`) publishes, when the event is a
`RequestingParameterEvent`:

| Token | Source | Meaning |
|---|---|---|
| `event:parameter_name` | `getPreparationEvent()->name` | The requested parameter's machine name. |
| `event:entity` | first `EntityInterface` in `getPreparationEvent()->context` | The contextual entity, if any. |
| `event:ENTITY_TYPE` | same entity, keyed by its entity-type id | e.g. `event:node`. |

(Plus whatever the parent `EventBase::buildEventData()` adds.) A `post_update` hook
(`eca_parameters.post_update.php`) renamed the legacy token `event:parameter-name` to
`event:parameter_name` for ECA 2.0.0.

## Typical use

Respond the moment a parameter is looked up — e.g. compute or override its value dynamically,
log the lookup, or branch on the entity in context — rather than storing a static value in the
collection.
