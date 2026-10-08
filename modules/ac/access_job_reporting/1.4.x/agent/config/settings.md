<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config — access_job_reporting

Covers the site-wide settings form, the config object/schema, the Key-module integration, and the
resource-name fetcher. Source: `src/Form/AccessJobReportingForm.php`,
`src/AccessResourceFetcher.php`, `config/schema/access_job_reporting.schema.yml`,
`config/install/access_job_reporting.settings.yml`.

## Install / enable

```
composer require drupal/access_job_reporting
drush en access_job_reporting -y
```

Pulls in `tapis_job` + `tapis_system` (and their deps). Optional: `drush en key -y` to store the
API secret as a Key entity. Cron must run to drain the report queue.

## Route & access

- Route id **`access_job_reporting.settings`**, path **`/admin/config/access/job-reporting`**,
  `_form: \Drupal\access_job_reporting\Form\AccessJobReportingForm`,
  `requirements: _permission: "administer site configuration"`
  (`access_job_reporting.routing.yml`). Menu link parented under `system.admin_config_services`
  (`access_job_reporting.links.menu.yml`). This is the **only** route the module defines.

## Config object `access_job_reporting.settings`

`AccessJobReportingForm` extends `ConfigFormBase`; `getEditableConfigNames()` and
`getFormId()` = `access_job_reporting_settings_form`. Schema keys
(`config/schema/access_job_reporting.schema.yml`):

| key | type | form field | default | meaning |
|---|---|---|---|---|
| `endpoint_url` | string | textfield | ACCESS prod `.../v2/job_attributes` | ACCESS job_attributes endpoint |
| `api_key` | string | textfield (fallback) | — | raw API key (used only when Key not selected) |
| `agent_name` | string | textfield (required) | — | `XA-AGENT` header value |
| `debug_mode` | boolean | checkbox | FALSE | dry-run: worker logs payload, does not POST |
| `retry_interval` | integer | number | 86400 | seconds between retries |
| `max_attempts` | integer | number | 15 | max delivery attempts before giving up |

Note: `api_key_key` (the selected Key id) is written by the form but is **not** declared in the
schema mapping — a schema gap, harmless at runtime. Per-`tapis_system` state
(`systems.<nid>.enabled`, `systems.<nid>.resource_map`) also lives in this object but is written by
the node-form handlers (see [../api/reporting-pipeline.md](../api/reporting-pipeline.md)), not this
form, and is likewise not in the schema.

## Key-module integration (`buildForm`/`submitForm`)

- If `key` is enabled **and** at least one Key entity exists, the form shows a **`api_key_key`**
  `select` of Key labels (required) instead of a raw text field; description notes the secret is
  never stored in module config. `submitForm()` writes `api_key_key` and **clears** `api_key`.
- Otherwise it shows the plain **`api_key`** textfield (required) and stores the secret directly in
  config; `api_key_key` is cleared.
- At delivery time both `AccessResourceFetcher::fetch()` and `AccessJobQueueWorker::processItem()`
  prefer the Key value: if `key` is enabled and `api_key_key` is set, they call
  `key.repository->getKey($name)->getKeyValue()` and use it, falling back to the config `api_key`
  on any failure.

## Resource fetcher (`AccessResourceFetcher::fetch()`)

- Reads `endpoint_url` (default
  `https://allocations-api.access-ci.org/acdb/gateway/v2/job_attributes`) and the API key
  (Key-preferred, as above) plus `agent_name`.
- Guzzle **POST** with `headers` `XA-API-KEY`/`XA-AGENT`, `form_params
  {xsederesourcename: 'unknown'}`, `http_errors => FALSE`, `timeout => 10`. Default Guzzle TLS
  verification is left on (no `verify => false`).
- `parseSuggestedResources()` scans the response body for a line containing
  `Did you mean one of these?` then collects the following non-empty lines until a blank or `*`
  line. If none, logs a notice and returns the `FALLBACK_RESOURCES`
  (`expanse.sdsc.xsede.org`, `bridges2.psc.xsede.org`).
- The form's **"Reload ACCESS Resources"** AJAX button (`ajaxFetchResources()`) re-runs the fetch
  and fills the disabled `resource_list` textarea (a read-only reference list; its `#value` is set,
  not markup — no XSS surface).

## Operate

1. Visit `/admin/config/access/job-reporting`; set endpoint, API key (Key entity preferred),
   `XA-AGENT`, retry interval, max attempts. Toggle **debug mode** on staging.
2. Per system: edit each `tapis_system` node, open the *ACCESS Job Reporting* fieldset, check
   *Report to ACCESS*, and fill the resource map — see
   [../api/reporting-pipeline.md](../api/reporting-pipeline.md).
3. Ensure cron runs; watch the `access_job_reporting` logger channel for delivery status.
