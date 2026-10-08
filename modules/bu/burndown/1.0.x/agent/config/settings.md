<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown — global settings

Config object **`burndown.config_settings`** (schema `config/schema/burndown.config_settings.schema.yml`,
type `config_object`). Edited at `/admin/config/burndown/settings` via
`\Drupal\burndown\Form\SettingsForm` (route `burndown.burndown_settings`, permission
`administer site configuration`). `SettingsForm::getEditableConfigNames()` returns this object only.

## Keys (defaults from `config/install/burndown.config_settings.yml`)

- `enable_email_notifications` (boolean, default `1`) — master switch for the task-change emails
  sent by `TaskNotificationsSubscriber`.
- `geometric_size_defaults` (string) — newline `value|label` list for geometric estimates
  (`0.5|0.5`, `1|1`, `2|2`, `3|3`, `5|5`, `8|8`, `13|13`).
- `tshirt_size_defaults` (string) — `value|label` list for T-shirt estimates (`XS|XS` … `XL|XL`).
- `resolution_statuses` (string) — `value|label` list of task resolutions
  (`Done`, `Won't Do`, `Can't Reproduce`, `Duplicate`).
- `relationship_types` (string) — `value|label` list of task relationship types
  (`Blocked by`, `Blocks`, `Related to`, `Followed up by`, `Follows up`).
- `relationship_opposites` (string) — `value|opposite` map so adding one side of a relationship can
  show/back-reference the inverse (e.g. `Blocked by|Blocks`).

Each estimate/relationship list is a textarea parsed as `allowed values` (`key|label` per line).
A per-project `estimate_type` field selects which of the estimate scales a project uses.

## Other config

- Config-entity schemas: `burndown_project_type.schema.yml`, `burndown_task_type.schema.yml`,
  `default_swimlane.schema.yml`.
- Install config seeds a default project type, task type, six `default_swimlane` templates, two views
  (`my_tasks`, `burndown_task_by_ticket_id`) and two optional blocks.
- There is no `configure` key in `burndown.info.yml`; the settings form is reached from the
  Configuration menu (Burndown → Burndown Settings).
