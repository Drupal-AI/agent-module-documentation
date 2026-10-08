<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Form Steps turns any configurable entity form into a multi-step wizard, using Field Group's "Form step" formatter on a form display to decide which fields belong to which step — no code, no new routes.

---

Long forms are abandoned. A registration asking thirty questions on one screen, a grant application, a detailed product submission — each presents a wall that discourages people before they start, and the standard remedy is to break it into steps so each screen looks achievable. Doing that in Drupal has meant either the Form API's multi-step pattern, which is code that rebuilds state by hand, or moving the whole thing to Webform, which is excellent for surveys but is **not** an entity form, so the result is not a node, user, or media entity. This module keeps the entity form and adds the steps, leaning on **`field_group`** — already the standard way of organising fields into tabs and fieldsets. A site builder adds a field group with format type **`steps`** on the entity's *Manage form display*, drags fields into it, and repeats; each such group becomes one screen. There is **no config entity, no route, and no tempstore** — the whole wizard is a `hook_form_alter` (`EntityFormSteps::alterForm`) that hides the inactive steps' fields (`#access = FALSE`) and drives navigation with Next/Previous/Cancel buttons. Partial data lives in the standard server-side **`$form_state`** (the core form cache, keyed by the random `form_build_id` and tied to the session), so it is per-user and never persisted: abandoning at step three loses the in-progress work, and the entity is written **once**, by the normal entity save, only when the last step is submitted. Version **1.1.7** on `^9 || ^10 || ^11`. Three things make the wizard actually better than the wall it replaces, and this module handles all three: **validation timing** — each Next validates only the current step's fields (`#limit_validation_errors`), so errors surface where they were caused; **backward navigation** — Previous reverts just the erroneous fields and clears their errors, preserving valid answers; and the caveats — steps work **only on the default-translation form**, and **user-account** forms need core patch [#3328962](https://www.drupal.org/project/drupal/issues/3328962).

---

- Split a long node registration or content-type form into sequential steps.
- Break a grant or job application into digestible screens.
- Turn a detailed product/listing submission into a wizard.
- Reduce form abandonment on a lengthy form without moving to Webform.
- Group entity fields into wizard steps directly in Manage form display.
- Keep the result a real entity (node/user/media/custom) while adding steps.
- Add per-step Cancel, Previous, Next, Save, Preview, and Delete buttons with custom labels.
- Set distinct form titles for the create vs. edit flow per step.
- Guide editors through a complex media or paragraph-heavy form.
- Reduce cognitive load and improve mobile completion of a big form.
- Organise a membership signup across steps.
- Structure an onboarding or profile-completion form.
- Validate each step independently so users fix errors as they go.
- Let users go back a step to correct an answer without losing later input.
- Add a dynamic confirmation/summary step via `hook_entity_form_steps_alter()`.
- Conditionally skip a step based on entered values via `hook_..._steps_state_alter()`.
- Inject per-step help text or markup via `hook_..._steps_complete_form_alter()`.
- Route the Cancel/Delete buttons to custom URLs with entity-token replacement.
- Reuse an existing alternative form mode as the multi-step variant of a form.
- Warn on unsaved changes using the `data-unsaved` attribute the module sets.
- Build wizards for any entity type that exposes a configurable form display.
