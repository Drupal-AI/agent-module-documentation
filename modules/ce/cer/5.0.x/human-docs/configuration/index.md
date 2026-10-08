# Configuration

CER does nothing until at least one **preset** exists. A preset pairs up two entity-
reference fields and tells CER to keep them reciprocal.

## Open the presets screen

1. Log in as a user with the **Administer Corresponding Entity References** permission.
2. Go to **Configuration → Content authoring → Corresponding References**, or navigate
   directly to `/admin/config/content/cer`.

You see a list of existing presets, with an **Add corresponding reference** action to
create a new one.

## Create a preset

Click **Add corresponding reference** and fill in the form:

- **Label** — a human-readable name for this relationship, e.g. "Article ↔ related
  article".
- **First field** — a select of eligible entity-reference fields. Only fields whose
  machine name starts with `field_` are offered (base fields and non-`field_` fields are
  not selectable). Required.
- **Second field** — the field on the other side of the relationship. As the form's own
  note says, *it may be the same field* as the first — pick the same field for a symmetric
  "related content" setup where each item lists the other. Required.
- **Add Direction** — whether a newly-created back-reference is added at the **bottom**
  (*append*, the default) or the **top** (*prepend*) of the target field's list.
- **Bundles** — a multi-select of `entity_type : bundle` combinations the preset applies
  to, including an `entity_type : *` "all bundles" option per type. Only entity types that
  actually have one of the two chosen fields are listed. This is also how you correspond
  fields across *different* entity types (e.g. node ↔ commerce product).
- **Enabled** — only enabled presets act at runtime, so you can switch a relationship off
  without deleting it.

Save the preset. From now on, whenever a matching entity is saved, CER updates the
corresponding entity.

## Applying a preset to content that already exists

CER only acts when an entity is **saved** — creating or editing a preset never rewrites
existing content. To apply a new preset to content that is already there, re-save those
entities. For a handful you can just open and save each one; for many, a small Drush loop
that loads and saves them is the usual approach (see the agent docs for a ready-made
snippet).

## Important: do not use the "Synchronize" tab

Each preset has a *Synchronize* action, but in this release it is **broken** — its confirm
form deletes the preset instead of syncing existing content, while reporting success.
Avoid it. There is no working "sync existing content" button; re-save the entities as
described above instead.

## Good to know

- Everything runs as the **current user**. If the person (or process) saving an entity
  cannot view or update the corresponding entity, the back-reference is silently skipped —
  no error is shown. This is by design.
- If the corresponding field is **single-value**, an added back-reference will overwrite
  or collide with its existing value on save — pair up multi-value fields for a
  many-to-many relationship.
- Removing the forward reference automatically removes the matching back-reference, and
  deleting a referencing entity cleans up its back-references too.
- Presets are configuration, so you can export them and deploy identical relationship
  rules across environments.
