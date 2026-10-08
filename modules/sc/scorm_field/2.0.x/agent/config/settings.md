<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, decoupled mode, entities & permission

## Site settings form

- Route **`scorm_field.settings`** → `/admin/config/system/scorm_field/settings`
  (`SettingsForm extends ConfigFormBase`, `src/Form/SettingsForm.php`).
- Permission: **`administer site configuration`**. Menu link under *Configuration → System*
  (`scorm_field.links.menu.yml`), described as *"Define decoupled mode here."*
- Editable config object: **`scorm_field.settings`** with a single key **`decoupled_access_token`**
  (string). The form's *"Re-Generate token"* AJAX button (`::setToken`) fills the field with
  `bin2hex(random_bytes(8))` (a 16-hex-char shared token); Save persists it.
- This token is the **shared secret** a decoupled front-end must present to the token/attempt REST
  endpoints; `ScormFieldCommonService::validateToken()` does a strict `!==` compare against it.

## Config schema (`config/schema/scorm_field.schema.yml`)

- `scorm_field.settings` (config_object): `decoupled_access_token: string`.
- `scorm_field.scorm_player_settings.*` (config_entity): `id`, `iframe_scrolling`,
  `iframe_responsive` (bool), `iframe_responsive_class`, `iframe_height`, `iframe_width`, `uuid`.
- `node.type.*.third_party.scorm_field` (mapping): `iframe_responsive` (bool),
  `iframe_responsive_class`, `iframe_width`, `iframe_height`, `iframe_scrolling`,
  `hidden_elements` (sequence of strings).

## Per content-type iframe settings

`scorm_field_form_node_type_edit_form_alter()` adds a *"Scorm settings"* group to the node-type
edit form (only for bundles that actually have a `scorm_field_scorm_package` field, detected by
`ScormFieldCommonService::scormFieldAvailable()`). Fields: `iframe_responsive`,
`iframe_responsive_class` (`responsive--iframe-default` = 1:1 in %, `responsive--iframe-dvh` = 1:1
in dvh), `iframe_width`, `iframe_height`, `iframe_scrolling` (auto/yes/no), `hidden_elements`.
Saved as node-type third-party settings by `scorm_field_form_node_type_edit_form_builder()`.

Per **node**, `scorm_field_form_alter()` adds the same controls to the node add/edit form (stored
via `ScormFieldCommonService::setScormFieldSettings()` into a `scorm_field_settings` entity keyed
by node id) plus, for users with the reset permission, a *"Reset scorm data"* AJAX button.

## Permission

`scorm_field.permissions.yml` defines one permission:

- **`scorm field reset scorm data`** — *"Reset scorm cmi and report data."* Users who hold it get
  the AJAX *Reset scorm data* button on the node form; the callback
  (`scorm_field_remove_scorm_data`) calls `ScormFieldScorm::removeScormData($node)` which deletes
  `scorm_field_scorm_cmi_data` rows for the node and removes `scorm_report` entities for it.

## Entities

- **`scorm_field_settings`** (`src/Entity/ScormFieldSettings.php`, iface `ScormFieldSettingsInterface`)
  — stores per-node iframe/player settings; `getIframeResponsive()`, `getIframeScrolling()`, etc.
- **`scorm_player_settings`** (`src/Entity/ScormPlayerSettings.php`, config entity + its own
  `ScormPlayerSettingsForm`) — reusable player-settings config entities.
- **`scorm_report`** (`src/Entity/ScormReport.php`, iface `ScormReportInterface`) — a learner's
  score/status record for a node (uid, nid, score_raw/min/max, status, ip, session_uuid, created,
  changed). Written by `ScormFieldCommonService::saveScormReport()`; uniqueness enforced by the
  `ScormReportUnique` / `ScormReportUniqueByUser` validation constraints.

## Decoupled mode (overview)

Enable by generating the `decoupled_access_token`, then have the front-end call the REST endpoints
(next doc) to obtain a one-time iframe URL for `/scorm-field-decoupled/{node}/{token}`. That route
is served under the **Stark** theme with page chrome stripped
(`ThemeNegotiator` service `theme.negotiator.scorm_field`, priority -50, only for the decoupled
route; plus `hook_preprocess_page` / `hook_theme_suggestions_*_alter` that swap in the
`*__scorm_player__decoupled` templates). The README recommends installing
`x_frame_options_configuration` so the backend can be iframed from another domain. See
[../api/routes-services.md](../api/routes-services.md) for the endpoints and access model.
