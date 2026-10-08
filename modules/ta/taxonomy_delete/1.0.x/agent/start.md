<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Delete — agent index

Utility that bulk-deletes all terms in one or more vocabularies. No stored config, no
plugins, no hooks. Two entry points: an admin form and a Drush command. Gated by the
`delete taxonomy terms` permission (route also requires `administer site configuration`).

- **Admin UI form, route, permission, batch delete, access behavior** →
  [configure/delete-ui.md](configure/delete-ui.md)
- **Drush command `taxonomy-delete:term-delete` / `tdel`** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Configure route: `taxonomy_delete.ui` at `/admin/structure/taxonomy/taxonomy-delete`.
- Permission: `delete taxonomy terms` (`restrict access: TRUE`).
- Deletion query uses `accessCheck(FALSE)` and Batch API; deletes every term whose `vid`
  is in the selected vocabularies.
