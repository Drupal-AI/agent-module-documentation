# Configuration

Simple Multistep has no global settings page. You build a wizard entirely on an
entity's **Manage form display**, using Field Group's grouping tools plus the
**Form step** format this module adds.

## Build the steps

1. Make sure `simple_multistep` (and its dependency **Field Group**) are enabled.
2. Go to the form display you want to convert — for example **Structure → Content
   types → *(your type)* → Manage form display**. If you want the wizard on a
   specific form mode only, configure that display.
3. Click **Add group**, choose **Form step** as the group format, and give the
   group a name. This group is your first step.
4. Drag the fields that belong in that step into the group.
5. Repeat **Add group → Form step** for each additional step, and drag the
   relevant fields into each. Every "Form step" group in the display becomes one
   sequential step.
6. **Save** the display.

Any form display that contains at least one "Form step" group is automatically
turned into a multi-step form: only the current step is shown, and Next/Back
buttons are added. Values you enter are preserved as you move between steps
(the entity is rebuilt on each Next), and validation happens step by step.

## Per-step settings

Each "Form step" group has its own settings, reached from the group's gear/edit
control on Manage form display:

- **Step title** — the group's label. Paired with **Show step title** (on by
  default), which controls whether that title is displayed on the step.
- **Step description** — text shown on the step, under the title.
- **Step help** — additional help text for the step.
- **Show back button** — off by default, and never shown on the very first step.
  Turn it on for steps where you want to let people go back.
- **Back button text** — the label for the Back button (default "Back").
- **Next button text** — the label for the Next button (default "Next").
- **Required fields** — on by default in the form context. When on, required-field
  behavior and validation are enforced for that step, so a visitor can't advance
  past a step while a required field on it is empty.

## Works inside Inline Entity Form

If your form uses **Inline Entity Form**, the "Form step" groups also apply to the
IEF sub-form, so a nested entity's fields can be presented as steps too — no extra
configuration needed beyond adding the groups to that sub-form's display.

## Advanced: swapping the step controller

Developers who need bespoke navigation, validation gating, or a custom progress
display can replace the step controller for a specific form via
`hook_simple_multistep_controller_alter()` — see the
[`agent/`](../agent/extend/controller.md) docs for the interface and an example.
This is the module's one code-level extension point; everything else is done
through the form-display UI above.
