<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Integrity (entity_usage_integrity) — agent index

Reads Entity Usage's reference data and enforces referential integrity between **published** entities.
Works entirely through `hook_form_alter` + a form `#validate` handler added to every form (in
`entity_usage_integrity.module`) — there is **no report page and no public service API for other code
to call for checks**. A relationship is judged by `IntegrityValidator::getStatus()`:
`valid` = source and target both published; `invalid` = published source points at an unpublished
target; `ignore` = source is unpublished, target is missing, or (with the option on) target is a draft.
One site-wide setting (`mode`: `warning` default, or `block`) decides whether a bad relation only warns
or actually blocks the save / disables the delete button.

Hard dependency: **`entity_usage`**. Optional integration with core **`content_moderation`** (moderation
forms + an AJAX confirm dialog). Core `^10.3 || ^11`. Package `Other`. No permissions of its own
(settings form uses `administer entity usage`), no drush, no plugin types. Provides config schema.

NOTE: `entity_usage_integrity.services.yml` injects `content_moderation.moderation_information`
unconditionally, so the DI container fails to compile unless `content_moderation` is enabled, even
though `.info.yml` does not list it as a dependency.

## What you'd do → where

- **Set warn-vs-block mode, the unpublished-skip toggle, find the settings route/config keys/defaults** →
  [configure/settings.md](configure/settings.md)
- **Understand exactly when/where each check fires, the status logic, or suppress the check on a form
  from code (the applicability event)** → [api/integrity-checks.md](api/integrity-checks.md)

## Key facts (real machine names)

- Settings route: `entity_usage_integrity.settings` → `/admin/config/entity-usage/integrity`
  (`_form` `Drupal\entity_usage_integrity\Form\IntegritySettingsForm`, `_permission: administer entity usage`).
  Local task `entity_usage_integrity.settings` (base_route `entity_usage.settings.form`, an "Integrity" tab).
- Config object: `entity_usage_integrity.settings` — keys `mode` (`warning`|`block`, default `warning`)
  and `ignore_unpublished_entities` (bool, default `true`). Schema in `config/schema/`.
- Services: `entity_usage_integrity.validator` (`IntegrityValidator`, an `EntityHandlerInterface`),
  `entity_usage_integrity.usage` (`EntityUsage` — its own wrapper over `entity_usage.usage` for
  default-revision + pre-save-field lookups), `logger.channel.entity_usage_integrity`.
- Form handlers (`src/FormIntegrityValidation/`): `ViewedEditForm` (warn on edit-form open),
  `SubmittedEditForm` (block-mode save validation), `ViewedDeleteForm` (list referencers / disable
  delete), `SubmittedModerationStateForm` + `ModerationStateChangeConfirmDialog` (content_moderation).
- Event: `entity_usage_integrity.applicability_check`
  (`EntityUsageIntegrityEvents::APPLICABILITY_CHECK`) with
  `EntityUsageIntegrityApplicabilityCheckEvent` (`setApplicable(bool)`) — lets other modules turn the
  check off for a given edit/delete form.
- Contexts (`IntegrityValidationContext`): `entity_edit_form_view`, `entity_delete_form_view`,
  `entity_save`.
- "Broken" relations (usage row points at a non-existent entity) are logged + shown as a warning, never
  block; treated as `ignore` in status (a `@todo` marks it for a future real `broken` status).
