# website_feedback — permissions

From `website_feedback.permissions.yml`, enforced by
`WebsiteFeedbackAccessControlHandler`:

| Permission | Gates |
|---|---|
| `administer website feedback` | Settings form; is the entity `admin_permission` (full access). Marked `restrict access: true`. |
| `create website feedback` | Submit feedback. **Also controls whether the floating button/library is attached** to pages (`hook_page_attachments`). |
| `view website feedback` | View feedback entities (`/website_feedback/{id}` canonical + collection rows). |
| `edit website feedback` | Edit feedback and its administrative fields (`uid`, `status`, `created`). |
| `delete website feedback` | Delete feedback (single + bulk delete routes). |

Notes:
- `update`/`delete` access = the matching permission **OR** `administer website feedback`.
- Admin fields (`uid`, `status`, `created`) are edit-gated by `edit`/`administer` even on
  the edit form (`checkFieldAccess`).
- To expose the widget to end users, grant `create website feedback` to the relevant role
  (e.g. authenticated, or anonymous). Doing so means those users can create entities and
  upload images/screenshots.
