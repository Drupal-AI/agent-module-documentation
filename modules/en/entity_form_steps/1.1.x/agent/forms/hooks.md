<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Altering steps in code (hooks)

Declared in `entity_form_steps.api.php`. Each hook has three granularity variants, all invoked by the
runtime: generic, `ENTITY_TYPE`-specific, and `ENTITY_TYPE` + `BUNDLE`-specific. Names are built from
the live entity, e.g. for a node of bundle `article`:
`hook_entity_node_form_article_steps_alter()`.

## 1. `hook_entity_form_steps_alter(&$steps, $form_state, $entity)`

Fired at the end of `getSteps()`. Mutate the **ordered step array** before rendering — add, remove, or
reorder steps. Each step entry looks like a field-group definition (`label`, `weight`, `format_type`,
`format_settings` with the button/label keys). Example from the API file adds a dynamic confirmation
step by cloning the current one and overriding its `add_label`/`edit_label`.

- `hook_entity_ENTITY_TYPE_form_steps_alter()`
- `hook_entity_ENTITY_TYPE_form_BUNDLE_steps_alter()`

## 2. `hook_entity_form_steps_state_alter(&$state, $form_state, $entity)`

Fired inside `validateForm()` after the step pointer is positioned, using `moduleHandler()->alter()`.
`$state` = `['steps', 'current_step', 'start', 'complete']`. Use it to change navigation dynamically —
e.g. set `$state['complete'] = TRUE` to **skip the final step** when a "save without confirmation" value
is present (the documented example).

- `hook_entity_ENTITY_TYPE_form_steps_state_alter()`
- `hook_entity_ENTITY_TYPE_form_BUNDLE_steps_state_alter()`

## 3. `hook_entity_form_steps_complete_form_alter(&$form, $form_state, $entity, $state)`

Fired at the end of `alterForm()` after the form is fully assembled. Add per-step markup/help — e.g.
inject a confirmation message when `$state['current_step'] === 'confirm'`. Receives the full `$form`
and the current `$state`.

- `hook_entity_ENTITY_TYPE_form_steps_complete_form_alter()`
- `hook_entity_ENTITY_TYPE_form_BUNDLE_steps_complete_form_alter()`

## Other integration points

- The module sets `$form['#attributes']['data-unsaved'] = TRUE` whenever step state already exists —
  hook a JS "unsaved changes" warning to that attribute.
- No services, no events, no plugins to implement beyond these hooks; the only plugin the module itself
  provides is the `steps` field-group formatter (see [config/setup.md](../config/setup.md)).
