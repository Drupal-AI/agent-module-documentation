<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The request gate, permission & State storage

## Where the token lives
Tokens are kept in Drupal **State** under the single key `exclusiv_access`, shaped as a nested array `state['exclusiv_access'][<entity_type_id>][<entity_id>] = <token string>`. It is written by the field type's `postSave()` (see fields/field.md) and read by both the widget and the gate. There is no config object, config schema, or settings form for this — it is all runtime State (`key_value` table).

## The gate — `AccessCheck`
`src/EventSubscriber/AccessCheck.php`, service `exclusiv_access.access_check`, tagged `event_subscriber`. Constructor args (`exclusiv_access.services.yml`): `@current_user`, `@current_route_match`, `@exception.default_html`, `@state`, `@request_stack`. It caches `state->get('exclusiv_access')` and the request's `?token=` query value at construction.

Subscribes to `KernelEvents::REQUEST` (method `exclusivAccess`, default priority). On each request:
1. `getEntityFromRoute()` resolves the content entity being viewed on its page from the current route's `entity:*` route parameter.
2. If an entity is found and `isset($exclusivAccesses[$entity_type][$entity->id()])` (i.e. a token has been minted for it) **and** the current user does **not** have permission `see content without token`:
3. If the request `?token=` value does not equal the stored token, it throws `NotFoundHttpException` → the page returns **404**.

Users with `see content without token` skip the check entirely. Requests carrying the correct `?token=` value pass. All other visitors get a 404 on the gated entity's page.

## Permission
`exclusiv_access.permissions.yml` declares one permission:
- `see content without token` — "See content without token" (description notes it is *not* an anonymous permission). Grant it to trusted roles (editors) so they view gated entities without the link. Verified by the module's functional test `tests/src/Functional/ExclusiveAccessTest.php` (anonymous → 404 without token, 200 with token, permitted user → 200).

## Operational notes (behavior, grounded in source)
- **Deactivating is not automatic.** `postSave()` only *adds* a token when the box is checked; unchecking the box (value 0) does nothing to State. Because the gate keys off the presence of the State entry (not the field value), an entity stays gated after the box is unchecked until the State entry is removed manually (e.g. programmatically edit/clear the `exclusiv_access` State key). Plan for this when you want to "open up" content again.
- **Token reuse.** Re-saving a still-checked entity reuses the existing token; it is not rotated.
- **No UI to list/revoke tokens.** Management is per-entity via the edit form (read-only token display) plus direct State manipulation.
