# Autologout Alterable — agent index

Idle-timeout auto-logout, settable globally / per role / per user, with a warning dialog, a JSON
profile API, and events to alter the behaviour. Config at `/admin/config/people/autologout_alterable`
(route `autologout_alterable.settings_form`). No dependencies beyond core. Provides permissions,
config schema, events, a manager service, and a cron/queue path.

- **Global settings form, every config key, role timeouts, per-user threshold** →
  [configure/settings.md](configure/settings.md)
- **The permissions and exactly what each gates** →
  [permissions/autologout_alterable.md](permissions/autologout_alterable.md)
- **JSON profile API (GET/PATCH) and the `AutologoutManager` service** →
  [api/profile.md](api/profile.md)
- **The four alter events (`AutologoutEvents`) and how to subscribe** →
  [hooks/events.md](hooks/events.md)

Key facts:
- Base timeout `session_timeout` (default 1800s); role overrides in `autologout_alterable.role.*`;
  per-user threshold in `user.data`.
- Endpoints (require `_user_is_logged_in: TRUE`): `GET`/`PATCH /api/autologout_alterable/autologout-profile`.
- Central service `autologout_alterable.manager` (`AutologoutManagerInterface`); request-time activity via
  `AutologoutSubscriber`; optional server-side expiry via cron + `AutologoutSessionCheckWorker` (`use_cron`).
- Permissions: `administer autologout_alterable`, `change own autologout_alterable threshold`,
  `autologout_alterable infinite session timeout`.
