# Configuration

Configuring Simple Entity Merge is mostly a matter of deciding which entity types
should offer the merge action — and understanding what a merge does before you run
one.

## Open the settings form

1. Log in as a user with the **Administer simple_entity_merge** permission.
2. Go to **Configuration → Content authoring → Simple Entity Merge**, or navigate
   directly to `/admin/config/content/simple_entity_merge`.

## Choose the mergeable entity types

The settings form lets you select which entity types the merge tool applies to.
Enable the types where duplicates are a real problem — taxonomy terms are the
classic case, but any entity type with entity‑reference fields pointing at it can
benefit. For each type you enable, entities of that type gain a **Merge** tab.

Save the form once you have chosen your types.

## Running a merge

1. Open the entity you want to **remove** (the duplicate).
2. Click its **Merge** tab. You will need the **Execute simple_entity_merge**
   permission.
3. Choose the other entity of the same type that references should be moved **to**
   (the one you want to keep).
4. Confirm. The module repoints every entity‑reference link from the duplicate onto
   the entity you kept, then deletes the duplicate.

## Important cautions

- **A merge cannot be undone.** Take a backup first, and rehearse on a copy of the
  site for anything large, such as consolidating many terms in a big vocabulary.
- **Only entity‑reference fields are followed.** References that live elsewhere are
  **not** rewritten and will keep pointing at the deleted entity:
  - text fields containing an inline link or embedded entity,
  - Layout Builder section configuration,
  - serialised settings or another module's own database tables.
  Before relying on the tool, confirm that the way your site actually holds these
  references is covered.
- **No batching.** The module processes references in a single pass rather than in
  batches, so it is not advised for entities that have very large numbers of
  references — it may time out.
- **Keep the permissions tight.** Because a merge is a bulk, destructive rewrite,
  grant **Execute simple_entity_merge** only to trusted roles.
