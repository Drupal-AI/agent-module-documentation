<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWX / Ansible Tower Client (awx) — agent index

A lightweight, autowired Drupal **service** that launches **AWX / Ansible Tower** job templates
over the REST API. It has **no job-launch UI or route** — consuming code injects the service and
calls it. Package `Web services`. Core `^10 || ^11`. License GPL-2.0-or-later. Version
**1.0.0-alpha3** (version dir `1.0.x`). **No module dependencies** (only core services), no
submodules, no permissions of its own, no Drush, no plugin types.

- **The service API — launch by name/ID, ID resolution, failure modes, job URL** →
  [api/client.md](api/client.md)
- **The settings form, `awx.settings` config object + schema, token handling** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service: **`awx.awx_client`** → `Drupal\awx\Service\AwxClient`
  (`src/Service/AwxClient.php`), also aliased to its FQCN for autowiring
  (`awx.services.yml`). Constructor autowires the core `http_client` (Guzzle), `config.factory`,
  and `logger.factory`; it reads config object `awx.settings` and logs to the `awx` channel.
- One route/form: **`awx.settings`** at `/admin/config/services/awx`
  (`awx.routing.yml` → `Drupal\awx\Form\AwxSettingsForm`), requirement
  `_permission: 'administer site configuration'`. Menu link under
  *Configuration → Web services* (`awx.links.menu.yml`).
- Config: object **`awx.settings`** (`config/install/awx.settings.yml`), schema in
  `config/schema/awx.schema.yml`. Keys: `url`, `auth_token`, `verify_tls` (default **true**),
  `connect_timeout` (5), `response_timeout` (10).

## Public methods (from source)

- `createJobFromTemplateName(string $name, array $extra_variables): int` — resolves the ID from
  the name, then launches. Returns the new **job ID** (>0) or a `REQUEST_FAILURE_MODES` value.
- `createJobFromTemplateId(int $id, array $extra_variables, string $name = '…'): int` — POSTs to
  `/api/v2/job_templates/{id}/launch/` with `extra_vars`; returns the job ID or a failure code.
- `getJobTemplateIdByName(string $name): int` — GET `/api/v2/job_templates/?name=…`, exact-matches
  client-side; returns the ID, or `TEMPLATE_NOT_FOUND` / `AMBIGUOUS_NAME` / `UNABLE_TO_SEND`.
- `getJobUrl(int $job_id): string` — builds `{url}/#/jobs/playbook/{id}` for the AWX web UI.
- `REQUEST_FAILURE_MODES` (public const): `ERROR_CODE_RETURNED` 0, `UNABLE_TO_SEND` -1,
  `TEMPLATE_NOT_FOUND` -2, `AMBIGUOUS_NAME` -3. **Success is always > 0.**

## Mechanism notes

- All requests set `Authorization: Bearer <auth_token>`, `Accept: application/json`,
  `http_errors => FALSE` (so 4xx/5xx are inspected/logged, not thrown), and pass Guzzle
  `connect_timeout`, `timeout`, and `verify` from config.
- `extra_variables` is sent as the Guzzle `json` body `{"extra_vars": {…}}` — a structured array,
  **not** string-concatenated onto a command line.
- The launch endpoint returns 201 with the full job object; the client reads `id` as the job ID.
