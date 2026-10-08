<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Entity Merge adds a **Merge** tab to content entities: pick a target of the same type and every entity-reference pointing at the current entity is repointed to that target — the fix for a taxonomy that has accumulated "Health", "health" and "Heath" as three separate terms.

---

Duplicates are inevitable wherever entities are created freely: taxonomy terms typed by different editors, organisations imported twice from different sources, users entered with and without a middle initial. Deleting the duplicate is not enough, because everything referencing it breaks; the real work is finding every reference and repointing it, which is usually done with a hand-written script. This module makes it an operation. On a source entity you choose a destination via an autocomplete (locked to the same type, and same bundle where the type is bundled), confirm, and the service `simple_entity_merge.merge` rewrites both configurable and base `entity_reference` fields whose target type matches — so a user merge follows node authorship, a term merge follows tagged content. Note two things it does **not** do: it does not delete the source (it repoints references and then tells you "now you can delete this one"), and it only handles plain `entity_reference` fields — references held in text, in Layout Builder configuration, in serialised settings, or in another module's tables are not touched and keep pointing at the source. It also runs without batching, so it is not advised for entities with a very large number of references. A merge is not reversible, so take a backup first.

---

- Merge duplicate taxonomy terms.
- Repoint references from one entity to another.
- Clean up after a double import.
- Consolidate two organisation records.
- Repoint references before deleting a duplicate.
- Tidy a vocabulary accumulated over years.
- Merge two author/user profiles.
- Follow node authorship when merging users.
- Fix inconsistent tagging.
- Consolidate entities after a migration.
- Reduce duplicate options in a reference field.
- Add a Merge tab to a custom entity type.
- Restrict merging to trusted roles only.
- Improve faceted search by removing duplicates.
- Consolidate location records.
- Merge terms created by different editors.
- Clean reference data before a report.
- Exclude specific entity types from merging.
- Standardise entity naming.
- Merge media items that duplicate the same asset.
