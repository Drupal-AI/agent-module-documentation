# Configuration

The module does nothing until you tell it **which entity types to protect**. That
is the whole of its configuration.

## Before you start

Make sure the two dependencies are enabled first —
`entity_reference_integrity` and `entity_reference_integrity_enforce` — because the
protection logic asks them whether an entity still has dependents. See
[Installation](../installation/index.md).

## Open the settings form

1. Log in as a user with the **Administer prevent entity unpublish** permission (an
   administrator by default). This permission is marked *restricted* because it
   controls a content‑integrity safeguard.
2. Go to **Configuration → Content authoring → Prevent entity unpublish**, or
   navigate directly to `/admin/config/content/prevent-entity-unpublish`.

## Choose the protected entity types

The form offers a checkbox for each supported entity type — **node**,
**taxonomy_term**, and **user**. Tick the ones where an unpublish should be blocked
while references still exist:

- **Node** — stop editors from unpublishing content (for example a landing‑page
  building block or a referenced article) while other content still links to it.
- **Taxonomy term** — keep a term visible while content is still filed under it.
- **User** — keep an author or contributor account published while its content or
  references remain.

Leave a type unticked to exempt it. You can roll the protection out gradually —
start with nodes only, then add the others once you're comfortable with the
behaviour.

## Save

Click **Save configuration**. Your selection is written to config as
`prevent_entity_unpublish.settings:enabled_entity_type_ids`, so it exports cleanly
and can differ per environment.

## What editors will see

On the edit form of a protected node, term, or user, if an editor sets the status
to *unpublished* and the entity still has dependents, a **validation error** lists
the referencing entities and the save is rejected. The editor either republishes
the dependents, removes the references, or leaves the entity published.

> **Remember the limit.** This guard runs only in the form's validation step. An
> unpublish performed by code, a migration, or REST bypasses it — so it protects
> the editorial UI, not every possible path.
