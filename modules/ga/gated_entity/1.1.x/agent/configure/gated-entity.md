<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gated Entity — configuration

## Config form
`/admin/config/content/gated-entities` (`gated_entity.config`, permission `configure gated entities`). Backed by `GatedEntityConfigForm` (a `ConfigFormBase`) which reads/writes `gated_entity.config`. Allowed entity types are limited to `node` (see `GatedEntityHelper::ALLOWED_ENTITY_TYPES`). You select the node bundles to gate and the default locker (`default_locker`, default `login_locker`).

## Runtime behaviour
- `gated_entity_entity_view_alter()` calls `gated_entity.helper->isGatedEntityLocked($entity)`.
- `isGatedEntityLocked()` = the entity is a configured gated bundle AND the locker's `checkAccess()` returns FALSE.
- When locked, a `#post_render` callback `GatedEntityCallback::postRender` runs: it rebuilds output as `title + locker->buildLocker()` and returns that instead of the rendered entity markup.

## Important limitations
- This is a **view-layer** gate. It does not implement `hook_node_access` / node grants. The node remains retrievable via JSON:API, REST, Views field output, search, and its edit form.
- The default `login_locker` unlocks for **any authenticated user** (`\Drupal::currentUser()->isAuthenticated()`), not a specific role.
- For genuinely restricted content, pair with a real access-control mechanism.
