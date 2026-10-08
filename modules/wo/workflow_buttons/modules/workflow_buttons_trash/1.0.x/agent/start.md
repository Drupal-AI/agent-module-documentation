# Trash workflow (workflow_buttons_trash) — agent index

Ships one Content Moderation workflow with a soft-delete **Trash** state (+ restore transitions).
Submodule of `workflow_buttons` but does not require it. Requires `workflows` +
`content_moderation`. **No settings form, no config schema, no permissions of its own, no Drush.**

- **The shipped workflow: states, transitions, how to apply it** →
  [configure/workflow.md](configure/workflow.md)
- Parent module (the buttons UI) → `../../../1.0.x/agent/start.md`

Key facts:
- Installs config **`workflows.workflow.workflow_buttons_trash_publishing`** ("Publishing (with
  draft and soft delete)"), type `content_moderation`, `default_moderation_state: draft`.
- States: `draft`, `published`, **`trash`** (unpublished, default_revision), `unpublished`.
- Key transitions: **`delete`** (draft/published/unpublished → `trash`), **`restore_draft`**
  (trash → draft), **`restore_publish`** (trash → published), plus publish/unpublish/update/save.
- Registers a **"Trash"** local task under Content → `/admin/content/trash`
  (route `workflow_buttons_trash.admin_trashed_content`, permission "view any unpublished
  content"). In this release that route has a title + permission only (no controller ships).
- Apply the workflow to content types under *Configuration → Workflows*; not auto-assigned.
