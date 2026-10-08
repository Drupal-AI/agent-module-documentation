<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides reusable form elements, field widgets and a service for configuring and resolving groups of Drupal condition plugins.

---
Drupal core ships condition plugins (e.g. request path, user role) but no reusable UI for composing several of them with AND/OR logic. This module supplies that plumbing. It defines render elements `conditions` and `conditions_groups` (in `src/Element`) built on the Plugin Form Element module, so a form can expose a full condition-configuration UI, and a `ConditionsService` that initialises condition plugins with context and evaluates them: `resolveConditionsGroups()` returns a boolean for a set of condition groups, and `initializeConditions()` hydrates plugin configuration with the available contexts.

The `conditions_field` submodule adds a `conditions` field type (stored as JSON via the json_field module) plus its widgets/formatter, and a `ConditionsFieldService` that can query entities whose stored condition configuration matches — building JSON_EXTRACT-based SQL against the field's storage table. The `conditions_test` submodule provides example forms and test coverage.

This is developer-facing infrastructure: you embed the `conditions`/`conditions_groups` elements in your own forms, or add a conditions field to an entity, then call the service to decide behaviour. There are no site-facing routes or permissions in the main module.
---
- Add a condition-builder UI to a custom form.
- Compose multiple condition plugins with AND/OR group logic.
- Evaluate a set of condition groups to a boolean at runtime.
- Initialise condition plugins with runtime contexts.
- Store per-entity conditions in a `conditions` field (submodule).
- Query entities whose stored conditions match given values.
- Reuse core condition plugins (path, role, etc.) in your feature.
- Build business-rule toggles driven by condition plugins.
- Provide editors a widget to configure visibility conditions.
- Render an "empty" formatter for the conditions field.
- Back condition storage with JSON via json_field.
- Group conditions into multiple rows with independent logic.
- Use the Plugin Form Element base for consistent plugin config forms.
- Prototype conditional content behaviour without custom plugins.
- Drive access/visibility decisions from stored condition config.
- Test condition configuration with the bundled test forms.
- Cache resolved condition data per configuration hash.
- Extend with your own condition plugins and expose them in the UI.
- Combine contexts (node, user) when evaluating conditions.
- Centralise condition-evaluation logic in one service.