<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin notification lets a site administrator set a single message that is shown to all authenticated users via Drupal's messenger on every page request.
---
The module solves the need to broadcast a short site-wide notice (maintenance window, policy change, announcement) to logged-in users without editing content or blocks. An admin form at `/admin/config/system/admin_notification` (permission `administer admin notification`) stores three values in Drupal state: `admin_notification.enabled`, `admin_notification.message` and `admin_notification.type`.

A `KernelEvents::REQUEST` subscriber (`src/EventSubscriber/KernelSubscriber.php`) runs on every request; when the current user is authenticated and the feature is enabled with a non-empty message, it adds the message through the messenger service with the configured type (status/warning/error) and `repeat = TRUE`. The message therefore reappears on each page load until disabled. Only authenticated users see it; anonymous visitors never do. The message is added verbatim, so treat it as trusted admin-only input.

Setup is simply enabling the module, granting the permission, and filling in the form. There are no routes beyond the admin form, no anonymous or mutating endpoints, and no external calls.
---
- Enable a site-wide notice for all logged-in users.
- Announce a scheduled maintenance window to editors.
- Warn staff about a temporary policy or workflow change.
- Toggle the notice on or off from one settings form.
- Choose the message severity (status, warning, error).
- Post a reminder that shows on every admin page.
- Grant `administer admin notification` to a trusted role only.
- Clear the message to stop the banner immediately.
- Communicate a deploy freeze to content teams.
- Surface a legal/compliance reminder to authenticated users.
- Show an onboarding note to newly logged-in users.
- Broadcast a support contact during an incident.
- Display a "read-only mode" heads-up to editors.
- Use the error type to flag an urgent issue.
- Keep a persistent notice that repeats each request.
- Restrict visibility to authenticated users by design.
- Set the message via drush state:set for automation.
- Provide a lightweight alternative to a custom block.
- Remind users to update their profile or password.
- Announce a new feature to logged-in members.
