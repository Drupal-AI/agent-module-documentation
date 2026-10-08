<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scorm field (scorm_field) — agent index

A **SCORM package field type + iframe player** for Drupal nodes. Upload a SCORM ZIP to a field;
the module extracts it into `public://`, parses `imsmanifest.xml`, and renders a SCORM 1.2 / 2004
player that tracks CMI/score/completion per learner. Package `Field types`. Core
`^10.2 || ^11`. License GPL-2.0-or-later. Installed version 2.0.1.

- **The field type, widget, formatters and extraction pipeline** → [fields/scorm-field.md](fields/scorm-field.md)
- **Settings, decoupled mode, config objects/schema, node-type settings, permission** → [config/settings.md](config/settings.md)
- **Routes, controllers, REST resources, services, DB tables, hooks** → [api/routes-services.md](api/routes-services.md)

## Dependency

- Hard dependency on **`attempt_mgmt`** (`drupal/attempt_mgmt:1.0.x-dev@dev`) — provides the
  `attempt_mgmt.factory` service and the `attempt_mgmt_attempt` entity the module extends with a
  `scorm` attempt type + `field_score_raw/min/max` / `field_scorm_status` fields (installed in
  `scorm_field_update_10200()` and `config/install/`).
- The `@RestResource` plugins additionally need core **`rest`** enabled to be reachable.

## What it provides (from source)

- **Field type** `scorm_field_scorm_package` (`ScormFieldScormPackage extends FileItem`), default
  widget `file_generic` (registered via `hook_field_widget_info_alter`), default formatter
  `scorm_field_scorm_formatter`. Item list `ScormFieldScormPackageItemList` triggers extraction on save.
- **Formatters** `scorm_field_scorm_formatter` (`ScormFieldScormFormatter`) and the legacy
  `scorm_field_field_formatter` (`ScormFieldFieldFormatter`, targets a non-existent
  `scorm_field_package` type — effectively dead).
- **Services**: `scorm_field.scorm` (`ScormFieldScorm` — unzip/parse/persist), `scorm_field.scorm_player`
  (`ScormFieldScormPlayer` — build render array + SCO tree), `scorm_field.common_service`
  (`ScormFieldCommonService` — reports, tokens, settings, session id), `scorm_field.report_views_access`
  (Views access check), `theme.negotiator.scorm_field` (`ThemeNegotiator` — Stark for decoupled route).
- **Routes** (`scorm_field.routing.yml`): `scorm_sco`, `scorm_commit`, `scorm_reset`, `decoupled`,
  `settings`. **REST resources**: access-token, create-attempt, report, scorm-data, start-sco.
- **Entities**: `scorm_field_settings`, `scorm_player_settings` (config entity), `scorm_report`
  (content entity). Plus DB tables `scorm_field_scorm_packages`, `_package_scos`,
  `_package_sco_attributes`, `scorm_field_scorm_cmi_data`, `scorm_field_token_access`.
- **Permission**: `scorm field reset scorm data`. **Config**: object `scorm_field.settings`
  (`decoupled_access_token`); config entity `scorm_field.scorm_player_settings.*`; node-type
  third-party settings `node.type.*.third_party.scorm_field`. **Views**: `scorm_attempts`,
  `scorm_report_per_node` (config/optional).
- **Plugin**: `AttemptProcessing/AttemptScorm` (attempt_mgmt plugin). **Validation constraints**:
  `ScormPackage`, `ScormReportUnique`, `ScormReportUniqueByUser`.

## Extraction model (core mechanic)

`ScormFieldScormPackageItemList::postSave()` → `ScormFieldScorm::scormExtract($file)` →
`unzipPackage()` does `(new \ZipArchive)->extractTo('public://scorm_field_extracted/scorm_<fid>')`,
then `scormExtractManifestData()` parses `imsmanifest.xml` via `XML2Array` (expat, no XXE) and
`scormSave()`/`scormScoSave()` write the SCO tree to the DB. The player serves the launch SCO by
redirecting `/scorm-field-scorm/player/sco/{id}` to the extracted file URL under `public://`.
