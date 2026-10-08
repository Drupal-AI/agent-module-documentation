Entity Reference Revisions (ERR) provides an `entity_reference_revisions` field type that references a specific *revision* of a target entity rather than just its current ID, making it the foundation for composite/child entities like Paragraphs.

---

A normal core Entity Reference field stores only the target entity's ID, so it always resolves to that entity's default (current) revision. Entity Reference Revisions stores both the target ID **and** a target revision ID, letting a host entity point at the exact revision of a child that existed when the host was saved. This is what makes revisionable, non-reusable "composite" entities possible: when you create a new revision of the host, ERR creates new revisions of the referenced children too, and rolling the host back also rolls the children back. The module ships a field type, an autocomplete widget, and label/rendered-entity formatters, plus a Views row/style/display and a Migrate destination for building entity-reference-revisions data. It defines an `EntityNeedsSaveInterface`/trait so child entities can flag that they must be re-saved with the parent, and it tracks composite relationships so children whose parent no longer references them become "orphans." An orphan purger service, a queue worker, an admin delete form (gated by the *Delete orphan revisions* permission), and a `drush err:purge` command clean those orphans up. It optionally integrates with the Diff module to show revision changes. Most sites never touch ERR directly — they get it as a dependency of Paragraphs — but it is a general-purpose building block for any revisioned parent/child data model.

---

- Build revisionable Paragraphs-style content where children version alongside the host node.
- Reference a specific revision of a target entity instead of its current version.
- Keep a host entity's history intact by pinning each revision's child revisions.
- Roll back a node revision and have its referenced child entities roll back too.
- Model composite (non-reusable) child entities owned by a single parent.
- Add an `entity_reference_revisions` field to any fieldable entity type.
- Use the autocomplete widget to attach existing revisioned entities.
- Render referenced entities in a view mode with the rendered-entity formatter.
- Show just the label (optionally linked) with the label formatter.
- Flag child entities as "needs save" via `EntityNeedsSaveInterface` so they persist with the parent.
- Expose referenced revisions as rows in a View using the ERR Views row plugin.
- Build an entity-reference-revisions target list as a Views display.
- Migrate legacy data into revisioned references with the Migrate destination plugin.
- Compare referenced-entity changes across revisions via the Diff integration.
- Detect child entities orphaned when a parent stops referencing them.
- Bulk-purge orphaned composite revisions with `drush err:purge`.
- Clean up orphans through the admin *Delete orphan revisions* form.
- Queue large orphan-cleanup jobs with the orphan-purger queue worker.
- Restrict who can run orphan deletion with the dedicated permission.
- Provide the field infrastructure that the Paragraphs module builds on.
- Store editorial workflow drafts of nested content that version together.
- Guarantee a preview shows the exact child revisions belonging to a draft.
- Reference translations-aware revisioned children on multilingual sites.
- Programmatically read/set target ID and target revision ID on a field item.
- Purge stale child revisions to reclaim database space after content deletion.
