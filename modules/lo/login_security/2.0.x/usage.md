Login Security hardens Drupal's login form against brute-force and password-guessing attacks by tracking failed login attempts and blocking user accounts or host IP addresses after a configurable number of failures.

---

Login Security alters the core `user_login_form` with extra validation and submit handlers that record every login attempt (username + IP address + timestamp) in a `login_security_track` table. Each time the form is submitted it counts the tracked failures within a sliding **track time** window (in minutes) and applies limits: a per-user limit (`user_wrong_count`) that blocks the account, a per-host **soft** limit (`host_wrong_count`) that stops that IP from submitting the login form while still allowing anonymous browsing, and a per-host **hard** limit (`host_wrong_count_hard`) that IP-bans the host outright. Hard IP banning is delegated to the core Ban module (or the contrib AdvBan module) through the `login_security.ban` service, so one of those must be installed. An **attack-detection** threshold (`activity_threshold`) watches the total volume of failed attempts across the whole site and logs a warning and optionally emails administrators when a coordinated attack is under way. It can also hide core's login error messages to prevent username enumeration, warn users of remaining attempts, and show last-login / last-access timestamps on success. It runs alongside — not instead of — Drupal core's built-in login flood control, reading core's `flood_control_triggered` flag during validation. All behavior is driven by a single settings form at Administration → Configuration → People → Login Security, and expired tracking rows are cleaned up on cron. When the CrowdSec module is present it also emits a failed-login signal on each failure.

---

- Block a user account automatically after N failed login attempts, regardless of the attacking host.
- Soft-block an IP address so it can no longer submit the login form but can still browse anonymously.
- Hard-ban an IP address (via the Ban or AdvBan module) after too many failed logins from that host.
- Set a sliding tracking window (in minutes) after which old failed-attempt records expire and no longer count.
- Detect an ongoing distributed attack by watching the total volume of failed logins site-wide.
- Email administrators when the attack-detection threshold is crossed.
- Email administrators when a specific user account is blocked due to failed logins.
- Hide core's "Unrecognized username or password" errors to prevent username enumeration.
- Warn users how many login attempts remain before their account is locked.
- Show the user their last successful login timestamp when they sign in.
- Show the user their last site-access (activity) timestamp when they sign in.
- Customize every user-facing message (soft ban, hard ban, blocked account, remaining attempts) with tokens.
- Customize the subject and body of the blocked-account and attack-detection notification emails.
- Protect public sites where account lockout could be abused by tuning host limits instead of user limits.
- Complement core login flood control with per-account and per-IP thresholds it does not provide.
- Keep a persistent audit log of failed login attempts (username, IP, timestamp) in the database.
- Clear the entire failed-attempt tracking table on demand from the settings form.
- Automatically purge expired tracking events on cron runs.
- Reset a hard-attack alert automatically once activity drops back below a third of the threshold.
- Emit CrowdSec failed-login signals on each failed attempt when the CrowdSec module is installed.
- Unblock a locked-out account manually from the People admin screen (blocks are not auto-lifted).
- Remove a banned IP from the Ban module's banned-IP administration screen.
- Migrate Login Security settings and tracked data from a Drupal 7 site using the bundled migrations.
- Deploy Login Security thresholds and messages across environments as exported configuration.
- Gate access to the settings form behind the core "administer site configuration" permission.
