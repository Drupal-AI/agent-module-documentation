Access-storage backend for Entity Access Password that records "this visitor has unlocked entity/bundle/global" in the PHP session, so it works for anonymous users.

---

This submodule provides a single service, `SessionBackend`, tagged as both an `entity_access_password_access_storage` (write) and an `entity_access_password_access_checker` (read). When a password is validated, the parent module calls the storage to remember access; this backend writes the grant into the session under the `entity_access_password` key, indexed by entity UUID, bundle, or a global flag. On later requests it answers whether the current session already unlocked a given entity/bundle/global scope. Because it uses the session (not user data), it is the backend to enable when protected content must be reachable by **anonymous** visitors. It has no config, no permissions, and no UI — enable it and it participates automatically. Enable it (or the user-data backend) or granted access is never remembered.

---

- Let anonymous visitors unlock a password-protected page and keep access for the rest of their session.
- Remember per-entity unlocks (by UUID) within a browser session.
- Remember a bundle-wide unlock so one password opens every entity of that bundle for the session.
- Remember a global-password unlock for the session.
- Provide the read + write halves of Entity Access Password without persisting anything server-side per user.
- Use as the default lightweight backend on mostly-anonymous sites.
- Combine with the user-data backend (session for anonymous, user-data for authenticated).
- Reset a visitor's access simply by ending/clearing their session.
- Avoid database writes on each successful unlock (session-only storage).
- Serve as the reference implementation when writing a custom access backend.
- Gate content for logged-out previewers without touching their user record.
- Keep unlock state isolated per browser rather than per account.
- Support kiosk/shared-device flows where access should not persist across sessions.
- Pair with flood control so session unlocks still respect rate limits at the form.
- Enable with `drush en entity_access_password_session_backend -y`.
- Works for both anonymous and authenticated users (session exists for both).
