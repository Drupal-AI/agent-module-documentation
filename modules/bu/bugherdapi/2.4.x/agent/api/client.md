<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BugHerd REST API v2 client — `bugherdapi.client`

Service **`bugherdapi.client`** → `Client\BugherdClient` (aliased to the class name for autowiring).
Constructor args: `@http_client` (Guzzle), `@config.factory`, `@logger.channel.bugherdapi`. A
server-side wrapper over the BugHerd REST API v2, base URI `https://www.bugherd.com/api_v2/`.

Get it via `\Drupal::service('bugherdapi.client')` or inject
`Drupal\bugherdapi\Client\BugherdClient`.

## Authentication

- Uses the **personal API key** from `bugherdapi.settings.api_key` (read live through
  `config.factory`, so a `settings.php` override is honored). `getApiKey()` trims it; empty → every
  request throws.
- Sent as HTTP Basic auth `['auth' => [$apiKey, 'x']]` (BugHerd wants the key as username, ignores
  the password) over HTTPS. Guzzle default TLS verification applies (not disabled).
- `hasApiKey(): bool` — check before calling. `verifyApiKey(string $apiKey): array` — temporarily
  overrides the key (`$apiKeyOverride`) and calls `getOrganization()` to validate a candidate key;
  used by the settings form.

## Methods (all throw `BugherdApiException` on failure)

- **Organization/users:** `getOrganization()`, `getUsers()`, `getMembers()`, `getGuests()`.
- **Projects:** `getProjects(bool $activeOnly = FALSE)`, `getProject($id)`, `createProject($values)`,
  `updateProject($id, $values)`, `deleteProject($id)`.
- **Tasks:** `getTasks($projectId, array $filters = [])` (filters e.g. `status`, `priority`, `tag`,
  `external_id`, `updated_since`, `created_since`), `getTask($projectId, $taskId)`,
  `createTask($projectId, $values)` (`description` required), `updateTask($projectId, $taskId, $values)`.
- **Comments:** `getComments($projectId, $taskId)`,
  `createComment($projectId, $taskId, string $text, $userId = NULL)`.
- **Webhooks:** `getWebhooks()`, `createWebhook(string $targetUrl, string $event, $projectId = NULL)`,
  `deleteWebhook($webhookId)`.

Path IDs are `urlencode()`d. Bodies are sent as `json`. `GET`/`POST`/`PUT`/`DELETE` per method.

## Request internals

- `request($method, $path, ?array $body, array $query)` builds the Guzzle options (`auth`,
  `Accept: application/json`, `timeout: 30`, optional `query`/`json`), calls
  `$httpClient->request()`, and decodes JSON with `JSON_THROW_ON_ERROR`. Empty body → `[]`.
- `requestAll($path, $key, $query)` pages through listing endpoints: reads `meta.count`, divides by
  `PER_PAGE = 100`, and fetches pages 2..N, merging `$response[$key]`. Listing methods use this.
- Errors: `ConnectException` and `RequestException` are logged to `logger.channel.bugherdapi` and
  re-thrown as `BugherdApiException`. `describeError()` maps 401/403 → "rejected the API key",
  404 → "resource does not exist", 429 → "rate limit … about 60 requests per minute", else the
  Guzzle message. (Log messages carry the path/message, not the API key.)

## `Exception\BugherdApiException`

Extends `\RuntimeException`. Carries the HTTP status (`getStatusCode()`), with
`isAuthenticationError()` (401/403) and `isRateLimitError()` (429) helpers.

```php
$client = \Drupal::service('bugherdapi.client');
if ($client->hasApiKey()) {
  try {
    $tasks = $client->getTasks($project_id, ['status' => 'backlog']);
    $task = $client->createTask($project_id, ['description' => '500 on contact form']);
  }
  catch (\Drupal\bugherdapi\Exception\BugherdApiException $e) {
    if ($e->isRateLimitError()) { /* back off */ }
  }
}
```

Unit test: `tests/src/Unit/BugherdClientTest.php`.
