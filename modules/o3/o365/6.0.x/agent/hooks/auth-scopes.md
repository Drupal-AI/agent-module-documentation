# Hook: hook_o365_auth_scopes()

The module invokes one hook (`o365.api.php`) so other modules can add the Microsoft Graph
authorization scopes their integration needs.

```php
/**
 * @param string[] $scopes
 *   Scopes collected so far — modify by reference.
 * @param \Drupal\o365\O365ConnectorInterface $connector
 *   The connector being authorized.
 */
function hook_o365_auth_scopes(array &$scopes, \Drupal\o365\O365ConnectorInterface $connector) {
  $scopes[] = 'Mail.Read';
  $scopes[] = 'Calendars.ReadWrite';

  if ($connector->id() === 'default') {
    $scopes[] = 'Files.Read.All';
  }
}
```

## How the scope list is assembled

`HelperService::getAuthScopes(?O365ConnectorInterface $connector, bool $asArray = FALSE)`:

1. Starts from the connector entity's `auth_scopes` field (space-separated), or `[]` if no connector.
2. `\Drupal::moduleHandler()->invokeAll('o365_auth_scopes', [&$scopes, $connector])` lets every
   implementation append scopes.
3. De-duplicates, drops empties, and **always adds `offline_access`** (needed to obtain a refresh
   token).
4. Returns a space-separated string (or an array when `$asArray` is TRUE).

The parent module's own implementation `o365_o365_auth_scopes()` (`o365.module`) always adds
`openid`, `offline_access`, `email`, `User.Read`. Submodules add their own (e.g. mail, calendar).
The effective, merged set is shown at `/admin/reports/o365-auth-scopes`
(`O365AuthScopesController`). Note: `invokeAll` here does not pass a connector to the report call,
so `$connector` may be `NULL` in that context — guard for it.
