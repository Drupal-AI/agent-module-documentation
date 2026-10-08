<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events — authorization (`mcp_server.authorize_call`) and OAuth2

Authorization of an individual tool (and, by design, resource/prompt) operation is done with a
Symfony event, so integrations can add access policy without patching core.

## The event

- `McpAuthorizeCallEvent` (`src/Event/McpAuthorizeCallEvent.php`), dispatched under the **string**
  name `McpAuthorizeCallEvent::EVENT_NAME` = **`mcp_server.authorize_call`** (subscribe by that
  string, not the class FQCN).
- Constructor: `(McpOperationDescriptor $operation, AccountInterface $account,
  ?ServerRequestInterface $request = NULL)`.
- `McpOperationDescriptor` (readonly): `type` (one of the constants `OPERATION_TYPE_TOOL='tool'`,
  `OPERATION_TYPE_RESOURCE='resource'`, `OPERATION_TYPE_PROMPT='prompt'`), `name`, `pluginId`,
  `?configEntity` (the backing config entity, e.g. a `mcp_tool_config`).
- **Deny-only API:** `deny(string $reason, int $http_status = 403)`. Denial is immutable (first
  `deny()` wins); there is no "allow" call. `isDenied()`, `getReason()`, `getHttpStatus()` read it.

`CustomCallToolHandler::authorize()` builds the descriptor (with the registration's `configEntity`),
dispatches the event, and if `isDenied()` throws
`McpAuthorizationDeniedException($reason, $httpStatus)`. The controller maps that to a JSON-RPC error
+ `WWW-Authenticate` header (401 → `-32001`, 403 → `-32003`; see [../api/http-endpoint.md](../api/http-endpoint.md)).

### Writing a custom policy

```php
final class MyMcpAuthz implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [McpAuthorizeCallEvent::EVENT_NAME => 'onAuthorize'];
  }
  public function onAuthorize(McpAuthorizeCallEvent $event): void {
    if ($event->operation->type === McpAuthorizeCallEvent::OPERATION_TYPE_TOOL
        && $event->operation->name === 'tool_api:danger'
        && !$event->account->hasPermission('run danger tool')) {
      $event->deny('forbidden', 403);
    }
  }
}
```

## mcp_server_oauth — per-tool OAuth2 scopes

The submodule ships `McpAuthorizeOAuthSubscriber` (subscribes to `mcp_server.authorize_call`). For an
operation whose `configEntity` carries the third-party settings
`mcp_server_oauth.authentication_mode = 'required'`, it reads
`mcp_server_oauth.scopes`, extracts the caller's token scopes with `OAuthScopeValidator`, and denies
when required scopes are missing (`authentication_required`/401 when no token scopes are present,
`insufficient_scope`/403 when some are present but not all required). Operations whose entity has
`authentication_mode = 'disabled'` (the default) or no config entity are not denied by this subscriber.

- `OAuthScopeValidator::extractTokenScopes()` validates the `Authorization: Bearer …` header through
  Simple OAuth's resource server (`validateAuthenticatedRequest()`), loads the `oauth2_token` entity,
  checks `->isRevoked()`, and returns its scope names. `validateScopes()` requires **all** listed
  scopes (`array_diff` AND-logic).
- Per-tool settings are edited on the `mcp_tool_config` add/edit form (added by
  `mcp_server_oauth_form_mcp_tool_config_edit_form_alter()`): an "OAuth2 Authorization" fieldset with
  `authentication_mode` (Disabled/Required) and `scopes` (multi-select, options aggregated by
  `OAuthScopeDiscoveryService::getScopesSupported()` from every enabled tool config). Values are saved
  as third-party settings under the `mcp_server_oauth` namespace.
- `RouteSubscriber` adds `oauth2` to the `/_mcp` route `_auth`. `ResourceMetadataSubscriber` adds the
  aggregated `scopes_supported` to the RFC 9728 `/.well-known/oauth-protected-resource` metadata;
  `MetadataCacheSubscriber` tags that response with `mcp_server:discovery`.
- Requires `simple_oauth` + `simple_oauth_21`; the per-tool form only appears when
  `mcp_server_tool_bridge` is also enabled. Config schema:
  `mcp_server_tool_bridge.mcp_tool_config.*.third_party.mcp_server_oauth` → `authentication_mode`
  (string), `scopes` (sequence of string).
