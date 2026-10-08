<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config

Form: `EntityAbuseSettingsForm` (`src/Form/EntityAbuseSettingsForm.php`, `ConfigFormBase`), form id
`entity_abuse_settings_form`, route `entity_abuse.settings` at `/admin/structure/entity-abuse`
(permission `entity_abuse manage settings`). Editable config: `entity_abuse.settings`.
Schema: `config/schema/entity_abuse.schema.yml`; install defaults: `config/install/entity_abuse.settings.yml`.
Translatable via `entity_abuse.config_translation.yml` (adds a "Translate entity abuse" tab when the core
Configuration Translation module is enabled).

## Config keys (`entity_abuse.settings`)

| Key | Schema type | Meaning / options | Default |
|---|---|---|---|
| `enabled` | sequence of string | Entity type ids that expose the report link (checkboxes of all content entity types except `entity_abuse_report`). Required. | `{ }` (none) |
| `report_link_behavior` | string | `redirect` (own page), `dialog`, or `modal`. | `modal` |
| `user_cancel_method` | string | On account cancel: `delete` all their reports, or `reassign` to anonymous. | `reassign` |
| `no_access_behavior` | string | When user lacks `add` permission: `hide` link, or `message` (show link → no-access message). | `message` |
| `label_add_report` | label | Text of the add link. Required. | `Complain` |
| `message_report_added` | text_format | Status message after adding (empty disables). | "Your complain was successfully added." |
| `message_no_access` | text_format | Message shown on the no-access page (required when `no_access_behavior = message`). | "You are not allowed to add a new complaint." |
| `label_edit_report` | label | Text of the edit link. Required. | `Edit your complain` |
| `message_report_edited` | text_format | Status message after editing (empty disables). | "Your complain was successfully updated." |
| `label_cancel_report` | label | Text of the cancel (delete) link. Required. | `Cancel your complain` |
| `message_report_canceled` | text_format | Status message after cancelling (empty disables). | "Your complain was successfully canceled." |
| `note_cancel_report` | text_format | Confirmation text on the delete form. Required. | "Are you sure you want to cancel the complain?…" |

The form groups the label/message keys into vertical-tab detail groups ("Report adding", "Report editing",
"Report canceling"). `submitForm()` writes all keys back; `enabled` is stored as
`array_values(array_filter(...))` so only checked types persist. `text_format` messages are rendered with
`check_markup` at display time, applying the stored text format's filters.

## Other bundled config (`config/install/`)

- `field.storage.*` + `field.field.*` — the default "Message" formatted-long field on the report bundle.
- `core.entity_form_display.*` / `core.entity_view_display.*` / `core.entity_view_mode.*` — default form
  display (textarea) and full/teaser view modes for the report.
- `views.view.entity_abuse_reports` — the admin review View (see
  [permissions-and-review.md](permissions-and-review.md)).
