<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a wizard (Manage form display)

There is **no dedicated admin page and no config entity of its own**. A wizard is configured entirely
through **Field Group** on an entity's *Manage form display*, and stored inside that form display's
`third_party_settings.field_group` config.

## Steps to build a wizard

1. Enable `entity_form_steps` (pulls in `field_group`). The module sets its weight to 1 so its
   `hook_form_alter` runs after Field Group.
2. Go to the entity's **Manage form display** (e.g. `admin/structure/types/manage/<bundle>/form-display`,
   or an alternative form mode). This requires the *administer … form display* permission.
3. Click **Add field group**, choose **Form step** as the format, and save.
4. Fill in the step settings (below). Only **Step label** is required.
5. Drag fields into the step group with the tabledrag handles. Repeat "Add field group → Form step"
   for each subsequent screen.
6. Step order = field-group **weight** (top-to-bottom). The first step is the wizard's start, the last
   step shows the real Save button.

Steps must be **top-level** groups in the `content` region — the module's display-form validator
(`_entity_form_steps_form_entity_display_form_validate`) strips any parent from a `steps` group, and
`getSteps()` ignores groups not in `region === 'content'`. You *can* nest ordinary field groups
(fieldset/tabs/etc.) **inside** a step.

## Per-step settings (`Step::settingsForm()` → schema `…formatter_plugin.steps`)

| Setting | Schema key | Effect |
| --- | --- | --- |
| Step label (required) | field-group `label` | Human-readable admin label; also used as fallback title material (filtered via `Xss::filterAdmin`). |
| Create title | `add_label` | Form `#title` when the entity is **new**. Blank = leave title unchanged. |
| Edit title | `edit_label` | Form `#title` when **editing**. Blank = leave title unchanged. |
| Cancel button label | `cancel_button` | Adds a Cancel link to `actions` **on the first step only**. Blank = no button. |
| Cancel button URL | `cancel_path` | Overrides Cancel target; supports entity **tokens**. Default: entity canonical, else current user's page for new entities. Validated on input. |
| Previous step button label | `previous_button` | Adds a Previous submit button on every non-first step. Blank = no button. |
| Next step button label | `next_button` | Relabels the Save button while a later step exists. |
| Save button label | `submit_button` | Relabels the Save button on the final step. |
| Preview button label | `preview_button` | Relabels core's Preview button; blank **removes** Preview. |
| Delete button label | `delete_button` | Relabels the Delete action; blank **removes** it. |
| Delete button URL | `delete_path` | Overrides Delete target; supports entity **tokens**. Validated on input. |

`cancel_path` / `delete_path` are validated by `Step::validateUrl()`: an internal path must begin with
`/` (or resolve via `path.validator`), otherwise it must be a valid external URL. A token help tree for
the group's entity type is shown under the two path fields.

## Reusing an alternate form mode

Any configurable form mode works. Create a form mode (Structure → Display modes → Form modes), enable
it for the bundle, and configure its steps there; then route the operation that should use the wizard
to that form mode. The default form mode also works directly.

## Caveats to tell the user

1. **Default translation only.** `alterForm()` returns early when the form's entity is not the default
   translation, so per-translation forms are never stepped.
2. **Delete operation is skipped** (the confirm form is left intact).
3. **User account forms** require core patch
   [#3328962](https://www.drupal.org/project/drupal/issues/3328962).
4. It is a **client-side-progress-free** wizard: no progress bar ships; add one via theming/CSS if
   desired.
