<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smallads (smallads) — agent index

**A plug-and-go classified-ads marketplace: a `smallad` content entity with categories, scopes, expiry and listing views.**

- **Version:** 2.0.x · package Smallads
- **Core:** ^10 || ^11
- **Configure:** `smallads.settings` → `/admin/structure/smallads/settings`
- **Entity:** `smallad` (bundle `smallad_type`); own access handler + `SmalladIsVisible` constraint
- **Permissions:** `view smallad`, `post smallad`, `edit all smallads` (all restrict access); admin routes need `administer site configuration`
- **Vocabularies:** `categories` (hierarchical), `smallads_types` (tabs)
- **Deps (contrib):** shs, chosen, taxonomy_entity_index; contact enabled via hook_install
- **Submodules:** smallads_group, smallads_mcapi, smallads_murmurations

**Security:** all ad and admin routes are permission-gated (post/view/edit-all restrict access; type management requires administer site configuration). Expired ads drop to private scope. No anonymous mutating endpoints. `mt_rand` appears only in Devel-Generate sample data (not security-sensitive).

See [configure/setup.md](configure/setup.md)
