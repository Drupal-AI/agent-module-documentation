<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Content Type Access (det_node) restricts each content type to selected Domains via checkboxes on the content-type form, and enforces that restriction on the content-type list, the "Add content" page, and node/content-type edit/delete/permissions routes.

---

det_node is the default-enabled submodule of Domain Access Entity Type. It adds a "Domain access" checkboxes group to the content type add/edit form (`node_type_add_form` / `node_type_edit_form`) listing every enabled domain; the selection is saved as the `det_node`/`domains` third-party setting on the `node_type` config entity via an entity builder. When a content type has one or more domains assigned, det_node limits it to those domains in four places: the content-types list builder hides its row on other domains (`NodeTypeListBuilderOverride`), the "Add content" page removes its card (`NodeControllerOverride::addPage`), the node_type access control handler forbids the content-type operations on other domains (`NodeTypeAccessOverride`), and a route access check (`_det_node_access_check`) forbids `node.add`, `entity.node.edit_form`, `entity.node.delete_form`, `entity.node_type.edit_form`, `entity.node_type.delete_form`, and `entity.node_type.entity_permissions_form` on other domains. A content type with no domains selected is available everywhere. The `bypass content type domain access check` permission (or the parent's `bypass all entity types domain access check`) skips all of these checks. det_node governs content-type (and node add/edit/delete) administration, not the viewing of published nodes — node canonical/view routes are not altered.

---

- Restrict a content type so it can only be created and managed on one specific domain.
- Assign a content type to several domains at once with the "Domain access" checkboxes on `/admin/structure/types/manage/<type>`.
- Leave the checkboxes empty to keep a content type available on all domains (default behavior).
- Hide domain-restricted content types from the content-types list (`/admin/structure/types`) on domains they are not assigned to.
- Remove domain-restricted content types from the "Add content" page (`/node/add`) on non-assigned domains.
- Block creating a node of a restricted content type (`node/add/<type>`) while on the wrong domain.
- Block editing a node of a restricted content type (`node/<nid>/edit`) while on the wrong domain.
- Block deleting a node of a restricted content type while on the wrong domain.
- Block editing, deleting, or managing permissions of a content type from a domain it is not assigned to.
- Give affiliate editors a content-type list and add page limited to their own domain.
- Grant `bypass content type domain access check` to trusted roles so they manage all content types on any domain.
- Grant the parent's `bypass all entity types domain access check` for a full framework-wide bypass.
- Export content-type domain assignments as configuration (`node.type.*` third-party settings) for deployment.
- Keep multiple brands/affiliates on one Drupal install with separate content-type sets per domain.
- Reduce editor error by showing each domain only the content types relevant to it.
- Pair with Domain Access node grants so both the content type and the individual content are domain-scoped.
