# API: GraphService — call the Microsoft Graph API

Service id **`o365.graph`** → `Drupal\o365\GraphService` (`src/GraphService.php`). This is the
module's core developer surface: a thin wrapper over the `microsoft/microsoft-graph` SDK
(`Microsoft\Graph\Graph`) that injects the current user's access token and returns the parsed
response. Inject `@o365.graph`.

## Access guard

`getGraphData()`/`sendGraphData()` first check the externalauth authmap: if the current user is
**authenticated but not linked to `o365_sso`**, they return `[]` (no Graph call). Anonymous users
and Microsoft-linked users proceed. The access token itself is resolved by
`AuthenticationService::getAccessToken()` from the private tempstore (delegated token).

## Methods

```php
// Read. $type is an HTTP verb; $version like 'beta' switches API version.
$graph->getGraphData(
  string $endpoint,           // e.g. '/me', '/me/messages'
  string $type = 'GET',
  bool   $raw = FALSE,        // TRUE => return raw body instead of decoded
  bool|string $version = FALSE,   // e.g. 'beta'
  bool|string $returnType = FALSE, // a Graph model class to hydrate into
  array  $headers = []
): mixed;

// Write. POST/PUT/PATCH attach $data as body; $type='UPLOAD' does a PUT upload($data).
$graph->sendGraphData(
  string $endpoint,
  mixed  $data = [],
  string $type = 'POST',
  bool   $raw = FALSE,
  bool|string $version = FALSE,
  bool|string $returnType = FALSE,
  array  $headers = []
): mixed;

// Paged collections -> a Microsoft\Graph\Http\GraphCollectionRequest (or FALSE).
$graph->getCollectionData(string $endpoint, bool|string $returnType = FALSE, bool|string $version = FALSE);

// The externalauth id (Microsoft object id) of the current user, or FALSE.
$graph->getCurrentUserId();

// Per-instance request timeout (default 1000).
$graph->getTimeout(); $graph->setTimeout(int $timeout);
```

## Behavior notes

- Return value of `getGraphData`/`sendGraphData` is the SDK response body (`getBody()`), or the raw
  body when `$raw` is TRUE, or a hydrated model when `$returnType` is a Graph model class.
- Errors: a `GuzzleHttp\Exception\ClientException` is caught, logged to the `o365` channel, and the
  method returns `FALSE` — so callers should check for `FALSE`/empty. (The "profile image not found"
  Graph error is intentionally swallowed without logging.)
- `$version = 'beta'` targets the Graph beta endpoint; otherwise the SDK default (v1.0) is used.

## Examples

```php
$graph = \Drupal::service('o365.graph');

// Current user profile.
$me = $graph->getGraphData('/me?$select=displayName,mail,jobTitle');

// Latest 10 unread messages.
$mail = $graph->getGraphData("/me/mailFolders/inbox/messages?\$filter=isRead eq false&\$top=10");

// Create a calendar event.
$graph->sendGraphData('/me/events', [
  'subject' => 'Kickoff',
  'start' => ['dateTime' => '2026-09-01T09:00:00', 'timeZone' => 'UTC'],
  'end'   => ['dateTime' => '2026-09-01T10:00:00', 'timeZone' => 'UTC'],
], 'POST');

// Page through a collection.
$request = $graph->getCollectionData('/me/messages');
if ($request) {
  while (!$request->isEnd()) {
    foreach ($request->getPage() as $message) { /* … */ }
  }
}
```

The Graph scopes your calls need must be present in the connector's `auth_scopes` or added via
[`hook_o365_auth_scopes()`](../hooks/auth-scopes.md); check the effective set at
`/admin/reports/o365-auth-scopes`.
