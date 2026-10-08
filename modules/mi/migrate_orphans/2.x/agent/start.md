<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Orphans (migrate_orphans) — agent index

Deletes **orphaned migrated items** (destination content whose source row is gone). Version **2.0.3**.

**Data-loss caveat:** 'orphaned' = not in the source per the migration map — correct for a **mirror**
migration, but deletes legitimately-kept content otherwise. Confirm the migration is a mirror, review
deletions, keep a backup.