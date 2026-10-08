<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Core Remove Helper — agent index

Maintenance submodule of EBT Core: an admin form for bulk-removing EBT blocks and the shared
`field_ebt_settings` storage before uninstalling EBT modules. No config, permissions of its
own, Drush, or plugins.

- **The remove form: route, operations, how EBT content is identified** →
  [configure/remove-form.md](configure/remove-form.md)

Key facts:
- Route `ebt_core_remove_helper.ebt_remove_helper` → `/admin/structure/block/remove-ebt-blocks`
  (local task "Remove All EBT Blocks"; permission `administer site configuration`).
- Form `EbtRemoveHelperForm` operations: **Remove All EBT Blocks** (Batch-deletes all
  `block_content` of `ebt_`-prefixed bundles) and **Remove EBT Settings Field Storage**
  (deletes `field_ebt_settings` storage, only when no `ebt_` block types remain).
- EBT content is identified by the `ebt_` **bundle machine-name prefix**.
