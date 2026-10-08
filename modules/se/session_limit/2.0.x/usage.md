Session Limit caps how many simultaneous active sessions a single user account may have, and reacts when the limit is exceeded by asking the user which session to end, dropping the oldest sessions, or blocking the new login.

---

Session Limit enforces a per-user cap on concurrent logins to curb account sharing and reduce the impact of compromised credentials. A single service (`session_limit`, class `Drupal\session_limit\Services\SessionLimit`) is registered as an event subscriber and runs on every kernel request (priority 32): it counts the user's rows in the core `sessions` table and, when the count exceeds their allowed maximum, dispatches a `session_limit.collision` event. The configured behaviour then decides what happens — `ACTION_ASK` (0, default) redirects the user to `/session-limit` to choose a session to end, `ACTION_DROP_OLDEST` (1) logs out the oldest sessions, and `ACTION_PREVENT_NEW` (2) destroys the just-created session and returns the user to anonymous. The limit itself is resolved with a precedence order: the highest per-role limit that applies to the user, otherwise the site-wide default `session_limit_max` (default 1); a role may be set to unlimited (`-1`). Admins configure everything at **Admin → Configuration → People → Session limit settings** (`/admin/config/people/session-limit`, route `session_limit.config_form`), which writes the `session_limit.settings` config object: default max, exceeded-behaviour, per-role limits, the logout message and its severity, whether User 1 is included, whether masqueraded sessions are ignored, and whether events are logged to Watchdog. Developers can steer enforcement through three events — `session_limit.bypass` (skip the check entirely), `session_limit.collision` (a limit was hit), and `session_limit.disconnect` (about to end a session; can be prevented or given a custom message). By default User 1 and anonymous users are never checked, and the `/session-limit` and `/user/logout` paths are always bypassed. The module ships config schema so its settings export cleanly, and provides a Drupal 7 migration for legacy session-limit variables.

---

- Restrict each account to a single active session to stop password sharing.
- Allow a small number of concurrent sessions (e.g. 2 or 3) for staff who work across devices.
- Automatically log out the oldest session when a user opens one too many (drop-oldest behaviour).
- Block a brand-new login when the user is already at their session limit (prevent-new behaviour).
- Prompt the user to pick which existing session to end when they exceed the limit (ask behaviour, the default).
- Give a specific role (e.g. administrators) unlimited sessions while capping everyone else.
- Set a higher session allowance for a trusted role using per-role overrides.
- Enforce a stricter default limit site-wide while relaxing it only for chosen roles.
- Show a custom "you have been logged out" message when a session is force-ended.
- Choose the severity (error / warning / status / none) of the logout message shown to kicked-out users.
- Include the User 1 super-admin account in session limiting for high-security sites.
- Exclude masqueraded sessions from the count so impersonation doesn't kick people off (with the Masquerade module).
- Log every session-limit enforcement to Watchdog for auditing.
- Reduce the blast radius of stolen credentials by preventing many parallel sessions.
- Enforce a "one seat per license" style policy on a membership or subscription site.
- Deploy session-limit settings between environments as exported configuration.
- Detect account sharing by reviewing logged collision events.
- Bypass the session check programmatically for trusted contexts via the `session_limit.bypass` event.
- Prevent a particular session from being disconnected in code via the `session_limit.disconnect` event.
- Customise the logout message per-disconnect from a custom event subscriber.
- React to a limit being hit (e.g. notify security) by subscribing to `session_limit.collision`.
- Count a user's currently active sessions in code via `getUserActiveSessionCount()`.
- Resolve a given user's effective maximum sessions in code via `getUserMaxSessions()`.
- Migrate Drupal 7 session_limit variables and per-role settings into the D11 config object.
- Keep HTTP and HTTPS sessions counted as one via the module's DISTINCT session queries.
