<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Revision Delete

Deletes surplus node revisions on a schedule, keeping a configurable number while never deleting revisions that are the current default or the latest moderation state.

- Prevents the `node_revision` and related tables from growing indefinitely on editorial sites.
- Understands Content Moderation, so it will not prune revisions that back a live/published or pending moderation state.
- Runs automatically (cron/queue) once configured, with an admin settings form to tune retention.
- Includes a developer form for inspecting/triggering behaviour during setup.

---

## Installation & configuration

- Requires the core `node` and `content_moderation` modules; enable with `drush en cm_revision_delete`.
- Configure at `/admin/config/content/cm_revision_delete` (permission: `administer cm_revision_delete`).
- A developer tools form lives at `/admin/config/content/cm_revision_delete/devel` (same permission).
- Set how many revisions to keep per node and which content types/states participate.
- The admin routes are `_admin_route: TRUE` and gated by the module's own permission.

---

## Usage & API

- Provides the permission `administer cm_revision_delete` controlling access to both configuration routes.
- `AdminSettingsForm` stores retention configuration (revisions to keep, applicable bundles).
- `DevelForm` offers a developer-facing way to exercise the pruning logic while configuring.
- Pruning is performed against nodes, honouring Content Moderation so in-use revisions are retained.
- The default and latest-revision safeguards mean the current published content is never removed.
- Retention is expressed as a count of revisions to preserve per node.
- Both routes are standard `FormBase` forms, so Drupal's form token (CSRF) protection applies.
- No public/anonymous routes are exposed; all interaction requires the admin permission.
- Useful on long-running editorial sites where every save creates a forward revision.
- Combine with a working cron to keep revision growth in check automatically.
- Safe to install on an existing site; it only removes revisions beyond the retention window.
- Does not delete entities themselves, only historical revisions of nodes.
- Only node revisions are targeted; other entity types are out of scope.
- Test retention settings on a staging copy before enabling on production data.
- Review which moderation states you consider "keepable" before first run.
- Back up the database before the first large prune on a site with deep revision history.
