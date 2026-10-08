<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Status — service API

Service id `api_status.tracker` (`ApiStatusServiceInterface`).

```php
$tracker = \Drupal::service('api_status.tracker');

// After a successful call:
$tracker->log('stripe', 'success', '/v1/charges');
// After a failure:
$tracker->log('stripe', 'failed', '/v1/charges');

// Read health:
$status = $tracker->getStatus('stripe');
// ['last_success' => <timestamp|null>, 'last_failure' => <timestamp|null>, ...]
```

- `log(string $api_key, string $status, ?string $endpoint = NULL): bool` — `$status` must be `success` or `failed` (else returns FALSE). Stores `api_status.{status}.{api_key}` and, if given, `api_status.endpoint.{api_key}`; adds `$api_key` to the `api_status.tracked` list.
- `getStatus(string $api_key): array` — last success/failure timestamps for an API.

All state lives under the `api_status.*` State keys — no database table. The dashboard (`/admin/reports/api-status`) renders the tracked list with last success/failure and endpoint.
