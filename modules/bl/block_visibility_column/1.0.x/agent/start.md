<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Visibility Column (block_visibility_column) — agent index

Adds a **"Visibility" column to the Block Layout page** (`/admin/structure/block`) so each placed
block's visibility conditions are readable inline, instead of opening each block's config form.
Read-only surfacing of existing config — it changes no block behavior, adds no routes, no permissions,
no settings, no config schema.

- **Version:** 1.0.3 (version-dir `1.0.x`). Core `^9 || ^10 || ^11`. Package: Administration.
- **Depends on:** core `block` only. No composer requirements.
- **How it works:** `hook_entity_type_alter()` (in `block_visibility_column.module`) reassigns the
  `block` entity's list-builder to `BlockVisibilityColumnListBuilder`, which extends core
  `Drupal\block\BlockListBuilder` and injects one extra column.
- **Provides:** no entities, plugins, routes, services, or permissions of its own. Access to the
  Block Layout page is unchanged (still core's `administer blocks`).

## Solution docs
- [api/list-builder.md](api/list-builder.md) — the list-builder override, how the Visibility column
  is built, which visibility condition plugins are formatted (roles, language, request_path,
  entity_bundle, Token Conditions' `token_matcher`), and how to extend it.
