# The HTTP 40x client-error Condition plugin

`src/Plugin/Condition/HttpClientErrorStatus.php`, id `http_client_error_status`, label "HTTP 40x Client
error status code". Extends `ConditionPluginBase`. There is no admin settings page of the module's own
(`configure` is null); you configure the condition wherever conditions are consumed — usually a block.

## Settings (schema `condition.plugin.http_client_error_status`)

| Key | Type | Default | Checkbox label |
|---|---|---|---|
| `request_401` | boolean | `0` | Display on 401 page |
| `request_403` | boolean | `0` | Display on 403 page |
| `request_404` | boolean | `0` | Display on 404 page |
| `negate` | boolean | `0` | (inherited) invert the result |

## How it evaluates

`evaluate()` gets the current request and reads its `exception` attribute
(`$request->attributes->get('exception')`); for each enabled checkbox it returns `TRUE` when
`$exception->getStatusCode()` equals 401/403/404. `summary()` renders e.g. "Return true on the following
client error pages: 403, 404" (or "Do not return true…" when negated). `getCacheContexts()` adds
`url.path`.

## Use it on a block

*Administration › Structure › Block layout* → place/edit a block → the **"HTTP 40x Client errors"**
vertical tab → tick the error pages the block should show on. Persists in the block's
`visibility.http_client_error_status` config. Example (Drush):

```php
// show an existing block only on 403 + 404 pages
$block = \Drupal::entityTypeManager()->getStorage('block')->load('mytheme_helpblock');
$block->setVisibilityConfig('http_client_error_status', [
  'id' => 'http_client_error_status',
  'negate' => FALSE,
  'request_401' => FALSE,
  'request_403' => TRUE,
  'request_404' => TRUE,
]);
$block->save();
```

## Relationship to core `response_status` (3.1.x migration)

Core ships a `response_status` block condition covering 403/404/200 — but **not 401**. This module
predates/extends that and 3.1.x provides a manual upgrade path:

- Listing page `admin/config/development/http-client-error-status` (route
  `http_client_error_status.block_listing`, permission `administer http_client_error_status
  configuration`) tables every block using this condition, its 401/403/404/negate flags, and a
  **"Potential Conflict"** = the block already has BOTH this condition and `response_status`.
- `Main::convertCondition()` maps a subset of {403,404,negate} combinations to a `response_status`
  config (403; 404; 200; 200+403; 200+404; 403+404). `Main::remainingCondition()` keeps `request_401`
  on this plugin (core cannot express 401) and zeroes the rest. Blocks flagged as a conflict are
  **skipped**.
- Run the conversion with `drush hces:update` — see [../drush/commands.md](../drush/commands.md).
  README advises testing + deploying the resulting config rather than converting directly on prod.

## Permission

`administer http_client_error_status configuration` (`http_client_error_status.permissions.yml`) — gates
only the listing/migration page. It is a low-impact read/migrate-helper permission (not
`restrict access: true`); it does not itself change block visibility (the Drush `update`/`remove`
commands do that).
