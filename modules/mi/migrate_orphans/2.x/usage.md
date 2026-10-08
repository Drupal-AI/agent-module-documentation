<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Orphans deletes orphaned items left by migrations — content that was migrated but whose source no longer exists.

---

Re-running migrations can leave orphans: items imported from a source row that has since been deleted at the source. Migrate Orphans finds and deletes those orphaned migrated items so the destination matches the source. It is a migration-maintenance tool, and like any bulk-deletion utility it warrants care: 'orphaned' means 'no longer in the source per the migration map', which is correct for a mirror migration but would delete legitimately-kept content if the migration is not a strict mirror. So run it deliberately, confirm the migration is meant to be a mirror (deletions at source should propagate), review what it proposes to remove, and keep a backup. For keeping a migrated dataset in sync with its source it is the right tool; used on a migration that is not a mirror it deletes content you meant to keep.

---

- Delete orphaned migrated items.
- Sync a migration with its source.
- Remove items whose source is gone.
- Clean up after re-migration.
- Mirror source deletions.
- Confirm the migration is a mirror.
- Review proposed deletions.
- Back up before running.
- Keep a dataset in sync.
- Avoid deleting kept content.
- Run deliberately.
- Handle migration orphans.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.