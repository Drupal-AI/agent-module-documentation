<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Timeout Notification warns authenticated users that their Drupal session is about to expire and offers a way to refresh (extend) the session before they are logged out and lose unsaved work. It ships a settings form at /admin/config/timeout_notification and a JS/CSS library that renders the countdown/notification.

---

The module reads the site's session lifetime and, via its front-end library, shows a notification a configurable interval before expiry with an option to keep the session alive. Its settings route is gated by a "configure_timeout_notification_settings" permission string.

Use it on editorial or member sites where users fill in long forms and would otherwise be silently logged out. Because expiry warning and refresh are driven client-side against the real session, users get a chance to act rather than losing their session unexpectedly. Note: the configuration route references the permission "configure_timeout_notification_settings", so confirm that permission is granted to the intended admin role when setting the module up.

---

- Warn users before their session expires.
- Offer a one-click session refresh.
- Prevent silent logout during long form entry.
- Show a countdown ahead of expiry.
- Preserve unsaved editorial work.
- Configure the warning lead time.
- Drive the notification via a JS/CSS library.
- Tie the countdown to the real session lifetime.
- Improve UX on member/editorial sites.
- Reduce lost-work support tickets.
- Provide an admin settings form.
- Gate settings behind an admin permission.
- Keep authenticated users informed of timeouts.
- Extend sessions without a full re-login.
- Notify users approaching inactivity limits.
- Support long-running admin workflows.
- Avoid abrupt session termination.
- Give editors control over their session.
