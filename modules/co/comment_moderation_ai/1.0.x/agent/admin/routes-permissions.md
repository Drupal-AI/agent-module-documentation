<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions, admin UI & Views

## Permissions (`comment_moderation_ai.permissions.yml`)

| permission | notes |
|------------|-------|
| `administer comment moderation ai` | `restrict access: true`; gates all four config forms + the admin menu block. |
| `view flagged comments` | route requirement for the reports page, the flagged-comments list and the comment-detail page. |
| `moderate flagged comments` | intended for taking action on flagged comments; declared for role assignment. |
| `bypass comment moderation` | owner with this perm skips moderation (`CommentModerator::moderateComment`). |

Grant `moderate flagged comments` (not just `view flagged comments`) to any role you intend to let
take moderation actions on the detail page.

`hook_install` grants the first three to `administrator` (and view/moderate to a `content_moderator`
role if present).

## Routes (`comment_moderation_ai.routing.yml`)

| route | path | handler | requirement |
|-------|------|---------|-------------|
| `.admin` | `/admin/config/comment-moderation-ai` | `SystemController::systemAdminMenuBlockPage` | `administer comment moderation ai` |
| `.settings` | `…/settings` | `CommentModerationAISettingsForm` | `administer comment moderation ai` |
| `.policies` | `…/policies` | `CustomPoliciesSettingsForm` | `administer comment moderation ai` |
| `.post_moderation` | `…/post-moderation` | `PostModerationSettingsForm` | `administer comment moderation ai` |
| `.reports` | `…/reports` | `ReportsController::overview` | `view flagged comments` |
| `.flagged_comments` | `…/flagged-comments` | `FlaggedCommentsController::listFlaggedComments` | `view flagged comments` |
| `.comment_details` | `/admin/content/flagged-comments/{comment_id}` | `FlaggedCommentsController::viewCommentDetails` | `view flagged comments` (`comment_id: \d+`) |

Admin menu link (`.links.menu.yml`) under Configuration; `configure: comment_moderation_ai.settings`
in `.info.yml`.

## Admin screens

- **Reports** (`ReportsController::overview`): overview stat table + quick-action/config links.
- **Flagged comments list** (`FlaggedCommentsController::listFlaggedComments`): paged (25/page)
  table via `#theme: flagged_comments_list`, with `FlaggedCommentsFilterForm` (status / flag source
  / date range) and a statistics `details`.
- **Comment detail** (`viewCommentDetails`): `#theme: flagged_comment_details` + embedded
  `CommentModerationActionsForm` (radios: approve = false positive, reject = confirm+unpublish,
  publish, unpublish; optional moderator notes; logs the action; redirects to the list).

## Views integration (`src/Plugin/views/`)

Field handlers: `ModerationStatus` (`@ViewsField("comment_moderation_ai_status")` — see PSR-4 bug),
`ModerationPriority`, `FlaggedIndicator`; filters: `ModerationStatusFilter`
(`comment_moderation_ai_status_filter`), `PriorityFilter` (`comment_moderation_ai_priority_filter`).
`hook_views_pre_view` injects these into the core `comment` view's `page_unapproved` display so
`/admin/content/comment/approval` shows moderation status/priority/flag columns and filters.

## Templates & assets

`templates/flagged-comments-list.html.twig`, `templates/flagged-comment-details.html.twig`;
`comment_moderation_ai/admin` library (`css/admin.css`, `js/admin.js`) attached by the controllers
and status field.

## Known functional bugs (from an incomplete `openai_comment_moderation` → `comment_moderation_ai` rename)

1. **Stale route names → fatal pages.** These reference non-existent `openai_comment_moderation.*`
   routes and raise `RouteNotFoundException`:
   - `CommentModerationAISettingsForm::buildForm()` "Additional Configuration" links → **General
     Settings page fatals**.
   - `flagged-comments-list.html.twig` line 70 (`path('openai_comment_moderation.comment_details')`)
     → **Flagged Comments list page fatals** while rendering.
   - `FlaggedCommentsFilterForm` reset link + `setRedirect('openai_comment_moderation.flagged_comments')`.
   The actual route names are `comment_moderation_ai.*`. Reach the settings sub-pages directly by
   URL (e.g. `/admin/config/comment-moderation-ai/policies`) and the detail page at
   `/admin/content/flagged-comments/{cid}`.
2. **PSR-4 mismatch.** `src/Plugin/views/field/ModerationStatus.php` declares class
   `CommentModerationAiStatus` (filename ≠ class) → the `comment_moderation_ai_status` views field
   fails to autoload.
3. **Undefined logger property** on `CommentModerator::handleCommentByStatus()` `auto_flagged_high`
   branch (`$this->logger` never set); swallowed by the hooks' try/catch.

Fixing the route names (and the class filename) is the first thing to do when adopting this module.
