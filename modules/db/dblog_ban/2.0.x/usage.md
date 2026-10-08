Database logging ban operation adds a Ban/Unban link to database log (watchdog) rows so an administrator can ban the IP address that generated a log message, using Drupal core's Ban module.

---

The module surfaces the misbehaving IP addresses already recorded in Drupal's database log and lets an administrator ban or unban them in place. It ships a Views field handler (`dblog_ban_ban_unban_link`) that renders a "Ban @ip" link for unbanned IPs and an "Unban @ip" link for already-banned IPs, resolving the IP from a watchdog Views row (or by looking it up by log-entry `wid` when the hostname column is not selected). The link can operate either as a plain confirmation-form flow (nojs) or, when AJAX links are enabled in configuration, as an immediate one-click action that swaps the link out via an AJAX ReplaceCommand. Actions run through core's ban IP manager, so bans are stored and enforced by core Ban. The module reuses the core `ban IP addresses` permission for the ban/unban routes and adds one own permission (`change global dblog_ban settings`) for its settings form. It deliberately refuses to render a ban link for your own current request IP and for hostnames that do not validate as public IP addresses (private/reserved ranges are excluded). Because the field is separate from core's Operations column, you must add the "Ban/Unban link" field to the watchdog view (`/admin/structure/views/view/watchdog`) after enabling the module before the links appear at `/admin/reports/dblog`.

---

- Ban an IP address that repeatedly fails login attempts, straight from the Recent log messages report.
- Unban an IP address that was banned earlier, using the same log-based list.
- Add a one-click "Ban/Unban link" column to the watchdog view so moderators can act without leaving the log.
- Enable AJAX links so a ban takes effect immediately without losing your place in the log list.
- Disable AJAX links to require a confirmation page ("Are you sure you want to ban %ip?") before each ban.
- Curb comment or contact-form spammers by banning the source IPs seen in the log.
- Block IPs probing for `node/add`, CKEditor scripts, or admin/backend path prefixes.
- Quickly triage a flood of "Access denied" or "Page not found" log entries and ban the offending hosts.
- Ban an IP surfaced in a custom log-message view built on the watchdog table.
- Reuse core Ban's storage and enforcement without writing custom code to insert into the ban list.
- Prevent accidental self-ban: the link is never shown for the IP of your current request.
- Avoid errors from bogus hostnames: only values validating as public IPs (via `filter_var`) get a link.
- Restrict who can ban by assigning core's `ban IP addresses` permission to trusted roles only.
- Restrict who can toggle AJAX behavior via the `change global dblog_ban settings` permission.
- Configure the module at `/admin/config/user-interface/dblog_ban` from the User interface admin group.
- Migrate the Drupal 7 `dblog_ban_use_ajax_links` variable into `dblog_ban.settings` during a D7-to-D9/10 upgrade.
- Unban an IP by resolving it from a log row even when the view only exposes the `wid` column.
- Give site builders a log-driven alternative to core's manual "Banned IP addresses" admin form.
- Let editors act on abuse evidence (the log entry) and the remedy (the ban) in a single screen.
- Recover from an accidental self-ban using Drush or direct database access (the module warns this is possible on multi-IP setups).
