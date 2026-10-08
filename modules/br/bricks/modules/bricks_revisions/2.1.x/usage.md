Bricks Revisions adds a `bricks_revisioned` field type built on Entity Reference Revisions, so a Bricks drag-and-drop tree references revisions of its brick entities and stays in step with the host entity's revision history.

---

The submodule defines the `bricks_revisioned` field type (`BricksTreeRevisionedItem`, extending core `EntityReferenceRevisionsItem` and mixing in the parent's `BricksFieldTypeTrait`, so it carries the same `depth` and serialized `options` as the core `bricks` field) plus an ERR-aware formatter `bricks_revisions_nested` (`BricksRevisionsNestedFormatter` extending `EntityReferenceRevisionsEntityFormatter`). Its default widget is `bricks_tree_autocomplete` and default formatter is the parent's `bricks_nested`, which also accepts `bricks_revisioned`. Because the field stores references to entity *revisions*, each referenced brick is tracked per revision, letting the whole nested tree participate in the host entity's create-new-revision and revert flow. The parent's `BricksServiceProvider` also registers a Replicate event subscriber keyed on `bricks_revisioned` when the Replicate module is installed, so cloning duplicates the referenced revisions. Depends on `bricks` and `entity_reference_revisions`; provides config schema; no config UI, permissions, Drush, or hooks of its own.

---

- Keep revisions of referenced bricks aligned with the host node's revisions.
- Revert a page to a previous state, including its nested bricks.
- Use Bricks in a content workflow that relies on revisions or content moderation.
- Track per-revision changes to a bricks tree via entity_reference_revisions.
- Clone revisioned bricky content correctly when the Replicate module is installed.
- Render revisioned bricks recursively with the `bricks_revisions_nested` formatter.
- Build a page builder where component edits are versioned with the page.
- Combine revisioned bricks with the inline, paragraphs, or dynamic Bricks widgets.
- Support content staging and preview flows that depend on revisions.
- Reference an ERR-based Paragraphs bundle as a revisioned brick.
- Keep referenced bricks in sync with a moderated node's revisions.
- Diff or audit a page's bricks across host revisions.
- Preserve `depth` and per-item `options` per revision.
- Version component edits alongside the host entity for editorial accountability.
- Underpin a preview/publish workflow for a Bricks-built page.
- Add a `bricks_revisioned` field to any entity type that supports revisions.
- Choose `bricks_revisioned` over the plain `bricks` field when content history is required.
- Migrate a Paragraphs-based layout to a revisioned Bricks tree.
- Restore a whole nested component tree when rolling back a node revision.
- Let any entity_reference_revisions widget edit the revisioned bricks tree.
