<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Form Steps (entity_form_steps) — agent index

Turns any **configurable entity form** into a multi-step wizard. Steps are **`field_group`**
groups with format type **`steps`** ("Form step") placed on the entity's *Manage form display*;
the whole runtime is a single `hook_form_alter`. **No config entity, no route, no permission, no
tempstore, no drush.** Version **1.1.7**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Hard dependency: **Field Group** (`field_group:field_group`, composer `^3.0|^4.0`).

**Why not the alternatives:** the Form API multi-step pattern is code that rebuilds state by hand;
moving the form to **Webform** gives an excellent survey tool but **not an entity form**, so the
result is not a node, user, or media entity.

## What you'd do → where

- **Configure a wizard (site builder)** → [agent/config/setup.md](config/setup.md) — adding the
  "Form step" field group on a form display, the per-step settings, and the four caveats.
- **Understand the runtime (how steps actually work)** → [agent/forms/wizard-mechanism.md](forms/wizard-mechanism.md)
  — `EntityFormSteps::alterForm`, step state in `$form_state`, per-step validation, Next/Previous
  navigation, and the single final save.
- **Alter steps in code** → [agent/forms/hooks.md](forms/hooks.md) — the three alter-hook families
  (`_steps_alter`, `_steps_state_alter`, `_steps_complete_form_alter`) with their `ENTITY_TYPE` /
  `BUNDLE` variants.

## Key facts (real names)

- **Field group formatter plugin:** id `steps`, label "Form step",
  `Drupal\entity_form_steps\Plugin\field_group\FieldGroupFormatter\Step` (extends
  `FieldGroupFormatterBase`, `supported_contexts: {form}`). Its `settingsForm()` defines every
  per-step option; `validateUrl()` validates the cancel/delete path fields.
- **Runtime class:** `Drupal\entity_form_steps\Form\EntityFormSteps` (all static methods) —
  `alterForm()`, `getSteps()`, `setAccess()`, `setValidation()`, `getCancelUrl()`, `validateForm()`,
  `validatePreviousForm()`, `submitForm()`.
- **Procedural glue (`entity_form_steps.module`):**
  - `hook_module_implements_alter()` forces this module's `hook_form_alter` to run **last**.
  - `entity_form_steps_form_alter()` calls `EntityFormSteps::alterForm()` for any
    `ContentEntityFormInterface` form.
  - `hook_form_FORM_ID_alter()` for `entity_form_display_edit_form` and `entity_view_display_edit_form`
    swaps in `_entity_form_steps_form_entity_display_form_validate()`, which forces a `steps` field
    group to have **no parent** (steps must be top-level, region `content`).
- **Where steps come from:** `getSteps()` reads the form display's `field_group` third-party
  settings and keeps groups whose `format_type === 'steps'` **and** `region === 'content'`, sorted by
  weight. `label` and string `format_settings` are run through `Xss::filterAdmin()`.
- **State (no tempstore):** held in `$form_state->get('entity_form_steps')` =
  `['steps' => …, 'current_step' => …, 'start' => bool, 'complete' => bool]`. Lives in core's
  server-side form cache (keyed by the random `form_build_id`, session-bound) — per-user, never
  persisted to storage.
- **Per-step config schema** (`config/schema/entity_form_steps.schema.yml`,
  `field_group.field_group_formatter_plugin.steps`): `add_label`, `edit_label`, `cancel_button`,
  `cancel_path`, `previous_button`, `next_button`, `submit_button`, `preview_button`,
  `delete_button`, `delete_path`. (Step `label` is the field-group's own required label.)
- **Install:** `hook_install()` / `update_9001()` set the module weight to **1** so it runs after
  `field_group`.
- **Caveats:** (1) steps only on the **default-translation** form — `alterForm()` bails if
  `!$entity->isDefaultTranslation()` and on the `delete` operation; (2) **user-account** forms need
  core patch [#3328962](https://www.drupal.org/project/drupal/issues/3328962).

## Access & security posture (summary)

Adds **no routes and no permissions** — every wizard runs inside the entity's own add/edit form, so
access is exactly the underlying entity form's access. Step config is gated by the
"administer <entity> form display" permission; admin-supplied labels/settings pass
`Xss::filterAdmin()`; cancel/delete paths are validated on input. Step state is server-side and
per-session. No security issues found in this review.
