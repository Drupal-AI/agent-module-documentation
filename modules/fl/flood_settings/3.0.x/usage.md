Flood settings adds an admin form at `/admin/config/system/flood` that edits Drupal core's `user.flood` configuration (the failed-login flood limits) without needing `drush` or `settings.php`.

---

Drupal core protects the login form with its flood system but ships no UI to tune it — the limits live in the `user.flood` config object and are normally only editable via config import or `settings.php`. Flood settings provides a single `ConfigFormBase` form (`Drupal\flood_settings\Form\FloodSettings`) that reads and writes five keys of that core config: `uid_only`, `ip_limit`, `ip_window`, `user_limit`, `user_window`. Occurrence limits are offered as a fixed select list (1–500) and time windows as human-readable interval options (1 minute – 1 day, plus "None (disabled)" for the windows). The form is gated by the module's own `manage flood settings` permission and linked under *Configuration → System → Flood settings*. There is no config schema, no Drush command, and no plugin of its own — it is purely a thin editor over core's existing flood config. Changing these values takes effect immediately for the core user-login flood checks (`user_failed_login_ip` and `user_failed_login_user` events).

---

- Tune how many failed logins from one IP are allowed before that IP is temporarily blocked (`ip_limit`).
- Change the time window over which failed-login attempts per IP are counted (`ip_window`).
- Set the per-username failed-login limit before that account is temporarily blocked (`user_limit`).
- Change the per-username counting window (`user_window`).
- Enable the "Username only" mode (`uid_only`) so flood events are tracked per account regardless of IP — the strictest option.
- Loosen flood limits temporarily during a legitimate traffic spike or load test.
- Tighten flood limits in response to a brute-force campaign against the login form.
- Give a non-developer site admin a UI to manage login lockout behaviour instead of editing `settings.php`.
- Disable an IP or user window entirely by selecting "None (disabled)".
- Delegate flood-limit management to a specific role via the `manage flood settings` permission.
- Review the current effective flood configuration at a glance in the admin UI.
- Standardise flood settings across environments by exporting the resulting `user.flood` config.
- Recover from accidental account lockouts by widening the limits, then flushing flood entries.
- Harden a public-facing site's login page against credential-stuffing by lowering the IP limit.
- Keep flood limits in sync with an organisation's security policy through a discoverable admin form.
- Experiment with flood thresholds on staging before promoting the `user.flood` config to production.
