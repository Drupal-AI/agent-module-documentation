<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Info Block — agent index

info.yml name **"Content Moderation Info Block"**, version **2.0.0-beta2**, core `^9 || ^10 || ^11`,
depends on core `content_moderation`. No routes, no services file, no permissions, no `.install`.
Everything is one derived **block plugin** plus two embedded state-change forms.

## What it is

A block that shows moderation info about the entity currently in context (the page's node, etc.) and,
optionally, an inline form to change that entity's moderation/publish state without opening the edit form.
Similar to what Workbench Moderation surfaced in D7.

## Block plugin

- Base plugin `content_moderation_info_block` (`src/Plugin/Block/ContentModerationInfoBlock.php`),
  `category = "Content moderation"`.
- **Derived per moderated entity type** by `ContentModerationInfoBlockDeriver`: one derivative for each
  entity type where `content_moderation.moderation_information::isModeratedEntityType()` is true. Each
  derivative gets admin_label `Moderation info (<Entity type>)` and an **entity context** constrained
  (via a `Bundle` constraint) to the bundles that can be moderated. `hook_ENTITY_TYPE_insert/update/delete`
  for `workflow` (in `.module`) clears cached block definitions when a `content_moderation` workflow changes.
- Consumes the context entity with `$this->getContextValue('entity')`. Place the block on an entity page
  and map its `entity` context to the current entity.

## What `build()` renders (each gated by a block-config checkbox)

- `changed_date_display` → "Last saved on": `date.formatter` `short` format of `getChangedTime()`
  (`EntityChangedInterface`); "Not saved yet" if new.
- `author_display` → "Last saved by": display name of the revision user (`RevisionLogInterface`;
  for translatable entities the latest translation-affected revision's user), else the entity owner
  (`EntityOwnerInterface`). Rendered as `#markup`.
- `latest_revision_display` → "Is latest revision": Yes/No, via active revision (`entity.repository`
  `getActive()`) for translatable-revisionable entities, else `isLatestRevision()`.
- `current_state_display` → "Current state": the workflow state **label** for a moderated entity,
  else "Published"/"Unpublished" for an `EntityPublishedInterface`.
- `change_state_display` → embeds a state-change form (see below). Companion checkbox
  `revision_log_message_input_display` toggles the revision-log textarea inside that form (only
  meaningful when `change_state_display` is on).

Config schema: `config/schema/content_moderation_info_block.schema.yml` (six booleans). Defaults in
`defaultConfiguration()` are all TRUE **except** `revision_log_message_input_display`, which is absent
from the defaults array (only read from submitted config).

## Embedded state-change forms

`build()` picks the form by entity type:

- Moderated entity → `ContentModerationInfoBlockModerationForm` (`src/Form/…ModerationForm.php`),
  **extends core `content_moderation\Form\EntityModerationForm`**. It hides the "current state" item,
  relabels the select to "Action", replaces target-state labels with **transition** labels, and drops
  the option equal to the current state. The offered options come from
  `$this->validation->getValidTransitions($entity, $this->currentUser())`, so only transitions valid
  for the current user appear; core's moderation-state constraint validates the chosen transition on save.
  Revision-log row `#access` follows `revision_log_message_input_display`.
- Non-moderated but publishable entity (`EntityPublishedInterface`) →
  `ContentModerationInfoBlockPublishForm` (`src/Form/…PublishForm.php`), a plain `FormBase`. Shows a
  disabled Publish/Unpublish select + Apply; `submitForm()` flips `setPublished()`/`setUnpublished()`,
  creates a new revision, sets the revision-log message, and saves.

## Related docs

- End-user / editor guide → [../human-docs/index.md](../human-docs/index.md)
- Prose overview + keyword list → [../usage.md](../usage.md)

No subdocs: the module is a single block plugin with block-level config and two small forms; the detail
above is complete.
