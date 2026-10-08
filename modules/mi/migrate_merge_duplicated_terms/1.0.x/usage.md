<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate - Merge duplicated terms migrates one of the duplicated terms and maps the other ids to the migrated one.

---

Migrate - Merge duplicated terms helps taxonomy-term migrations — when the source has duplicate terms
that should become one, it migrates a single term and **maps the other source IDs to the migrated term's ID**,
so dependent migrations (content referencing those terms) resolve correctly without creating duplicates. It
is in the Migration package.

Use it in taxonomy migrations that need duplicate merging. It is a developer/migration utility acting on
migration mappings; it processes migration data and has no content or access role. Configure it in the
relevant term migration.

---

- Merge duplicate terms during migration.
- Migrate one term, map the others' IDs.
- Avoid duplicate terms.
- Resolve dependent migrations correctly.
- Handle source duplicates.
- Map other IDs to the migrated term.
- Process migration data.
- Have no content/access role.
- Configure in the term migration.
- Handle term deduplication.
- Merge terms.
- Configure the migration.
- Map term IDs.
- Handle migration mapping.
- Deduplicate terms.
- Configure merging.
- Handle taxonomy migration.
- Merge duplicates.
- Configure term migration.
- Map duplicates.
