# login_security — agent start

Hardens the core login form against brute-force attacks: tracks failed logins (username + IP +
timestamp) in the `login_security_track` table via `hook_form_alter` validators, then blocks user
accounts and/or host IPs after configurable thresholds within a sliding time window. Hard IP bans
are delegated to the core **Ban** module (or contrib **AdvBan**) — one must be installed. Runs
alongside Drupal core's login flood control, not instead of it. Config UI:
**Admin → Configuration → People → Login Security** (`/admin/config/people/login_security`);
settings route `login_security.settings`, gated by core `administer site configuration`.

- All settings: per-user & per-host limits, soft/hard blocking, tracking window, attack detection,
  notifications, hiding core errors → [configure/login_security.md](configure/login_security.md)

No permissions of its own (uses core `administer site configuration`). No Drush commands, no
public plugin types, no submodules. Config schema: `config/schema/login_security.schema.yml`.
