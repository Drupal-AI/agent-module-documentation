<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Insight Lab — content entities

Seven `@ContentEntityType`s in `src/Entity/`, each `base_table` = its id, each `admin_permission = "administer site configuration"`, no bundles, no UI form/list route wired for content (managed entirely through the JSON API and the React SPA). Schema is installed by `hook_update_N` (`api_insight_lab_update_8001/8002/9001`) and every table is emptied in `api_insight_lab_uninstall()`.

## api_test_config — presets (`ApiTestConfig`)
Fields: `name` (label, string), `url` (string), `method` (string), `config_json` (text_long — full request config as JSON), `group_id` (string, default from `detectGroupFromUrl`), `created`, `changed`. Assertions link back to a preset by matching `config_id` to the preset id.

## api_assertion — assertions (`Assertion`)
Fields: `id` (integer), `config_id` (string → preset id), `assertion_type` (string: status_code|response_time|json_path|header), `field_path` (string — header name or JSONPath), `operator` (string), `expected_value` (string_long), `enabled` (boolean), `created`. Saved in bulk per preset by `ApiTestController::saveAssertions` (deletes then recreates).

## api_snapshot — response snapshots (`ApiSnapshot`)
Label = `snapshot_name`. Fields: `config_id`, `snapshot_name`, `version_number` (integer, auto-increment per config_id), `request_config` (string_long JSON), `response_body` (string_long), `response_headers` (string_long JSON), `status_code` (integer), `response_time` (integer, ms), `performance_metrics` (string_long JSON), `notes` (string_long), `created`. Compared by `compareSnapshots`/`calculateDiff`.

## environment_profile — environments (`EnvironmentProfile`)
Fields: `name`, `base_url` (string), `variables` (string_long JSON — key/value pairs used for `{{VAR}}` templating), `is_active` (boolean — only one active at a time, enforced by `setActiveEnvironment` clearing others), `color` (string: green|yellow|red|blue|gray), `created`, `changed`.

## request_chain — chains (`RequestChain`)
Fields: `name`, `description` (string), `steps_json` (text_long — array of steps, each with url/method/headers/body/auth/extractions/assertions/stopOnError), `created`, `changed`. Executed by `runChain`; extractions feed `{{variableName}}` substitution in later steps.

## api_perf_result — run summaries (`TestResult`)
Fields: `url`, `method`, `status` (integer), `duration` (float), `avg_time` (float), `total_requests` (integer), `error_count` (integer), `created`. Written automatically by `runTest` after each load test.

## api_perf_setting — legacy setting (`ApiSetting`)
Fields: `api_id` (string), `default_params` (map), `notes` (text_long), `created`, `changed`. Present in schema/uninstall list but not written by any current controller path.
