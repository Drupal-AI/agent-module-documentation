<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Trim works

Trim is ~40 lines of procedural code in `trim.module` plus a one-line `trim.install`. There
are no services, classes, or config entities.

## The three functions

1. **`trim_form_alter(&$form, $form_state, $form_id)`** — implements `hook_form_alter()`.
   - Gets the form object: `$form_object = $form_state->getFormObject();`
   - Bails unless it is an entity form: `if (!method_exists($form_object, 'getEntity')) return;`
   - Bails unless the entity's type is a content entity:
     `if (!$form_object->getEntity()->getEntityType() instanceof ContentEntityType) return;`
     (so `ConfigEntityType` forms — views, field settings, etc. — are **never** trimmed).
   - Normalizes `$form['#validate']` to an array, then
     `array_unshift($form['#validate'], 'trim_form_values');` so Trim validates **first**.

2. **`trim_form_values(&$form, $form_state)`** — the validation callback. Iterates
   `$form_state->getValues()`, passes each value through `trim_value()`, and writes it back
   with `$form_state->setValue($key, $value)`.

3. **`trim_value(&$value)`** — recursive helper: if the value is an array it recurses into
   each element (handles multi-value fields and nested widget structures); if it is a string
   it does `$value = trim($value);`. Non-string scalars are left as-is.

## Why the module weight is 1001

`trim_install()` calls `module_set_weight('trim', 1001)`. Drupal invokes `hook_form_alter`
implementations in module-weight order, so the heaviest module runs **last** — meaning
Trim's `array_unshift` is the last thing to touch `$form['#validate']`, leaving
`trim_form_values` at the very front of the validator list. Net effect: trimming happens
before any field-level or form-level validation.

## What it does and does not affect

- **Affected:** any content entity edit/add form — node, user, taxonomy term, media,
  comment, and custom content entities (in Drupal, users and terms count as "content").
- **Not affected:**
  - Config entity forms (Views UI, field/display config, etc.) — skipped on purpose so an
    intentional single-space option key is preserved.
  - Anything that bypasses the Form API: the **REST API**, migrations/Feeds, and direct
    `$entity->save()` calls. Trim is a form-validation-time transform, not a presave hook.
  - HTML5 client-side validation still fires first in the browser (e.g. `type="number"`,
    `type="email"`), so a space in those inputs can still be blocked before Trim runs.

## No hooks invited, no API to call

Trim defines no `trim.api.php`, exposes no service, and invites no hooks. To change its
behavior you override/replace the procedural functions (not recommended) or adjust its
module weight. There is nothing to call programmatically.
