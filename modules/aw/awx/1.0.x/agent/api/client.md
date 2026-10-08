<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `awx.awx_client` service (AwxClient)

Class `Drupal\awx\Service\AwxClient` (`src/Service/AwxClient.php`). Registered in
`awx.services.yml` as service id **`awx.awx_client`** with `autowire: true`, plus an alias from
the FQCN `Drupal\awx\Service\AwxClient` to that id — so you can type-hint either.

## Install & enable

```bash
composer require drupal/awx
drush en awx -y
```

No module dependencies (autowires core `http_client`, `config.factory`, `logger.factory`). Then
configure `/admin/config/services/awx` — see [../config/settings.md](../config/settings.md).

## Inject and call

```php
public function __construct(
  private readonly \Drupal\awx\Service\AwxClient $awxClient,
) {}

// Preferred: launch by unique template name (ID resolved automatically).
$job_id = $this->awxClient->createJobFromTemplateName('Provision customer', [
  'customer_id' => 42,
  'region'      => 'eu-west',
]);

if ($job_id > 0) {
  $url = $this->awxClient->getJobUrl($job_id); // {base}/#/jobs/playbook/{id}
}
else {
  // $job_id is a REQUEST_FAILURE_MODES value (<= 0). Reason already logged to 'awx'.
}
```

`$extra_variables` is passed to AWX as the job's **`extra_vars`** (Guzzle `json` body
`{"extra_vars": {…}}`) — a structured array, never a shell string.

## Public API (signatures from source)

- `createJobFromTemplateName(string $job_template_name, array $extra_variables): int`
  — calls `getJobTemplateIdByName()`; if that is `<= 0` it returns that failure code unchanged,
  otherwise delegates to `createJobFromTemplateId()`. **Use this** unless you already hold the ID
  (AWX assigns IDs per instance and they shift as templates change).

- `createJobFromTemplateId(int $job_template_id, array $extra_variables, string $job_template_name = '(no template name provided)'): int`
  — `protected makeHttpClientRequest()` POSTs to `{url}/api/v2/job_templates/{id}/launch/`. On a
  2xx it decodes the body and returns `(int) $body['id']` (the created **job ID**, logged as a
  `notice`); on non-2xx it logs an `error` and returns `ERROR_CODE_RETURNED` (0); a thrown Guzzle
  exception is caught and returns `UNABLE_TO_SEND` (-1). The optional name is only for log clarity.

- `getJobTemplateIdByName(string $job_template_name): int`
  — GET `{url}/api/v2/job_templates/?name=…`. Non-2xx → `UNABLE_TO_SEND`. Otherwise it re-filters
  `results` client-side with a strict `name === $job_template_name` match: 0 matches →
  `TEMPLATE_NOT_FOUND` (-2), more than 1 → `AMBIGUOUS_NAME` (-3), exactly 1 → `(int) id`. Transport
  exception → `UNABLE_TO_SEND`.

- `getJobUrl(int $job_id): string` — returns `{url}/#/jobs/playbook/{job_id}` (deep link to the
  AWX web UI; no HTTP call).

## Return-value contract — `REQUEST_FAILURE_MODES`

Public const on the class. **Any successful call returns a job/template ID `> 0`; every failure is
`<= 0`.** Always branch on `> 0` rather than truthiness (0 is a failure).

| Constant              | Value | Meaning                                             |
|-----------------------|-------|-----------------------------------------------------|
| `ERROR_CODE_RETURNED` | `0`   | AWX responded with a non-2xx status to the launch.  |
| `UNABLE_TO_SEND`      | `-1`  | Transport/HTTP error (exception, or lookup non-2xx).|
| `TEMPLATE_NOT_FOUND`  | `-2`  | Name lookup matched no template.                    |
| `AMBIGUOUS_NAME`      | `-3`  | Name lookup matched more than one template.         |

## Request behavior (both endpoints)

- Headers: `Authorization: Bearer <auth_token>`, `Accept: application/json`.
- Guzzle options from config: `connect_timeout`, `timeout` (= `response_timeout`),
  `verify` (= `verify_tls`), and `http_errors => FALSE` so 4xx/5xx bodies are logged, not thrown.
- All outcomes are logged to the **`awx`** logger channel (success = `notice`, failures = `error`,
  including the response body on HTTP errors).
