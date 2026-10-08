# Entity Access Password User Data Backend — agent index

Persists Entity Access Password grants in core **user.data** keyed by user id. Authenticated only —
anonymous (uid 0) is a no-op. Adds admin forms to manually grant/revoke access without a password.

Service `Drupal\entity_access_password_user_data_backend\Service\UserDataBackend` (tagged access_storage +
access_checker). Grant keys: per-entity (`<type>:<uuid>`), per-bundle (`<type>:<bundle>`), and global.

- **Permissions gating the manual grant forms** → [permissions/permissions.md](permissions/permissions.md)
- Forms: global (`/admin/config/content/entity_access_password/user_data/global`), per-user
  (`/user/{user}/password_user_data`), plus per-bundle and per-entity forms added via
  `BundleFormRoutes`/`EntityFormRoutes` route callbacks and derivers for local tasks/menu links.
- Enable at least one backend (this or `entity_access_password_session_backend`) or granted access is never
  remembered. See parent [../../../../2.0.x/agent/extend/backends.md](../../../../2.0.x/agent/extend/backends.md).
