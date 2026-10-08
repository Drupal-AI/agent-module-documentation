# session_limit — agent start

Caps the number of simultaneous active sessions per user account. A single event-subscriber
service (`session_limit`) counts rows in the core `sessions` table on every kernel request and,
when a user is over their limit, either asks them which session to end, drops the oldest
sessions, or blocks the new login. No module dependencies. Config UI:
**Admin → Config → People → Session limit settings** (`/admin/config/people/session-limit`);
route `session_limit.config_form` (gated by the core `administer site configuration` permission —
the module defines no permissions of its own).

- Max sessions, exceeded-behaviour, per-role limits & all settings → [configure/session_limit.md](configure/session_limit.md)
- Alter enforcement via events (bypass / collision / disconnect) + service API → [extend/session_limit.md](extend/session_limit.md)
