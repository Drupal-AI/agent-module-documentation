Access-storage backend for Entity Access Password that persists "this user has unlocked entity/bundle/global" in Drupal's user.data store, keyed per authenticated user; it does nothing for anonymous users.

---

This submodule provides `UserDataBackend`, tagged as an `entity_access_password_access_storage` and the matching checker, storing grants via the core `user.data` service keyed by user id. Because grants live on the user record, access **persists across sessions and devices** for logged-in users; anonymous users (uid 0) are ignored entirely (use the session backend for them). On top of automatic storage on successful password entry, the submodule adds **admin forms** to view and manually grant/revoke access without the user entering a password: a global form, per-bundle forms, per-entity forms, and a per-user form at `/user/{user}/password_user_data`. Each form is gated by its own `restrict access: TRUE` permission. Route callbacks derive the bundle/entity forms dynamically, and local tasks/menu links are provided by derivers. No config or schema of its own.

---

- Persist a user's unlocked entities across logins and browsers (stored on the user record).
- Manually grant a specific user access to a protected entity without giving them the password.
- Manually grant a user bundle-wide or global access from an admin form.
- Revoke a user's previously granted access from the same forms.
- Review all access data for one user at `/user/{user}/password_user_data`.
- Give editorial/support staff a way to unlock content for a customer on request.
- Use per-entity access grants for one-off exceptions (e.g. a single premium article).
- Keep unlock state tied to accounts for audit/consistency instead of ephemeral sessions.
- Combine with the session backend so anonymous users use sessions and members use persistent data.
- Grant the four admin-form permissions selectively to trusted roles only.
- Automatically remember an authenticated user's correct password entry for future visits.
- Avoid re-prompting logged-in users who have already unlocked content.
- Enable with `drush en entity_access_password_user_data_backend -y`.
- Ignore anonymous traffic deliberately (uid 0 is a no-op) to keep user data clean.
- Drive per-bundle grant forms that are generated per fieldable bundle via route callbacks.
