# Hooks (`oauth2_server.api.php`)

All are invoked from `OAuth2Storage`/controller during authorization/claim building.

| Hook | Signature | Use |
|---|---|---|
| `hook_oauth2_server_pre_authorize()` | `()` | Fires at the top of the authorize endpoint, before any client/scope processing. Side-effect hook (logging, redirects prep). |
| `hook_oauth2_server_claims($account, $requested_scopes)` | returns array | Supply **additional OpenID Connect claims** for the user given the requested scopes. Merged into the claims (`+=`), so it cannot overwrite core claims. |
| `hook_oauth2_server_user_claims_alter(&$claims, $account, $requested_scopes)` | by-ref | Alter/overwrite the assembled claims after `getUserClaims()` and the `_claims` hook. |
| `hook_oauth2_server_default_scope($server)` | returns string[] | Provide the default scope when the request omits one; first implementation to return wins. |
| `hook_oauth2_server_scope_access_alter(&$context)` | by-ref (`$context['scopes']`, `$context['server']`) | Add/remove scopes available for a request (e.g. hide a `forbidden` scope, or role-gate a scope). |

## Examples (from api.php)

```php
function mymodule_oauth2_server_claims(\Drupal\user\UserInterface $account, array $requested_scopes) {
  $claims = [];
  if (in_array('phone', $requested_scopes)) {
    $claims['phone_number'] = $account->get('field_phone_number')->getValue();
    $claims['phone_number_verified'] = $account->get('field_phone_number_verified')->getValue();
  }
  return $claims;
}

function mymodule_oauth2_server_default_scope(\Drupal\oauth2_server\ServerInterface $server) {
  if ($server->id() == 'test_server') {
    return ['basic', 'admin'];
  }
}

function mymodule_oauth2_server_scope_access_alter(array &$context) {
  // Scope ids are prefixed with the server id.
  foreach ($context['scopes'] as $id => $scope) {
    if ($scope->scope_id == 'forbidden') {
      unset($context['scopes'][$id]);
    }
  }
}
```

Note: the standard OIDC `sub`/`email`/`profile` claims are built in
`OAuth2Storage::getUserClaims()`; use these hooks for anything beyond them.
