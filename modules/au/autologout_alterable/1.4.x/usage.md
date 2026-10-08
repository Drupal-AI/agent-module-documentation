Autologout Alterable logs users out after a configurable period of inactivity, with the timeout settable globally, per role, or per individual user, an optional warning/countdown dialog before logout, and a rich set of events + a JSON API so other modules (including decoupled front-ends) can alter or drive the behaviour.

---

Inspired by the classic Autologout module but built to be "alterable", it tracks each user's last activity (updated on every request server-side, and on client interaction — mouse/touch/click/keydown/scroll — via `js/autologout-profile-handler.js`) and logs them out once the inactivity threshold passes. The base timeout comes from config (`session_timeout`, default 1800s), optionally overridden by role timeouts (`autologout_alterable.role.*`) or a per-user threshold stored in `user.data` (exposed as a field on the user form, gated by `change own autologout_alterable threshold` / `administer autologout_alterable`). Users with the `autologout_alterable infinite session timeout` permission are never auto-logged-out by this module (but other modules may still alter it). Before expiry a configurable modal (`show_dialog`, `dialog_limit` seconds before, titles/messages/button texts, countdown format) offers to extend the session. Two JSON endpoints let a client read and update the profile: `GET`/`PATCH /api/autologout_alterable/autologout-profile` (both require `_user_is_logged_in: TRUE`) — GET returns lastActivityAgo / sessionExpiresIn / extendible / redirectUrl; PATCH sets `lastActiveAgo` (only non-negative values, i.e. it can only *report* activity, never extend past a max) or forces a logout with `forceLogout: true`. Server-side, an event subscriber updates activity per request, and an optional cron path + queue worker (`use_cron`) invalidates expired sessions server-side without user interaction. The whole flow is customisable through four events (`AutologoutEvents`): alter-enabled, set-last-activity, and profile-alter (request and cron variants) — e.g. to disable autologout for certain users/routes, feed activity from an SSO/decoupled system, or adjust expiry/redirect. Central logic lives in the `autologout_alterable.manager` service (`AutologoutManagerInterface`). Configure at `/admin/config/people/autologout_alterable`; settings are config-translatable.

---

- Automatically log out users after N seconds of inactivity site-wide.
- Set a longer or shorter timeout for specific roles (e.g. admins get less, editors more).
- Let a user set their own logout threshold on their profile (bounded by `max_session_timeout`).
- Exempt trusted users from auto-logout with the "infinite session timeout" permission.
- Warn users with a countdown modal before they are logged out, offering to stay signed in.
- Customise the dialog title, message, button labels and countdown format.
- Force a hard maximum session length that cannot be extended (`max_session_length`).
- Log users out regardless of activity after the timeout (`ignore_user_activity`).
- Redirect users to a specific place after logout, optionally preserving the destination.
- Show a tailored message after inactivity logout vs an induced logout.
- Meet security/compliance requirements for idle session termination (e.g. PCI/HIPAA-style policies).
- Clean up expired sessions server-side via cron + queue worker even if the browser tab is closed.
- Choose which client interactions count as activity (mouse move, touch, click, keydown, scroll).
- Allowlist specific IP addresses to bypass autologout.
- Drive session keep-alive/logout from a decoupled front-end via the JSON profile API.
- Feed last-activity from an external/SSO system using the set-last-activity event.
- Disable autologout for certain routes or user conditions via the alter-enabled event.
- Adjust the computed session expiry or post-logout redirect via the profile-alter event.
- Force a client-initiated logout by PATCHing `forceLogout: true`.
- Translate the dialog strings per language (config translation support).
- Keep autologout behaviour altered/extended by other modules without patching this one.
- Provide an "are you still there?" experience on kiosk or shared machines.
