<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Revision Log Default works

One function: `revision_log_default_entity_presave(EntityInterface $entity)`.

## Guard conditions

It acts **only** when **all** of these hold:

1. `$entity instanceof ContentEntityInterface` **and** `$entity instanceof RevisionLogInterface`
   (i.e. the entity type has a revision log field — nodes, and other revisionable types).
2. `empty($entity->getRevisionLogMessage())` — an explicitly provided message is left untouched.

If either fails, the module does nothing.

## Generated messages

Given a resolved bundle **label** (bundle entity label, or the entity-type label if the entity is
not bundleable):

| Situation | Message |
|---|---|
| `$entity->isNew()` | `Created new <label>` (e.g. "Created new Article") |
| `$entity->isNewTranslation()` | `Created <language name> translation` |
| Update, 1–2 changed fields | `Updated the <FieldA> and <FieldB> field(s)` (uses `formatPlural`) |
| Update, 3+ changed fields | `Updated the <F1>, <F2>, and <F3> fields` |
| Update, no detectable change | `Updated <label>` |

Field names in the message are the **field labels** (`getDataDefinition()->getLabel()`), e.g. the
node title field yields "Title", the body field yields "Body".

## How "changed fields" are computed

It compares the entity being saved against the **original** (`_revision_log_default_get_original()`)
field by field, and collects labels of fields that differ. Skipped fields:

- `changed`
- the entity type's revision key
- any field whose name contains the substring `revision`
- empty comment fields (`CommentFieldItemList`)
- `path` when `path.pathauto` is set (auto-alias)

`path` fields are compared by their `alias` value only (normal `equals()` is too strict for paths).
All other fields use `FieldItemListInterface::equals()`.

## Moderation awareness

`_revision_log_default_get_original()` normally returns `$entity->original`. But if
**content_moderation** (or **workbench_moderation**) is enabled and the entity is moderated, it
loads the **latest** revision (`getLatestRevisionId()` / `loadRevision()`), in the entity's
language, and diffs against that instead — so forward-revision workflows produce correct messages.

## Side effects it also performs

While setting the message it repairs common metadata problems:

- **Revision timestamp**: if the revision creation time equals the original's (unchanged) or is
  empty, it is reset to the current request time. Fixes stale timestamps from custom code, REST,
  and Quick Edit.
- **Revision author**: set to the current user; if the current user is anonymous (uid 0) and the
  entity has an owner, it falls back to the owner id. Fixes blank authors from CLI/migrations.

## Consequences for callers

- To keep your own message, just set it: `$node->setRevisionLogMessage('my message')` before save.
- To get an auto message, leave it empty and save — no API call needed.
- There is nothing to configure or invoke; enabling the module is the entire setup.
