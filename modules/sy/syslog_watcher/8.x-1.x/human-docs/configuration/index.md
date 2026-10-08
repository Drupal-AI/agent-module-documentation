# Configuration

Syslog Watcher does not add a settings screen of its own — it reuses Drupal's core
logging configuration. You tell it which file to read, and how to split each line,
on the standard **Logging and errors** page.

## Open the settings

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Go to **Configuration → Development → Logging and errors**
   (`/admin/config/development/logging`, the `system.logging_settings` route).

## What to configure

- **The syslog file to read.** Point Syslog Watcher at the file your site logs to
  (the same file you configured core Syslog to write). The viewer reads this path,
  seeks to the end to count the lines, and pages through them — so it must be the
  correct file and it must be readable by the web server user.
- **The field separator.** Syslog Watcher parses each line according to your site's
  Syslog **format** string. If you have changed the separator used in that format,
  set the matching separator here so the parser can split each line correctly into
  its Type / Timestamp / Message / User columns. Lines that do not parse cleanly are
  shown through an admin-filtered fallback rather than being dropped.

Save the Logging and errors page, then return to **Reports → Syslog Watcher**
(`/admin/reports/syslog-watcher`) and confirm the entries are parsed into readable
columns. If the columns look wrong, revisit the separator and format settings so they
match how your syslog lines are actually written.

## Who can see it

Both the overview and the per-line detail page require the core **Access site
reports** permission, a restricted admin permission — so the log contents stay
limited to trusted users and are not exposed to anonymous visitors.
