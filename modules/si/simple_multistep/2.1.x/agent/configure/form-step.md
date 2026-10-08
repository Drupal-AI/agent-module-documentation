<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Multistep — configuring steps

Steps are configured entirely on **Manage form display** using field_group. There is no
admin settings page.

## Setup
1. Enable `simple_multistep` (requires `field_group`).
2. On the entity/bundle's *Manage form display*, click **Add group**, choose **Form step**
   as the group format, and name it — this group is one step.
3. Drag fields into the group. Repeat "Add group" for each additional step; every
   `form_step` group in the display becomes a sequential step.
4. Save. Any form display containing at least one `form_step` group is turned into a
   multi-step form (`_check_form_multistep()` looks for `format_type === 'form_step'`).

## Per-step settings (plugin `FormStep::settingsForm()`)
Schema `field_group.field_group_formatter_plugin.form_step`:
- **Step title** (`label`, the group label) and **Show step title**
  (`show_step_title`, default TRUE).
- **Step description** (`step_description`, textarea) — shown on the step.
- **Step help** (`step_help`, textarea) — help text on the step.
- **Show back button** (`back_button_show`, default FALSE — not shown on the first step).
- **Back button text** (`back_button_text`, default "Back").
- **Next button text** (`next_button_text`, default "Next").
- **Required fields** (`required_fields`, default TRUE in form context) — when on, attaches
  `field_group/formatter.fieldset` + `field_group/core` libraries so required-field
  behavior/validation is enforced per step.

`defaultContextSettings()` supplies the defaults above. `settingsSummary()` reports the
back-button and show-title state.

## Runtime behavior
- `FormStep::process()` wraps the group in a `#type => container`, applies an HTML id (from
  the group id, uniquified) and the field_group classes.
- `simple_multistep_form_alter()` (registered to run **after** field_group via
  `hook_module_implements_alter`) instantiates/reuses a `MultistepController` stored in
  `$form_state` (`multistep_controller`), calls `rebuildForm()` to show only the current
  step and inject Next/Back, and attaches `simple_multistep/simple_multistep` CSS.
- **Next** (`simple_multistep_register_next_step`): for `EntityFormInterface` forms it does
  `buildEntity()` + `setEntity()` to preserve entered values, then `increaseStep()` and
  `setRebuild()`. **Back** (`simple_multistep_register_back`): `reduceStep()` when
  `current_step > 0`, then `setRebuild()`.
- **Inline Entity Form**: `hook_inline_entity_form_entity_form_alter` attaches field groups
  to the IEF sub-form and runs the same multistep alter, so steps work inside IEF.
