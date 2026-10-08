<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Access Control Lite — agent index

Grants **node view/update/delete** access based on the taxonomy terms a node is tagged with,
using Drupal's **node_access grants** system. It only *grants* (reveals) access. Depends on
core `taxonomy`. One submodule: `tac_lite_create`.

- **Configure vocabularies, schemes, per-role/per-user grants** →
  [configure/schemes.md](configure/schemes.md)
- **How the node-access mechanism works (hooks, realms, grant ids, rebuild)** →
  [api/node-access.md](api/node-access.md)

Key facts:
- All config is in the `tac_lite.settings` config object: `tac_lite_categories` (vocab ids),
  `tac_lite_schemes` (number of schemes, up to 7), `tac_lite_storage_type` (`tid`|`uuid`),
  `tac_lite_config_scheme_<n>` (name, perms, unpublished, term_visibility), and
  `tac_lite_grants_scheme_<n>` (role→vocab→terms defaults). **There is no `tac_lite.scheme.N`
  object** despite the schema stub.
- Admin UI: `/admin/config/people/tac_lite` (route `tac_lite.administration`) + one tab per
  scheme (`/admin/config/people/tac_lite/scheme_<n>`). Per-user grants at `/user/{user}/tac_lite`.
- Perms per scheme: `grant_view`, `grant_update`, `grant_delete`; realm = `tac_lite_scheme_<n>`.
- Permission: `administer tac_lite`. Cache context: `user.tac_lite_grants`. No Drush, no DB tables.
- **After changing schemes you must rebuild node access permissions.**
- Submodule `tac_lite_create` hides disallowed term options on node add/edit forms →
  see `modules/tac_lite_create/2.0.x/`.
