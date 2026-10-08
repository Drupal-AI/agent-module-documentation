Flood control exposes Drupal's otherwise-hidden flood limits (failed login thresholds and time windows) in an admin UI and lets you unblock IP addresses and user accounts that have been locked out after too many failed login attempts.

---

Drupal core protects login and contact forms with the "flood" system: after too many failed attempts from an IP or against a username, further attempts are blocked for a time window. Those thresholds live in the `user.flood` config object with no user interface, so tuning them normally requires editing configuration by hand. Flood control adds a settings form at Admin → Configuration → People → Flood control where you can edit the IP login limit and window, the username login limit and window, and (when the Contact module is enabled) the contact-form email limit and interval. It also adds a "Flood unblock" administrative screen listing currently blocked IPs and user IDs so an administrator can clear a lockout immediately instead of waiting for the window to expire. An IP allow-list (`ip_white_list`) lets trusted addresses bypass flood limits entirely, implemented by a decorator around core's `flood` service. Drush commands (`flood_unblock:ip` and `flood_unblock:all`) let you clear flood events from the command line. The module also ships a migration to carry Drupal 7 flood settings forward during an upgrade. It is a lightweight, dependency-free administration helper that turns an invisible core mechanism into something site builders and support staff can manage.

---

- Raise or lower the number of failed login attempts allowed per IP before blocking.
- Change the IP login time window (how long an IP stays blocked).
- Set the per-username failed-login limit to mitigate targeted brute-force attacks.
- Adjust the username login time window without editing YAML by hand.
- Loosen login flood limits temporarily during a large support/onboarding event.
- Tighten login limits on a high-value site to slow credential-stuffing attacks.
- Unblock a legitimate user who got locked out after mistyping their password.
- Unblock an office/NAT IP that hit the shared-IP login limit for many users.
- View a live list of currently blocked IPs and user IDs in one screen.
- Clear a specific IP's flood events from the command line with `drush flood_unblock:ip`.
- Clear all flood events site-wide with `drush flood_unblock:all` after testing.
- Whitelist trusted office or monitoring IPs so they never trip flood limits.
- Let an uptime/health-check service bypass login flood protection via the allow-list.
- Cap contact-form email sending rate to reduce spam abuse (with Contact module).
- Adjust the contact-form email interval for a busy support address.
- Give support staff a "flood unblock ips" permission without full admin rights.
- Restrict the settings page to trusted admins via "administer flood unblock".
- Diagnose why users report being locked out by inspecting the unblock list.
- Automate lockout clearing in deploy/reset scripts via Drush.
- Migrate Drupal 7 flood settings into Drupal 10/11 during an upgrade.
- Quickly reset flood state in a staging environment during QA of the login flow.
- Reduce false-positive lockouts behind a reverse proxy by tuning limits.
- Document and version-control flood thresholds as exportable configuration.
- Provide a self-service unblock workflow for a helpdesk role.
