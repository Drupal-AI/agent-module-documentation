<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & node-form behaviour

## Install / enable

`composer require drupal/change_requests` (pulls `drupal/changed_fields` and
`yetanotherape/diff-match-patch`), then `drush en change_requests`. Requires core `node`. After
enabling, grant permissions and enable at least one content type (below), or the module does
nothing on node edits.

## Settings form (`src/Form/ChangeRequestsConfig.php`)

- Route `change_requests.change_requests_config` at `/admin/config/content/change_requests`
  (menu link under *Configuration → Content authoring*; registered by `PatchHtmlRouteProvider`,
  permission `administer patch entities`). Form id `change_requests_config`, a `ConfigFormBase`
  editing `change_requests.config`.
- On build it runs `_change_requests_check_permissions()` and shows an error if a role that can
  create patches lacks the matching `edit any <bundle> content` permission.

Form fields → config keys:

- **Node Types** (`node_types`, checkboxes) — which content types are managed. When a bundle is
  enabled its node edit form diverts saves into patches.
- **General excluded fields** (`general_excluded_fields`, textarea, one machine name per line) —
  fields never captured into patches (defaults include `nid`, `uuid`, `vid`, `langcode`, `type`,
  `revision_*`, `status`, `uid`, `created`, `changed`, `promote`, `sticky`, `moderation_state`,
  `path`, etc.).
- **Per-bundle excluded fields** (`bundle_<type>_fields`, checkboxes in a vertical-tab per bundle)
  — additional per-content-type field exclusions; editable only after the bundle is enabled and
  saved.
- **enable_checkbox_node_form** (bool) — default state of the "Create change request from changes"
  checkbox for users who can bypass.
- **log_message_required** (bool) — force a log message on the node form for managed bundles.
- **log_message_title** (string) — relabel the revision-log textarea.
- **image_style** (string, default `thumbnail`) — image style used in patch diff / apply views.

## Config object & schema

- Config: `change_requests.config` (install defaults in `config/install/change_requests.config.yml`).
- Schema: `config/schema/change_requests.schema.yml` — typed as `config_entity`; `node_types` and
  `general_excluded_fields` are sequences of strings, `enable_checkbox_node_form` boolean. (The
  `log_message_*`, `image_style` and dynamic `bundle_<type>_fields` keys are written by the form
  but not all declared in the shipped schema.)

## Node-form behaviour (`AccessService`, `change_requests.access_service`)

`change_requests_form_node_form_alter()` + `AccessService` decide what a user sees/does on a
managed node's edit form:

- `disableCreateNewRevision()` — forces & locks "create new revision" on for managed bundles.
- `displayCheckboxCreatePatch()` — shows the "Create change request from changes" checkbox when
  the user has `add patch entities` and the bundle is managed.
- `disableCheckboxCreatePatch()` / `defaultValueCheckboxCreatePatch()` — whether that checkbox is
  locked and its default (users who cannot bypass are forced to create a patch).
- `bypassChangeRequest()` — TRUE (save the node directly) when the bundle is not managed, the user
  has `bypass patch creation`, or the user is the node's owner.
- `startPatchCreateProcess()` — the master gate used by `hook_node_presave`: node edit route +
  managed bundle + `add patch entities`, and either the user cannot bypass or ticked the checkbox.
- `isLogMessageRequired()` / `allowOverrideLogMessageTitle()` — apply the log-message config.

## Permissions to grant

- Proposers: `add patch entities` (create change requests). Per the status-report check they are
  expected to also hold `edit any <bundle> content` for managed bundles.
- Reviewers who merge changes: `apply patch entities` (any patch) or `apply own patch entities`
  (only their own); plus `view patch entities` to browse them. These are restricted permissions.
- Direct editors: `bypass patch creation` to skip the workflow.
- Admins: `administer patch entities` for the settings form.

## Computed field

`change_requests_entity_bundle_field_info()` adds a computed integer field `cr_count`
(`src/Plugin/Field/FieldType/ChangeRequestCountItemList.php`) to managed node bundles, exposing
the number of change requests referencing the node (used for the tab badge and configurable on the
node display).
