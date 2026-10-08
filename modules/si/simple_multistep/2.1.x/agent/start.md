<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Multistep — agent index

Converts an entity form into a multi-step wizard by adding a `form_step` **field_group
formatter**. No global config page (`configure` null), no permissions, no Drush. Depends on
`field_group`. Config schema stores per-step settings.

- **Adding "Form step" groups on Manage form display and all per-step settings** →
  [configure/form-step.md](configure/form-step.md)
- **Swapping the step controller: `hook_simple_multistep_controller_alter()` +
  `MultistepControllerInterface`** → [extend/controller.md](extend/controller.md)

Key facts:
- Formatter plugin id `form_step` (`@FieldGroupFormatter`, `supported_contexts = {"form"}`).
- `simple_multistep_form_alter()` (runs after field_group) detects any `form_step` group via
  `_check_form_multistep()` and drives navigation through a `MultistepController`.
- Next/Back are server-side submit handlers (`simple_multistep_register_next_step` /
  `_register_back`) using `$form_state->setRebuild()`; also wires Inline Entity Form
  sub-forms.
