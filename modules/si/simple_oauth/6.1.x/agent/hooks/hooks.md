# Hooks

Defined in `simple_oauth.api.php`. Both let you enrich the claims baked into issued tokens.

| Hook | Purpose |
|---|---|
| `hook_simple_oauth_private_claims_alter(array &$private_claims, AccessTokenEntity $access_token_entity)` | Add/override the private claims placed in the JWT access token before it is signed. |
| `hook_simple_oauth_oidc_claims_alter(array &$claim_values, array &$context)` | Add custom OpenID Connect claims returned from `/oauth/userinfo` and in the id_token. `$context` has `account` (the user) and `claims` (requested claim names). |

```php
function my_module_simple_oauth_oidc_claims_alter(array &$claim_values, array &$context): void {
  $account = $context['account'];
  $claim_values['phone_number'] = $account->get('field_phone')->value ?? NULL;
}
```

If you add brand-new OIDC claims, also register their names under the container parameter
`simple_oauth.openid.claims` so they are served.

Plugin managers additionally invoke `hook_simple_oauth_oauth2_grant_info_alter` — see
[../plugins/plugin-types.md](../plugins/plugin-types.md).
