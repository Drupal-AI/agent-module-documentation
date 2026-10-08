# Block Access — agent index

Generates **per-block-content-type permissions** so non-admins can manage content blocks
without `administer blocks`. No admin UI, no config entity, no configure route, no Drush,
no plugins. You use it entirely by granting permissions on roles.

- **What permissions it adds, which are deprecated, and how block-add access is rewritten** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permissions are generated dynamically per `block_content` type via
  `permission_callbacks: \Drupal\block_access\Permissions::get`, so the exact strings depend
  on the block types that exist (e.g. `update own basic block_content`).
- Non-deprecated (the reason to use 1.2.x): `update own <type> block_content`,
  `delete own <type> block_content`.
- Deprecated in 8.x-1.2, removed in 2.0.0 (use the equivalent core permission instead):
  `create <type> block_content`, `update any <type> block_content`, `delete any <type> block_content`.
- A route subscriber swaps `block_content.add_form` to the `_block_content_access_create`
  check: create is allowed with `administer blocks` **OR** `create <type> block_content`.
- Requires the core `block_content` module.
