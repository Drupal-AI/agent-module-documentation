Trash workflow ships a ready-made Content Moderation workflow that adds a soft-delete "Trash" state, so editors can send content to a recycle bin (and restore it) instead of permanently deleting it. It pairs naturally with Workflow buttons but does not require it.

---

Enabling the submodule installs one content_moderation workflow, `workflow_buttons_trash_publishing` ("Publishing (with draft and soft delete)"), with four states — **Draft**, **Published**, **Trash** (unpublished, default_revision), and **Unpublished** — and transitions that model a soft-delete lifecycle: `create_new_draft`, `save_draft_leave_current_published`, `publish`, `unpublish`, `update`, `save_unpublished`, a **`delete`** transition (from draft/published/unpublished → **trash**), and two restore transitions, **`restore_draft`** (trash → draft) and **`restore_publish`** (trash → published). Its `default_moderation_state` is `draft`. Because "delete" is a workflow transition, when combined with Workflow buttons it appears as a red danger "Delete" button that trashes rather than destroys content. The submodule also registers a **"Trash"** local task under *Content* pointing at `/admin/content/trash` (route `workflow_buttons_trash.admin_trashed_content`, permission "view any unpublished content"); in this release that route defines a title and permission only (no controller ships with it), so the workflow itself is the substance. To use it, apply the `workflow_buttons_trash_publishing` workflow to your content types under *Configuration → Workflows*. It requires core `workflows` and `content_moderation`, has no settings form, permissions of its own, config schema, or Drush commands.

---

- Give editors a soft-delete "Trash" state instead of permanently deleting content.
- Let content be restored from Trash back to Draft or straight to Published.
- Apply a complete draft → published → trash publishing workflow in one click.
- Combine with Workflow buttons so "Delete" is a red button that trashes content.
- Keep accidentally-removed content recoverable rather than gone.
- Model an editorial lifecycle with draft, published, unpublished, and trash states.
- Provide a "Restore and Publish" one-step recovery from Trash.
- Provide a "Restore to Draft" recovery that keeps content unpublished for re-review.
- Unpublish content without trashing it (separate Unpublish transition).
- Create a draft off a published node while leaving the live version published.
- Use as a starting-point workflow to customise (add states/transitions) for a site.
- Surface a "Trash" tab under the Content admin for trashed items.
- Standardise soft-delete behaviour across multiple content types.
- Reduce the risk of irreversible content deletion by non-technical editors.
- Pair trash + restore transitions with per-transition permissions from core Workflows.
- Migrate from hard deletes to a reversible trash model without custom code.
