# Configuration

The status page is off until you enable it, and it stays private unless a request
authorizes itself. This page walks through enabling and securing the endpoint,
the settings that tune the checks, the "Ignored modules" form, and the Drush
commands.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Nagios monitoring**, or navigate directly to
   `/admin/config/system/nagios`.

## Enable and reach the status page

The status page is **disabled by default**. On the settings form:

- **Enable the status page** — the master switch. Until this is on, the endpoint
  returns nothing useful.
- **Path** — the URL segment the page is served at (default `nagios`, so
  `/nagios`). Change it if you'd like a less obvious location.

After changing the path, rebuild caches (`drush cr`) so the route is registered.

## Securing the endpoint (important)

The page only returns real health data to an authorized request; anyone else
gets a single `UNKNOWN`/"Unauthorized" line. A request is authorized when any of
these is true:

- its HTTP **User-Agent** equals the configured **Nagios unique ID / user agent**
  string (default `Nagios`), **or**
- **Allow unique_id GET parameter** is enabled and the request includes
  `?unique_id=<that string>`, **or**
- the current user has **Administer site configuration**.

So a typical monitor polls `https://yoursite/nagios` while sending the agreed
User-Agent. For example:

```bash
curl -A Nagios https://yoursite/nagios
```

Set the **same** string on both the Drupal side (the *Nagios unique ID / user
agent* setting) and the monitoring side. Treat this string as a shared secret —
change it from the default `Nagios` to something unguessable, and don't commit
the real value in a way that exposes it. The `?unique_id=` option exists for
monitors that can't set a custom User-Agent, but a URL parameter is easier to
leak (logs, referrers), so prefer the User-Agent method where you can.

## Tuning the checks and thresholds

The settings form also lets you control what's reported and how severe it is:

- **Which built-in checks run** — toggle the cron, watchdog (log errors),
  maintenance-mode, and requirements checks individually.
- **Cron duration thresholds** — how many minutes without a cron run before cron
  is reported as late (there's a separate threshold for Elysia cron).
- **Minimum report severity** — only report items at or above a chosen severity,
  to cut noise.
- **Status codes** — the numeric codes emitted for OK / Warning / Critical /
  Unknown (defaults 0 / 1 / 2 / 3, the Nagios convention). You can remap these if
  your monitoring expects different numbers.
- **Experimental / deprecated warnings** — whether installed experimental
  modules, or deprecated modules and themes, raise a warning.
- **Watchdog channel filtering** — limit which log channels count toward alerts
  (for example ignore "access denied" noise).

Click **Save configuration** when done.

## Ignored modules form

A second form at **Configuration → System → Nagios monitoring → Ignored
modules** (`/admin/config/system/nagios/ignored_modules`) lets you exclude
specific modules from update reporting — handy for silencing noisy or
intentionally-pinned third-party modules. Access to this form requires the
**Administer nagios ignore** permission.

## Restricting output to one module

You can poll a single module's check by requesting `/nagios/<module>` (or
`/nagios/<module>/<id>` for a specific identifier), which runs only that module's
check instead of the full aggregated line.

## Running checks from the command line (Drush)

The same checks are available as Drush commands, which exit with the Nagios
severity code (0 OK, 1 Warning, 2 Critical, 3 Unknown) so they slot into cron or
NRPE:

```bash
drush nagios              # full health line; exit code = worst severity
drush nagios cron         # run only the 'cron' check
drush nagios-list         # list all available checks
drush nagios-updates all  # report pending module/theme updates (needs the Update module)
echo $?                   # inspect the exit code
```

Note: `drush nagios` warns if it runs as a different OS user than the web server,
because file-permission checks depend on the running user. You can clear that
warning with `drush state:delete nagios.os_user`.

## Extending with your own checks (for developers)

Other modules can add their own health checks by implementing `hook_nagios()`
(the check itself) and optionally `hook_nagios_info()` (to add an on/off toggle
for it on the settings form). See the agent docs at
[`hooks/nagios.md`](../../agent/hooks/nagios.md) for the hook signatures and
status-code constants.
