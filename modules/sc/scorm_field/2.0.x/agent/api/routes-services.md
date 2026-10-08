<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controllers, REST resources, services, DB tables & hooks

## Routes (`scorm_field.routing.yml`)

| Route id | Path | Controller / form | Access requirement |
|---|---|---|---|
| `scorm_field.scorm_sco` | `/scorm-field-scorm/player/sco/{scorm_sco}` | `ScormFieldScormController::scormIntegrateSco` | `_access: 'TRUE'` |
| `scorm_field.scorm_commit` | `/scorm-field-scorm/scorm/{scorm_id}/{scorm_sco_id}/{nid}/commit` | `ScormFieldScormController::scormCommit` | `_access: 'TRUE'` |
| `scorm_field.scorm_reset` | `/scorm-field-scorm/reset/{nid}` | `ScormFieldScormResetMaterialController::scormReset` | `_access: 'TRUE'` |
| `scorm_field.decoupled` | `/scorm-field-decoupled/{node}/{token}` | `ScormFieldDecoupledController::buildScormPlayer` | `_custom_access: …::access` (custom theme `stark`) |
| `scorm_field.settings` | `/admin/config/system/scorm_field/settings` | `SettingsForm` | `_permission: 'administer site configuration'` |

- **`scormIntegrateSco($scorm_sco)`** — loads the SCO, builds the file location
  `"{$scorm->extracted_dir}/{$launch}"`, generates its absolute URL and returns a
  `TrustedRedirectResponse` to that public file (the iframe target). Launch path comes from the
  stored SCO `launch` (from the manifest), not from the request.
- **`scormCommit($scorm_id,$scorm_sco_id,$nid)`** — reads the JSON POST body
  (`$GLOBALS['request']->getContent()` / `$_POST['data']`), determines status/score for
  SCORM 1.2 vs 2004, invokes `hook_scorm_field_scorm_commit` (persists CMI data via
  `scorm_field_scorm_cmi_set()`), and updates the attempt via `attempt_mgmt.factory`. Optionally
  attributes to a `decoupled_uid` from the body.
- **`scormReset($nid)`** — deletes `scorm_field_scorm_cmi_data` rows for the node.
- **`ScormFieldDecoupledController::buildScormPlayer($node,$token)`** — finds the node's scorm
  field, loads the package, and renders `toRendarableArrayDecoupled()`; reads `?uid`, `?attempt`,
  `?attempt_uuid` from the query. `getTitle()` returns the node title. `access()` looks the token
  up via `ScormFieldCommonService::getTokenFromDB()` (one-time; removed on use).

## REST resources (`src/Plugin/rest/resource/`, need core `rest` enabled + resource config)

| Plugin id | URI | Method | Purpose |
|---|---|---|---|
| `scorm_decoupled_access_token_resource` | `/api/scorm-field-scorm-get-access-token/{token}/{node_id}/{user_id}` | GET | Validate the shared `decoupled_access_token`; on success generate a one-time access token (`saveTokenIntoDB`), resolve last attempt via `attempt_mgmt.factory`, and return the `iframe_source` decoupled URL + attempt config. |
| `scorm_decoupled_create_attempt_resource` | `/api/scorm-field-scorm-create-attempt` | POST | Validate token, `attempt_mgmt.factory->createAttempt()`, return a fresh one-time token + `iframe_source` (`?attempt=new`). |
| `scorm_field_scorm_report` | `/api/scorm-field-scorm-report/{id}` (GET) / `…/scorm-field-scorm-report` (POST) | GET | Return `scorm_report` records for a node id; access via `checkViewReportAccess()` (node `update` access) or `checkViewMyReportAccess()` (own, node `view`). Optional `?user_uuid=` filter. |
| `scorm_data_resource` | `/api/scorm-data/{user_id}` | GET | Return `{nid: bool}` completion map for a user UUID; requires `?nids=[…]`. |
| `scorm_field_scormstartsco` | `/api/scorm-field-scormstartsco/{fid}` | GET | Return the start SCO id for a package file id. |

These are standard `@RestResource` plugins — reachability and method access are governed by the
`rest` module's resource configuration and REST permissions once enabled.

## Services (`scorm_field.services.yml`)

- **`scorm_field.scorm`** → `ScormFieldScorm` — unzip, manifest parse, SCO persistence, load-by-file,
  `removeScormData(Node)`. Args: `@database`.
- **`scorm_field.scorm_player`** → `ScormFieldScormPlayer` — build player render arrays, SCO tree,
  start-SCO. Args: `@database`, `@scorm_field.scorm`, `@current_user`, `@entity_type.manager`,
  `@module_handler`, `@attempt_mgmt.factory`.
- **`scorm_field.common_service`** → `ScormFieldCommonService` — reports (`saveScormReport`,
  `getScormReportByNodeId`, `getScormDataForGivenNids`), access checks, token DB helpers
  (`generateToken`/`saveTokenIntoDB`/`getTokenFromDB`/`removeTokenFromDB`/`validateToken`),
  per-node settings, `getSessionIDForUnauthenticatedUsers()`. Args: `@entity_type.manager`,
  `@current_user`, `@entity_field.manager`.
- **`scorm_field.report_views_access`** → `Access\ScormFieldReportViewsAccessCheck` — tagged
  `access_check` (`_scorm_field_report_views_access_check`); used by the `ScormFieldReportAccess`
  Views access plugin (grants when the user has node `update` on a scorm node).
- **`theme.negotiator.scorm_field`** → `Theme\ThemeNegotiator` — forces Stark on the decoupled route.

## Database tables (`scorm_field.install`, `hook_schema`)

- `scorm_field_scorm_packages` (id, fid, extracted_dir, manifest_file, manifest_id, metadata).
- `scorm_field_scorm_package_scos` (id, scorm_id, organization, identifier, parent_identifier,
  launch, type, scorm_type, title, weight).
- `scorm_field_scorm_package_sco_attributes` (id, sco_id, attribute, value, serialized).
- `scorm_field_scorm_cmi_data` (uid, scorm_id, cmi_key, value, serialized, user_session_id, nid) —
  per-learner CMI storage; PK (uid, scorm_id, cmi_key, user_session_id).
- `scorm_field_token_access` (id, access_token, token_type, expired) — one-time decoupled tokens.

All dropped in `scorm_field_uninstall()`. `scorm_field_update_10200()` installs the
`scorm_field_settings` entity + the `scorm` attempt type and score/status fields on
`attempt_mgmt_attempt`. `scorm_field_update_last_removed()` returns 8910.

## Hooks & plugins

- CMI model hooks: `hook_scorm_field_scorm_register_cmi_paths($version)`,
  `hook_scorm_field_register_cmi_data($scorm,$scos,$version,$account)` (+ their `_alter`), and
  `hook_scorm_field_scorm_commit($scorm,$sco_id,$nid,$data,$uid)` — the module implements all three
  itself in `scorm_field.module` to define the SCORM 1.2 / 2004 data models and persist commits.
- attempt_mgmt hooks: `hook_attempt_mgmt_new_attempt` / `hook_attempt_mgmt_force_new_attempt`
  (reset SCORM data on new attempts); plugin `AttemptProcessing/AttemptScorm`.
- Views: `scorm_field.views.inc` (`hook_views_data`), Views `scorm_attempts` and
  `scorm_report_per_node` (`config/optional/`), Views access plugin
  `Plugin/views/access/ScormFieldReportAccess`.
- `hook_page_attachments` attaches the `scorm-field-scorm-ios-13` library site-wide (iOS 13 SCORM fix).
