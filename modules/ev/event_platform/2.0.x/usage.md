<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Event Platform is an install-time bundle that configures a Drupal site for a conference or Drupal Camp in one step.

---

Enabling the top-level module installs a set of submodules that each import content types, views, vocabularies and workflow config: Sessions (user-suggested sessions with a content-moderation approval workflow and accept/reject notifications, plus rooms, tracks and time slots), Speakers, Sponsors (grouped by tier), Ratings, Details (site hero/CTA/copyright blocks and metatag defaults), Job Listings, and a Scheduler that provides a drag-style UI for assigning sessions to rooms and time slots. It leans on several contrib dependencies (Add Content By Bundle, Auto Entity Label, Config Pages, Field Group, Field Permissions, Hide Revisions Field, Smart Date and ECA). An `event_platform_olivero` submodule also places all the blocks into Olivero regions.

Because the bundle mainly imports configuration, the top-level module can be uninstalled after setup (the created bundles remain); it cannot be re-installed on the same site unless those bundles are deleted first. The exception is the Scheduler submodule, which keeps a live UI and settings form. Scheduler routes at `/admin/event-details/scheduler` are gated by session-content edit permissions (`edit any session content`, `edit terms in time_slot`, `administer site configuration`); the ajax assign/unassign routes take a node parameter and require `edit any session content`. No anonymous or unauthenticated mutating endpoints.

---
- Install the whole event platform in one step by enabling the bundle.
- Use `event_platform_olivero` to auto-place blocks in Olivero regions.
- Enable only the submodules you need (e.g. just Sessions + Speakers).
- Let users suggest sessions through a moderated content type.
- Run sessions through an approval workflow with accept/reject notifications.
- Publish accepted sessions in a listing view.
- Associate sessions with rooms, tracks and time slots.
- Generate time slots with the Scheduler's time-slots form.
- Assign a session to a room/time slot via the scheduler UI.
- Unassign a scheduled session.
- Configure scheduler behavior via its settings form.
- Manage speakers as structured content.
- Display sponsors grouped by sponsorship tier (bronze/silver/gold).
- Collect ratings on sessions or content.
- Add job listings to the event site.
- Place the Home Hero block on the front page (Details submodule).
- Place Heading CTA and Copyright blocks in header/footer regions.
- Apply metatag defaults for event pages and articles.
- Uninstall the bundle after setup while keeping the created bundles.
- Recreate the site config by deleting bundles and reinstalling.
