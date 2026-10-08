<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity batch resave (entity_resave) — agent index

**Admin Batch-API forms to bulk re-save all nodes/media of a chosen bundle. Gated only by `access content` — see security note.**

- **Version:** 1.0.x  •  core: `^9.0 || ^10`  •  package: Custom.
- **Routes:** `/admin/entity_resave/resave-node` (`NodeResaveForm`), `/admin/entity_resave/resave-media` (`MediaResaveForm`), `/admin/entity_resave/completed` — ALL `_permission: 'access content'`.
- **Batch ops:** `update_node($nid,$update)` (restores old changed time when `$update !== '1'`), `update_media($mid)` — both call `$entity->save()`.
- **Bundle list built from `entity_type.bundle.info`; node/media IDs fetched by direct DB select.**

**Security finding (D3, unauth/low-priv data mutation):** the resave forms require only `access content` (granted to anonymous by default) with NO per-entity access check — see `entity_resave.routing.yml` (all three routes) and `NodeResaveForm::submitForm` / `MediaResaveForm::submitForm`. Anyone able to view content can trigger a site-wide re-save of every node/media in a bundle (mutation of changed timestamps + mass save side effects + resource exhaustion). Fix: require an admin permission (e.g. a dedicated `administer entity_resave` or `administer nodes`) and/or `_admin_route`.
