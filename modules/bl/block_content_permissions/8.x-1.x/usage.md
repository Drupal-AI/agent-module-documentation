<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Content Permissions splits Drupal core's single "Administer blocks" permission into granular per-block-type create/update/delete permissions plus a "block content types" administration permission.

---

Drupal core gates the whole "Custom block library" (block content and block content types) behind one coarse `administer blocks` permission, so any editor who can place blocks can also create, edit and delete every custom block and every block type. This module fixes that by implementing `hook_ENTITY_TYPE_access()` / `hook_ENTITY_TYPE_create_access()` for the `block_content` and `block_content_type` entities and by generating dynamic per-bundle permissions (`create <type> block content`, `update any <type> block content`, `delete any <type> block content`) via a `permission_callbacks` provider (`Drupal\block_content_permissions\Permissions::get`). Two static permissions are also declared: `administer block content types` (restricted) and `view restricted block content`.

Operationally you enable the module, then grant the new permissions per role instead of `administer blocks`. It also alters the `block_content` view: `hook_views_query_alter()` restricts the block-content listing to the types a user may create/edit/delete unless they hold `view restricted block content`, and `hook_views_pre_build()` removes the always-visible "edit" link from the description column so the permission-aware Operations links are used instead. There is no configuration UI, no routes, and no request-handling code — it is purely an access-policy layer, so there are no anonymous or mutating endpoints and no security-sensitive surface of its own.

---

- Grant a role permission to create only one custom block type
- Allow editing of any block of a given type without full admin
- Restrict deletion of block content to specific roles
- Give an admin role management of block content types only
- Hide block types a user cannot manage from the block library listing
- Filter the block content overview view per user permission
- Replace core `administer blocks` with least-privilege permissions
- Let inline-entity-form flows create block content with a scoped permission
- Prevent editors from deleting shared/reusable blocks
- Allow a role to view the full block list via `view restricted block content`
- Separate block-type structural admin from block content editing
- Support multi-team sites where each team owns a block type
- Audit which roles can mutate which custom block bundles
- Combine with Block Region Permissions for full block-layout control
- Keep translators/editors out of block-type configuration
- Enforce per-bundle create limits in a governed editorial workflow
