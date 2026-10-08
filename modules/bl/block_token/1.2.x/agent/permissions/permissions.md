# Block Token — permissions

Defined via `BlockTokenPermissions::permissions()`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer block token` | (not set) | The "Create the token for this block" checkbox on block forms. Its own description also states it "gives permission to View/Edit/Save block forms." |

## Block route access
`block_token.services.yml` registers a `RouteSubscriber` that sets the access requirements on two
core routes:

```php
// src/Routing/RouteSubscriber.php
$collection->get('entity.block.edit_form')->setRequirements(['_custom_access' => '\block_token_route_access']);
$collection->get('block.admin_display_theme')->setRequirements(['_custom_access' => '\block_token_route_access']);
```

`block_token_route_access()` returns **allowed** if the user has `administer taxonomy` OR
`administer block token`, else forbidden.
