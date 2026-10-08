<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Live Status lets each authenticated user set a personal presence status — online, busy, away or offline — shown as a colored indicator in the admin toolbar.
---
The module adds a `user_status` field to users and a toolbar tray (`UserLiveStatusHooks::toolbar`) with links to set each status; the current status renders as a colored dot via the module's CSS library. Choosing a status hits `/admin/user-live-status/{status}` (`UserLiveStatusController::setStatus`, permission `access toolbar`), which updates only the *current* user's own account, invalidates that user's cache tags, and redirects back to the referring page. The status is displayed only in the owner's own toolbar — it does not expose other users' presence.

Setup is zero-config: enable the module and authenticated users get the status control in their toolbar.
---
- Let users set their presence status from the toolbar.
- Show a colored online/busy/away/offline indicator.
- Update a user's own status via the toolbar tray.
- Communicate availability at a glance in the admin UI.
- Store the status in the `user_status` user field.
- Invalidate the user's cache when status changes.
- Set status to "online".
- Set status to "busy".
- Set status to "away".
- Set status to "offline".
- Restrict the control to roles with `access toolbar`.
- Redirect back to the current page after setting status.
- Style the status indicator via the module CSS.
- Add lightweight presence to an intranet/dashboard.
- Signal focus/availability to collaborators.
- Default new users to "offline".
- Keep the indicator visible while navigating admin.
- Support Drupal 10.3+ and 11.
- Extend the status list in code if needed.
- Provide a minimal, dependency-free presence widget.
