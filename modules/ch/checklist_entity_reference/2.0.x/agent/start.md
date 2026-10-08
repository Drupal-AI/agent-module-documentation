<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checklist Entity Reference — agent start

Field module. Provides field type `entity_reference_checklist`, widget `entity_reference_checklist_options`
(extends core OptionsButtonsWidget), and formatters `entity_reference_checklist_label` /
`entity_reference_checklist_progress`. A hidden form extra-field `checklist_entity_reference_progress`
renders a progress bar (percent = round(100/total*selected)) via `hook_form_alter`.

- No routes, no permissions, no config entity — configure entirely through Field UI (manage fields / form display / display).
- Enable the "Checklist Progress" component on Manage form display to show progress on the edit form.
- Key files: `checklist_entity_reference.module` (progress bar + extra field), `src/Plugin/Field/*`.
- See ../usage.md for setup steps and use cases.
