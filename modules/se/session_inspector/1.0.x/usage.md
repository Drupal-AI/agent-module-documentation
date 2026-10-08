<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Session Inspector allows users to inspect and manage their own sessions, seeing active sessions and terminating them.

---

Session Inspector gives users visibility and control over their own active sessions: they can see a
list of their current sessions (with contextual details) and terminate sessions they don't recognise —
the "active sessions / sign out other devices" feature familiar from major accounts. It depends on core
User, is configured at `session_inspector.config`, and provides its own permissions; it ships test
submodules for its events/plugins.

Use it to improve account security hygiene — letting users end sessions after using a shared computer
or if they suspect compromise. It is a positive security feature (self-service session management). It
reads and manages the session store for the current user; access is scoped to a user's own sessions via
its permission. Consider what session details it exposes and ensure the permission is granted
appropriately.

---

- Let users view their active sessions.
- Terminate a session from another device.
- Sign out other devices.
- Improve account security hygiene.
- End sessions after shared-computer use.
- Depend on core User.
- Configure at session_inspector.config.
- Provide its own permissions.
- Scope to a user's own sessions.
- Manage the session store per user.
- Show contextual session details.
- Help users respond to compromise.
- Provide self-service session management.
- List current sessions.
- Revoke unrecognised sessions.
- Grant the permission appropriately.
- Offer an active-sessions view.
- Enhance user security control.
- Let users end their sessions.
- Support session hygiene.
