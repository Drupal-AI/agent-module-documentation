# Workflow & smart-revisions formatter

## Setup
1. Enable: `drush en localgov_page_components_workflow -y`.
2. On the content type using the Page components field, *Manage display* → set the field's
   formatter to **Page components (smart revisions)**
   (`localgov_page_components_workflow_formatter`).
3. At `/admin/config/workflow/workflows`, edit the **Page components** workflow and confirm it
   applies to "All Page component types" (`paragraphs_library_item`).
4. When editing a component, set moderation state to **Draft** before saving to keep it hidden;
   saving as **Published** exposes it immediately.

## The workflow config
`config/install/workflows.workflow.page_components.yml`: `content_moderation` type, id
`page_components`, states `draft` (published:false) and `published` (published:true,
default_revision:true), transitions create_new_draft / publish, applied to entity type
`paragraphs_library_item`, `default_moderation_state: draft`.

## Cascade — `src/Hook/NodeHooks.php`
`#[Hook('node_update')] updateNode()`: when a node with a non-empty `moderation_state` is saved,
for every entity referenced by `localgov_page_components` that is a `LibraryItemInterface`:
- `setNewRevision(TRUE)`, `status = 1`.
- `moderation_state` = `published` if node state is `published`, else `draft` (draft/review and
  any other/custom state all map to draft).
- Sets an auto-sync revision log message.
- `processParagraphs()` / `processNestedParagraphs()` recurse through `paragraphs` and
  `entity_reference_revisions` fields, creating new revisions of each nested paragraph
  (`status = 1`) and re-pointing `target_revision_id` to the latest revision.
- `component->save()`.

`#[Hook('page_attachments')] pageAttachments()` attaches library
`localgov_page_components_workflow/page_components` only when the active theme is the admin theme.

## Formatter — `PageComponentsFieldFormatter`
`src/Plugin/Field/FieldFormatter/PageComponentsFieldFormatter.php` (for `entity_reference`):
- On route `entity.node.latest_version` → renders each component's **latest** revision and swaps
  in the latest revision of every nested paragraph (`applyLatestParagraphs()`), forcing `status = 1`.
- Otherwise → renders the latest **published** revision. `getPublishedRevisionId()` queries all
  revisions (`accessCheck(TRUE)`, newest first) and returns the first whose `moderation_state`
  is `published`; renders it with `status = 1`.
