# Admin Feedback permissions

Defined in `admin_feedback.permissions.yml` (none are `restrict access: true`).

| Permission | Gates |
|---|---|
| `give feedback` | See and use the feedback block; POST to `/feedback_vote` and the comment form `/ajax/feedback_vote`. **Granted to `anonymous` and `authenticated` by `hook_install`** (and update 8001), so out of the box anyone can vote. |
| `administer admin feedback` | The settings form `/admin/feedback/settings`. |
| `view admin feedback dashboard` | The site-wide feedback dashboard `/admin/content/feedback`. |
| `view admin feedback detail view` | The per-node detail dashboard `/node/{nid}/feedback`, and the `mark inspected` / `mark uninspected` AJAX endpoints. |
| `export feedback data` | Batch export (`/export_feedback`) and CSV download (`/admin/feedback/download`). |
| `delete feedback` | Delete a single feedback entry (`/admin/content/feedback/{id}/delete`). |
| `delete all node feedback` | Delete all feedback for one node (`/admin/content/feedback/delete-all/{id}`). |

Notes:
- Because `give feedback` is auto-granted to anonymous on install, the vote/comment endpoints are
  reachable by the public by design. Abuse is mitigated in code by a per-node HMAC vote token,
  strict `yes`/`no` + existing-node validation, per-IP flood control, and one-comment-per-row signed
  tokens (see [../api/voting.md](../api/voting.md)) — not by the permission.
- The five admin permissions (`administer…`, `view…`, `export…`, `delete…`) should be limited to
  trusted roles; they expose all collected feedback and its deletion.
