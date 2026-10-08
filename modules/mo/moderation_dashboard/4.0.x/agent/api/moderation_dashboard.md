# API / programmatic surface — moderation_dashboard

The module defines **no public service API or plugin type of its own** — it is a bundle of
Views, blocks, conditions and a layout wired together. What you can reference programmatically:

## Shipped Views (config/optional)

| View id | Purpose |
|---|---|
| `moderation_dashboard` | Master view; its `page_1` display is the dashboard page (route `view.moderation_dashboard.page_1`, path `user/%user/moderation-dashboard`). Uses the custom `moderation_dashboard` Views access plugin. |
| `content_moderation_dashboard_in_review` | Content currently in a review state. |
| `moderation_dashboard_recent_changes` | Recently state-changed content. |
| `moderation_dashboard_recently_created` | Recently created content. |

These are **optional** config: they only import if their dependencies are met at install. Load
one with `\Drupal::entityTypeManager()->getStorage('view')->load('moderation_dashboard')`.

## Blocks (`src/Plugin/Block`)

| Block id | Admin label | Purpose |
|---|---|---|
| `moderation_dashboard_activity` | Moderation Dashboard Activity | Chart.js graph of the dashboard owner's editorial activity. |
| `moderation_dashboard_add_links` | Moderation Dashboard Add Links | Quick "create content" links for moderated types (wrapper class `moderation-dashboard-add-links`). |

## Conditions (`src/Plugin/Condition`)

| Condition id | Purpose |
|---|---|
| `has_moderated_content_type` | True when at least one content type is under content moderation. Used to gate the post-login redirect. |
| `moderation_dashboard_access` | Condition wrapper around the dashboard access check. |

## Views access plugin & field

- Views **access** plugin id `moderation_dashboard` (`Plugin/views/access/ModerationDashboard`)
  — delegates to the `moderation_dashboard.access_checker` service and sets the
  `_access_moderation_dashboard` route requirement.
- Views **field** plugin `link_to_latest_version` (`Plugin/views/field/LinkToLatestVersion`)
  — renders a link to an entity's latest (possibly unpublished) revision; add it to any View.

## Services (`moderation_dashboard.services.yml`)

| Service | Class | Role |
|---|---|---|
| `moderation_dashboard.response_subscriber` | `Routing\ResponseSubscriber` | Rewrites the post-login redirect to the dashboard when `redirect_on_login` is on and conditions match. |
| `moderation_dashboard.access_checker` | `Access\ModerationDashboardAccess` | Access check (`_access_moderation_dashboard`) for the dashboard route. |

## Hooks the module implements (via `src/Hook`, attribute-based)

- `hook_preprocess_links__toolbar_user` — injects the dashboard link into the user toolbar for
  users with `use moderation dashboard`.
- `hook_library_info_alter` — selects the local vs CDN Chart.js library based on `chart_js_cdn`
  and what is installed on disk.
- Block and Views hooks that assemble the dashboard.

The module invites no `hook_*` of its own (no `moderation_dashboard.api.php`); customise via
Views UI and Layout Builder instead — see [configure/moderation_dashboard.md](../configure/moderation_dashboard.md).
