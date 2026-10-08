<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block ARIA Landmark Roles — agent index

Adds a **Landmark role** select and an ARIA **Label** textfield to every block configuration form
and renders them as `role` / `aria-label` on the block wrapper. Depends on core `block`.
No configure route (`configure: null`), no settings form, no permissions, no Drush, no plugins.

- **Set / read the role and label (UI, config, PHP) and the exact allowed values** →
  [configure/landmark-roles.md](configure/landmark-roles.md)

Key facts:

- Storage: `block.block.<id>` → `third_party_settings.block_aria_landmark_roles.role` and
  `.label` (schema `block.block.*.third_party.block_aria_landmark_roles`).
- Allowed `role` values (schema `Choice` constraint): `none`, `application`, `banner`,
  `complementary`, `contentinfo`, `form`, `main`, `navigation`, `search`.
  `none` (and empty) means **no `role` attribute is rendered**.
- `label` is free text; when non-empty it becomes `aria-label` regardless of the role.
- Rendering happens in `block_aria_landmark_roles_preprocess_block()`, which writes into
  `$variables['attributes']`, so the attributes land on whatever element the theme's
  `block.html.twig` prints `attributes` on.
- Role list lives in `Drupal\block_aria_landmark_roles\BlockAriaLandmarkRoles::get()` /
  `::getAssociative()` (helper `_block_aria_landmark_roles_get_roles()`).
