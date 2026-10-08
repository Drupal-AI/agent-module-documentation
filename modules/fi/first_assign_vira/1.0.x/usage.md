<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Auto Term automatically creates a taxonomy term mirroring an entity's title when the entity is created, with bulk backfill.

---

Entity Auto Term (project `first_assign_vira`, internal machine name `eat`) automatically generates a taxonomy term named after an entity's title whenever a configured entity/bundle is created, records the entity→term link in its own `eat` table, and keeps the term name in sync when the entity is edited.

An admin settings form (`/admin/config/system/eat`, `administer site configuration`) maps entity-type + bundle combinations to one or more target vocabularies. A `hook_form_alter` attaches a submit handler to the matching create/edit forms; on submit, `Eat::addTerm()` creates the term (or reuses an existing one with the same title) and inserts the mapping row. A batch form at `/admin/config/system/eat/batch` runs `Eat::matchupEntitiesToSet()` to backfill terms for content that predates the configuration, and a Views `argument_default` plugin (`EatFilters`) exposes the linked terms for contextual filters.

Setup: enable, configure which entity/bundle → vocabulary mappings apply, then optionally run the batch to backfill. It creates taxonomy terms as a side effect of entity saves; it does not assign user roles or permissions.

---
- Auto-create a taxonomy term from a node's title on creation.
- Map a content type to one or more target vocabularies.
- Keep a term's name in sync when its entity is edited.
- Backfill terms for pre-existing content via batch.
- Link entities to their generated terms in the `eat` table.
- Reuse an existing term when the title already exists.
- Drive Views contextual filters from linked terms.
- Configure multiple entity/bundle → vocab mappings.
- Build a mirror taxonomy of content titles.
- Provide a default Views argument from the entity's term.
- Categorise content automatically without manual tagging.
- Run a one-click bulk import of terms.
- Support several vocabularies per bundle.
- Maintain a title-based tag vocabulary.
- Update term names on entity edits.
- Track entity-to-term relationships programmatically.
- Bootstrap taxonomy from existing content.
- Feed related-content views via auto terms.