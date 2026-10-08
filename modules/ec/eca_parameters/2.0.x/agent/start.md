<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Parameters (eca_parameters) — agent index

Integrates the **`parameters`** module with **ECA** (Event–Condition–Action). Adds ECA plugins to
read, test and write named Parameters, and registers its own `eca` parameters collection that ECA
can write to at runtime. Package **ECA**. Core `^10.3 || ^11`, PHP `>=8.1`. License
GPL-2.0-or-later. Version 2.0.2.

- **Depends on:** `drupal/eca ^2.0` (`eca:eca ^2`) and `drupal/parameters ^1.0`
  (`parameters:parameters`).
- **Submodule:** `eca_parameters_ui` (web UI to manage the `eca` collection) — documented at
  `../../modules/eca_parameters_ui/2.0.x/agent/start.md`.
- No routes, no permissions, no Drush, no libraries in the base module. Config schema only
  (`config/schema/eca_parameters.schema.yml`, an `ignore`-typed schema for the
  `eca_parameter_get` action config).

## What it provides (all from `src/`)

- **Event plugin** `parameters:request` "Requesting parameter" — `Plugin/ECA/Event/ParametersEvent.php`
  (+ `ParametersEventDeriver.php`). Fires on the `eca_parameters.request` event; exposes tokens
  `event:parameter_name`, `event:entity`, `event:ENTITY_TYPE`; wildcard-matches the requested
  parameter name. → [plugins/events.md](plugins/events.md)
- **Condition** `eca_parameter_exists` "Parameter: exists" — `Plugin/ECA/Condition/ParameterExists.php`.
- **Condition** `eca_parameter_value` "Parameter: compare value" — `Plugin/ECA/Condition/ParameterValue.php`
  (extends ECA `StringComparisonBase`). → [plugins/conditions.md](plugins/conditions.md)
- **Action** `eca_parameter_get` "Get parameter" — `Plugin/Action/ParameterGet.php` (loads a
  parameter → ECA token).
- **Action** `eca_parameter_set` "Set parameter" — `Plugin/Action/ParameterSet.php` (writes a
  parameter onto the `eca` collection, runtime or persisted). → [plugins/actions.md](plugins/actions.md)
- **The `eca` parameters collection + event subscriber** that makes ECA parameters resolvable
  everywhere the `parameters` module resolves values. → [config/collection.md](config/collection.md)

## Mechanism in one line

An event subscriber (`EventSubscriber/EcaParameters.php`) hooks the `parameters` module's
`CollectionsPreparationEvent`, injects the `eca` collection into the resolution list (ahead of
`global`), and dispatches `eca_parameters.request` when a named parameter is being requested — the
event plugin turns that into an ECA event.

## Notes

ECA models are built by administrators with ECA administration rights and their actions run with
real privileges; parameter names/values handled here come from that admin-authored config and from
the `parameters` module's own configuration, not from end-user request input.
