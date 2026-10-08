# Login & Access Security (session_management) — agent index

miniOrange module: simultaneous-session limiting, inactivity auto-logout, IP login restriction, login
reports, and a per-user "my sessions" tab. Built on core `sessions` table + Views. Config gated by core
`administer site configuration`; no own permissions, no Drush. Provides a config schema. Many settings pages
are premium upsell.

- **All settings keys, admin routes, session-limit + autologout + IP-restriction behaviour** →
  [configure/settings.md](configure/settings.md)
- **Services (`mo_session_monitor`, `mo_login_restriction`), the logout controller, session access** →
  [api/services.md](api/services.md)

Key facts:
- Config object `session_management.settings` (schema only declares `enable_session_monitor`; other keys are
  read at runtime — see configure doc).
- Session limit enforced in `SessionLimitSubscriber` (KernelEvents::REQUEST): oldest `sessions` row rewritten
  to `uid 0` + warning message when count > `session_limit_count`.
- Autologout is JS-driven (`js/mo_logout.js` + `drupalSettings.session_management`); the
  `session_management.logout` route returns a CSRF-signed `user.logout` URL (POST, logged-in only).
- Per-user sessions tab `/user/{user}/mo_sessions`: custom access allows **only the owner** (and only when
  `enable_session_monitor`); the "Delete" action is a premium no-op here.
