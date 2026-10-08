# Configuration

The settings form controls whether JSNLog is active and exactly what it captures.

## Open the settings form

1. Log in as a user with permission to administer JSNLog.
2. Go to **Configuration → Development → JSNLog**, or navigate directly to
   `/admin/config/development/jsnlog`.

## Options

- **Enable or disable it.** The master switch — turn logging on or off without
  uninstalling the module.
- **Logging type.** Choose whether JSNLog captures messages via **AJAX** (posted
  back to the server and stored in watchdog), the browser **console**, or **both**.
- **Library type.** Select which build/variant of the JSNLog JavaScript library to
  load.
- **Debug level.** The minimum severity to save into watchdog. This also governs
  which of your manual calls get through — for example `JL().warn()`,
  `JL().info()`, and `JL().fatal()` are recorded depending on the level you set
  here.
- **User agent filter.** Restrict logging to specific browsers, so you only
  collect messages from the user agents you care about.
- **Include or exclude roles.** Limit logging to (or exclude it from) particular
  user roles.
- **Include or exclude pages.** Limit logging to (or exclude it from) specific
  pages by path.

## Save

Click **Save configuration** to apply your settings. Then trigger a front‑end
error (or a manual `JL()` call) and confirm the entry appears in **Reports →
Recent log messages**.
