<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Holder (entity_holder) — agent index

**Config-entity 'holders' that reserve a persistent route/path for a (possibly not-yet-created) content entity, matched by UUID across environments.**

- **Version:** 1.0.x  •  **Core:** ^9 || ^10 || ^11  •  **Requires:** filter  •  **Configure:** `entity.entity_holder.collection` (`/admin/structure/entity-holder`)
- **Entity:** `entity_holder` config entity (path, title, fallback_content, held_entity_type/bundle/uuid).
- **Permission:** `administer entity holders` (admin_permission; gates all CRUD + hold routes).
- **Routes:** collection/add/edit/delete + `create-entity/{uuid}` (custom access `checkHeldEntityFormAccess`) and `hold-entity/{uuid}` (permission-gated).
- **Services:** `entity_holder.entity_helper`. Access handler: `EntityHolderAccess`.
- **Security:** All admin-route + permission-gated. Holder *view* defers to the held entity's access (`EntityHolderAccess.php:52`), denies disabled holders, else falls back to `access content`. `entityHolderView()` issues an internal SUB_REQUEST to the held entity's own canonical URL forwarding session/cookies (`Controller/EntityHolderController.php:164-183`) — target is the held entity, not a request-supplied URL, so no SSRF. Fallback body rendered via processed_text (text-format governed). No anonymous mutating endpoints.

See [configure/holders.md](configure/holders.md)
