# Permissions

Defined in `graphql_compose_preview.permissions.yml`:

| Permission | Gates |
|---|---|
| `view graphql_compose_preview entity` | Whether a request may view another user's node **preview** via a token link/query. Required (in addition to a matching secret token) for the `preview` GraphQL query, the tokenized core preview route, and the `route()` query to return preview content. |

How it is used — `graphql_compose_preview_node_access()`:
```php
if ($op === 'view' && $node->in_preview && $tokenHelper->access($node)) {
  // token matched → still requires the permission:
  $access = AccessResult::allowedIfHasPermission($account, 'view graphql_compose_preview entity');
}
```
- Not `restrict access: true`. It is designed to be granted to whichever roles consume tokenized
  previews — per the README, "Enable the `View preview entities` permission for each role that can use
  tokenized preview links." Granting it to the **anonymous** role is a supported pattern for headless
  draft-mode front ends.
- The permission alone does not expose anything: a holder must also present the correct 64-byte random
  `preview_token` for the specific preview. Without a matching token, the hook returns *neutral* and the
  request falls back to normal node access (unpublished content stays inaccessible).
