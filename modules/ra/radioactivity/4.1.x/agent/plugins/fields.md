# Radioactivity — field types, widgets, formatters, entity, workers

Radioactivity does **not** define a new plugin *type*; it provides plugins of core types.

## Field types

| id | Class | Notes |
|---|---|---|
| `radioactivity_reference` | `Plugin/Field/FieldType/RadioactivityReferenceItem` (extends `EntityReferenceItem`) | **Recommended.** Entity-reference to a `radioactivity` entity that holds `energy` + `timestamp`; adds a computed `energy` property. Storage settings: `profile`, `granularity`, `halflife`, `cutoff` (+ fixed `target_type=radioactivity`). Category `trending`. Default widget `radioactivity_reference`, default formatter `radioactivity_reference_emitter`. |
| `radioactivity` | `Plugin/Field/FieldType/RadioactivityField` (extends `FieldItemBase`) | **Deprecated** ("Do not use for new sites"). Stores `energy` (float) + `timestamp` (int) inline on the host entity. Default widget `radioactivity_energy`, default formatter `radioactivity_emitter`. |

## Widgets

- `radioactivity_energy` (`Plugin/Field/FieldWidget/RadioactivityEnergy`) — sets initial energy/timestamp for the deprecated field.
- `radioactivity_reference` (`Plugin/Field/FieldWidget/RadioactivityReferenceWidget`) — for the reference field.

## Formatters

- `radioactivity_emitter` / `radioactivity_reference_emitter` — the **Emitter**: attaches
  `radioactivity/triggers` JS + a signed incident in `drupalSettings`; optionally displays the value
  (`display`, `decimals`). Emits `energy` on each render (see [../api/emit.md](../api/emit.md)).
- `radioactivity_value` / `radioactivity_reference_value` — display-only, shows the current energy
  with `decimals`, no emission.

## The `radioactivity` content entity

`Entity/Radioactivity` (`@ContentEntityType id="radioactivity"`, base table `radioactivity`, storage
handler `RadioactivityStorage`, `RadioactivityViewsData`). Base fields: `timestamp`, `energy` (float),
`langcode`, `uuid`. A reference field points here so the host entity's revisions stay unchanged when
energy updates. Interface: `RadioactivityInterface` (`getEnergy/setEnergy`, `getTimestamp/setTimestamp`).

## Queue workers (`Plugin/QueueWorker`)

- `radioactivity_incidents` (`RadioactivityIncidents`) — applies queued incident energy to entities.
- `radioactivity_decay` (`RadioactivityDecay`) — applies decay to a chunk of entities.
Both extend `RadioactivityQueueWorkerBase` and delegate to `RadioactivityProcessor`.

## Events / Rules

- `EnergyBelowCutoffEvent` (`Event/EnergyBelowCutoffEvent`, name via `EVENT_NAME`) — dispatched by the
  processor when an entity's energy drops to/below `cutoff`. Subscribe with a normal event subscriber.
- `radioactivity.field_cutoff` — the equivalent **Rules** event (`radioactivity.rules.events.yml`),
  context `entity`; Rules is a dev/test dependency only.

## Views

`RadioactivityViewsData` exposes the entity's energy so you can sort/filter "most popular" listings.
