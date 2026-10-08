<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The wizard runtime (how steps actually work)

Everything happens in one `hook_form_alter` on `ContentEntityFormInterface` forms, wired so it runs
**last** (`hook_module_implements_alter`). Entry point:
`Drupal\entity_form_steps\Form\EntityFormSteps::alterForm()`.

## 1. Discover steps — `getSteps()`

Reads the active form display (`$form_state->getStorage()['form_display']`) and keeps its
`field_group` third-party settings whose `format_type === 'steps'` and `region === 'content'`, sorted
by weight (`SortArray::sortByWeightElement`). Each step's `label` and every string in its
`format_settings` are sanitised with **`Xss::filterAdmin()`**. It then fires the three
`*_steps_alter` hook families so code can add/remove/reorder steps dynamically (e.g. a confirmation
step). Returns an ordered, keyed array of step definitions.

## 2. Initialise state — first build

`alterForm()` bails immediately when: the operation is `delete`, or the entity is **not** the default
translation, or there are no steps. Otherwise it seeds server-side state (only once per form build):

```
$form_state->set('entity_form_steps', [
  'steps'        => $steps,             // ordered step defs
  'current_step' => <first step key>,
  'start'        => TRUE,               // current === first
  'complete'     => FALSE,              // current === last
]);
```

This lives in core's **form cache** — keyed by the random `form_build_id`, session-bound, per-user.
There is **no tempstore and nothing persisted to storage**; abandoning the form discards the state and
any entered values.

## 3. Render the current step only

For every step that is **not** the current one, the group and all its child elements get
`#access = FALSE` (recursively, via `setAccess()`), which both hides them and stops them producing
false validation errors or losing their submitted values on rebuild. The current step's fields are the
only visible ones.

The action buttons are reshaped from the step settings: first step may get a **Cancel** link
(`getCancelUrl()` — token-replaced `cancel_path`, else entity canonical, else the current user's page);
non-first steps get a **Previous** submit button (`#name = entity_form_steps_previous`); the Save button
is relabelled to the step's Next label until the final step, where it uses the Save label. Preview and
Delete are relabelled or removed per settings; `delete_path` is token-replaced and turned into a `Url`.
The form `#title` is set from `add_label`/`edit_label` (via `Markup::create` on the already
`Xss::filterAdmin`-ed value). Finally the three `*_steps_complete_form_alter` hooks fire.

## 4. Per-step validation — `validateForm()` (+ `setValidation()`)

`alterForm()` unshifts `EntityFormSteps::validateForm` onto `#validate`, appends
`validatePreviousForm`, unshifts `submitForm` onto the submit handler, and sets
`$form['actions']['submit']['#limit_validation_errors'] = []` — then `setValidation()` re-adds **only
the current step's** field keys (walking nested groups; also whitelists `created`). Net effect: pressing
Next validates **just the current step**, so errors surface where they were caused rather than at the
end.

`validateForm()` calls `$form_state->setRebuild()` (stay on the wizard), rebuilds the entity from the
accumulated values (dropping values for fields not on the current step so non-widget/custom form
elements are handled), moves the internal step pointer, and re-fires the `*_steps_state_alter` hooks
(which may flip `complete` early to skip a trailing step). It then advances by triggering element:

- `entity_form_steps_previous` → `prev()` (go back a step).
- `op` (the Save/Next button) → if not `complete`, `next()`; if `complete`, `setRebuild(FALSE)` to
  **release the form to the normal entity save**.
- anything else (e.g. an "Add another item" AJAX button) → `setRebuild(FALSE)` so core handles it.

`current_step`, `start`, and `complete` are recomputed from the pointer and stored back.

## 5. Backward navigation — `validatePreviousForm()`

When Previous is pressed and there are validation errors, for each errored field it resets the field to
its **original** stored value (via `loadUnchanged()` for existing entities, or `NULL` for new ones) and
then `clearErrors()`. So going back never blocks on a half-filled later step, while valid answers are
preserved.

## 6. The single save

There is **only one real save**, performed by the standard entity form once the last step's Save button
releases the rebuild (`setRebuild(FALSE)` in the `op`/`complete` branch). `submitForm()` merely blanks
`content_translation` values so the translation handler can't rewrite author/created on the default-
translation save. Because the entity is written only at the end, a wizard abandoned midway creates
**nothing** — there are no partial/orphaned entities.

## Access & isolation notes

- No routes are added; the wizard is the entity's own add/edit form, so access equals that form's
  access. A user cannot reach a step for an entity they cannot already add/edit.
- `current_step`/`complete` are **server-side** in the form cache; the client cannot post a step index
  to jump ahead. Reaching the final save requires clicking through each step, and each Next validates
  its step.
- Step state is keyed by the session-bound `form_build_id`, so one user cannot read or resume another
  user's in-progress values.
