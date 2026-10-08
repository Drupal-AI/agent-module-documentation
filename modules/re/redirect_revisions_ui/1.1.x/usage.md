<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect Revision UI surfaces the standard entity revision interface for Redirect entities — a version history page, individual revision view, and revert/delete forms — which the Redirect module tracks but does not expose in the UI by default.

The module ships four permissions — `view any redirect history`, `view any redirect revisions`, `revert any redirect revisions`, `delete any redirect revisions` — and a `RouteSubscriberBase` (`RedirectRevisionsUiEventSubscriber`) that marks the core-provided redirect revision routes (`entity.redirect.version_history`, `entity.redirect.revision`, `entity.redirect.revision_revert_form`, `entity.redirect.revision_delete_form`) as admin routes so they render in the admin theme. This lets you audit who changed a redirect and roll back to a previous target.

Operational/security notes: access to each revision route is governed by these dedicated permissions (and core's redirect access), so history viewing, reverting and deleting can be granted independently to trusted roles. The event subscriber only flips the `_admin_route` option on existing routes; it does not create endpoints or weaken access. No anonymous or mutating public endpoints.
---
Add version history, revert and delete UI for Redirect entities behind dedicated revision permissions.
---
- View a redirect's full revision history page.
- Inspect an individual past revision of a redirect.
- Revert a redirect to a previous revision.
- Delete a specific redirect revision.
- Grant `view any redirect history` to auditors.
- Grant `view any redirect revisions` for detailed review.
- Grant `revert any redirect revisions` to editors who roll back.
- Grant `delete any redirect revisions` to cleanup roles.
- Audit who changed a redirect target and when.
- Roll back an accidental redirect change.
- Render revision routes in the admin theme automatically.
- Separate view vs revert vs delete rights across roles.
- Combine with the Redirect module's built-in revisioning.
- Review redirect changes as part of a content workflow.
- Keep a change trail for compliance on URL redirects.
- Recover a previous redirect destination after a bad edit.
- Expose revision routes without custom code.
- Restrict destructive revision actions to trusted users.
