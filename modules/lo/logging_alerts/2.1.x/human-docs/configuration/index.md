# Configuration

Each submodule you enabled has its own settings form, and both work the same way:
you decide **which severity levels** are routed to that destination. The whole
point is severity routing — sending the messages that matter to the place that can
act on them, and sending everything else nowhere.

Both forms require the core **Administer site configuration** permission (an
administrator by default).

## Email Logging and Alerts (`emaillog`)

Open **Configuration → Development → Email Logging and Alerts**, or go directly to
`/admin/config/development/emaillog`.

Here you map **severity levels to email recipients**. The value of the module is
that different severities can go to different addresses:

- Send **emergency** and **critical** messages to an on‑call address (for example
  a pager or mobile email) so someone is alerted immediately.
- Send lower‑severity messages such as **notice**, **info**, or **debug** to
  nobody, keeping the alerting channel quiet.

The alert emails are formatted from the module's template, so recipients get a
readable message rather than a raw dump.

**Set thresholds deliberately.** Because an erroring site can generate errors very
quickly, route only the high‑severity levels to a human. And remember the privacy
angle: log messages often contain user input, IP addresses, and request details,
so choose recipients accordingly.

## Web Server Logging and Alerts (`errorlog`)

Open **Configuration → Development → Web Server Logging**, or go directly to
`/admin/config/development/errorlog`.

Here you choose **which severity levels are written to the web server's error
log**. For example, you might send only emergency and critical messages to the
error log and let other modules (such as `emaillog`) handle the rest.

Where those messages ultimately land is decided by your PHP `error_log`
configuration, not by Drupal — commonly syslog on a UNIX‑like host (which may end
up in a file such as `/var/log/apache2/error.log`) or the event log on Windows.
This makes `errorlog` a natural fit when you want Drupal's events to join an
existing log shipper or centralised syslog pipeline.

## Save

Click **Save configuration** on each form. Routing takes effect for subsequent log
messages, so trigger a message at a routed severity to confirm it reaches the
destination.
