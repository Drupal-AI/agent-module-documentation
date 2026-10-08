<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_localgov_roles_default() — default paragraph permissions

`localgov_paragraphs.module` implements one hook: `localgov_paragraphs_localgov_roles_default()`. This is the
`hook_localgov_roles_default()` collector run by the **localgov_roles** module (LocalGov distribution). It does
NOT define permissions of its own — it assigns permissions that the `paragraphs` / `paragraphs_library` /
core modules already provide to the standard LocalGov editorial roles.

Assigned to `AUTHOR_ROLE`, `CONTRIBUTOR_ROLE` and `EDITOR_ROLE`
(`Drupal\localgov_roles\RolesHelper` constants):

| Permission | Provided by |
|---|---|
| `create paragraph library item` | paragraphs_library |
| `edit paragraph library item` | paragraphs_library |
| `view unpublished paragraphs` | paragraphs |

Notes:
- localgov_roles is a **soft** dependency — it is not listed in `localgov_paragraphs.info.yml`, so the hook
  only fires when localgov_roles is enabled (i.e. on a full LocalGov site). On a plain paragraphs install the
  hook is inert.
- These grants apply when localgov_roles rebuilds role defaults (on install of a participating module or via
  its role-default mechanism); they are not written to any config object by this module.
- The `data.json` flag `provides_permissions` is `false` because no `*.permissions.yml` exists here.
