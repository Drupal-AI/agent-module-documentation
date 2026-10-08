# Entity Access Password Session Backend — agent index

Stores Entity Access Password "unlocked" grants in the PHP **session** (works for anonymous users).
No config, no permissions, no UI. Enable and it participates automatically.

Single service `Drupal\entity_access_password_session_backend\Service\SessionBackend`, tagged both
`entity_access_password_access_storage` and `entity_access_password_access_checker`.

- Session key: `entity_access_password`. Grants stored as
  `[entity_type][bundle][uuid] = uuid` (per entity), `[entity_type][bundle]['bundle_access'] = TRUE`
  (bundle), and `['global_access'] = TRUE` (global).
- Read methods answer `hasUserAccessToEntity/Bundle` and `hasUserGlobalAccess` from that session data.
- Enable at least one backend (this or `entity_access_password_user_data_backend`) or granted access is
  never remembered. See parent [../../../../2.0.x/agent/extend/backends.md](../../../../2.0.x/agent/extend/backends.md).
