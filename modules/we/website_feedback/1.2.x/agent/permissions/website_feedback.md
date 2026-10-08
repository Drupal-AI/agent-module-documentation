<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# website_feedback — permissions

From `website_feedback.permissions.yml`, enforced by `WebsiteFeedbackAccessControlHandler`:

| Permission | Gates |
|---|---|
| `administer website feedback` | Settings form (`website_feedback.settings`); is the entity `admin_permission` (full access). Marked `restrict access: true`. |
| `create website feedback` | Submit feedback (routes `website_feedback.frontend_add` + `entity.website_feedback.add_form`). **Also controls whether the floating button/library is attached** to pages (`hook_page_attachments`). |
| `view website feedback` | View feedback entities (canonical `/admin/content/website-feedback/{id}` + collection rows). |
| `edit website feedback` | Edit feedback and its administrative fields (`uid`, `status`, `created`); also required for the per-row `toggle_status` (via `_entity_access: website_feedback.update`). |
| `delete website feedback` | Delete feedback (single delete + multiple/bulk delete routes). |

Notes:
- `checkAccess()`: view/update/delete each = the matching permission **OR** `administer website feedback` (`AccessResult::allowedIfHasPermissions(..., 'OR')`). `checkCreateAccess()` = `create` OR `administer`.
- `checkFieldAccess()`: the admin fields `uid`, `status`, `created` are edit-gated by `edit`/`administer` even on the edit form; the public add form additionally hides `uid`/`created`/`url`/`status`.
- To expose the widget to end users, grant `create website feedback` to the relevant role; the front-end submit route is permission-gated (not anonymous by default) and non-admin submissions are flood-limited (`flood_limit`/`flood_window`).
