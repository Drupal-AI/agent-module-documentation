<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Condition lets an ECA model decide the result of a reusable Drupal Condition plugin.

---

ECA Condition bridges Drupal's Condition plugin system and the ECA (Events-Conditions-Actions) module. It
ships a single core Condition plugin (id `eca_condition`, label "ECA Condition") that you can drop anywhere
Drupal evaluates conditions — block visibility, and any other consumer of the Condition plugin API. The
plugin holds a list of named condition IDs; when it is evaluated it dispatches an ECA event for each ID, and
an ECA model listening for that event computes and returns a TRUE/FALSE verdict using the module's "ECA
Condition: set result" action. The core condition passes only when every listed ID resolves to TRUE. In
effect you author condition logic visually in ECA once and reuse it wherever Drupal conditions apply. The
module depends on ECA (`eca:eca ^2`) and is part of the ECA package. It adds no routes, permissions, config
forms, or Drush commands.

---

- Build a custom Drupal Condition plugin without writing PHP, using an ECA model.
- Gate block visibility on logic authored in ECA.
- Reuse one ECA-authored condition in many places by referencing its condition ID.
- Combine several named conditions in one plugin instance (all must be TRUE to pass).
- Branch an ECA model on a `condition_id` and return a per-ID result.
- Expose complex business rules (that ECA can express) to any Condition-plugin consumer.
- Return TRUE/FALSE from a model with the "ECA Condition: set result" action.
- React to the "ECA Condition" ECA event (`eca_condition:condition_event`) at runtime.
- Use the `[condition_id]` token inside the model to know which condition is being asked.
- Centralize condition logic in ECA instead of scattering custom condition classes.
- Let site builders adjust condition behaviour by editing an ECA model, not code.
- Compose ECA models that share the same condition-evaluation event.
- Drive different verdicts for different condition IDs from a single model.
- Add a condition whose outcome depends on data only ECA can reach (tokens, entities, services).
- Prototype conditional visibility rules quickly in the ECA UI.
- Standardize how conditions are computed across a site via one model.
- Feed the condition result back into a UI feature that consumes core conditions.
- Keep condition logic versioned and exportable as ECA/config.
- Extend Drupal's built-in condition set with model-driven conditions.
- Chain ECA actions after a condition event to compute the verdict.
