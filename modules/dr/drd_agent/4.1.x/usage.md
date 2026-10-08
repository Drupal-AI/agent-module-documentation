<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Agent is the "agent" you install on a remote Drupal site so a central **Drupal Remote Dashboard (DRD)** instance can securely connect to it and run maintenance and monitoring actions (cron, cache flush, maintenance mode, updates, project/version info, error logs, and more) over encrypted HTTP.

---

The module exposes a handful of routes the DRD portal calls: `/drd-agent` (the main action endpoint, `Agent::get`), `/drd-agent-crypt` (advertises available crypt methods), `/drd-agent-authorize-secret`, and an admin `/drd-agent-authorize` form — all designed to be driven by a remote dashboard rather than a human. Requests are encrypted (`Crypt\Method\OpenSsl` or `Tls`) and authenticated (`Agent\Auth\SharedSecret` or `UsernamePassword`); once a dashboard is authorized, its credentials are stored in Drupal **State** (`drd_agent.authorised`, `drd_agent.ott`), not config. On each call the agent runs one of many **Action** classes (`Agent\Action\*`): `Cron`, `FlushCache`, `MaintenanceMode`, `Info`, `Projects`, `Update`, `UpdateTranslations`, `Database`, `Download`, `ErrorLogs`, `Php`, `Blocks`, `Session`, `UserCredentials`, `Ping`, `JobScheduler`, and domain actions. It integrates with optional modules through `Agent\Remote\*` (`Monitoring`, `SecurityReview`, `Requirements`) — hence the recommendation to also install `monitoring`, `security_review`, and `hacked`. The module **defines one plugin type**, `drd_pi_auth` (manager `plugin.manager.drd_pi_auth`, annotation `@DrdPiAuth`), for provider-infrastructure authentication, shipping `acquia`, `pantheon`, and `platformsh` plugins so DRD can reach sites hosted on those platforms. Local configuration is minimal: a single **Debug mode** toggle on the settings form at `/admin/config/system/drd`, stored in State as `drd_agent.debug_mode`. A Drush command `drd:agent:setup <token>` bootstraps the connection to a DRD instance from a base64/JSON token. There is no config schema (everything is State-based) and no permissions of its own; the settings/authorize forms use core's `administer site configuration`.

---

- Let a central DRD dashboard manage many remote Drupal sites from one place.
- Run cron on a remote site from the dashboard without SSH.
- Flush caches on a remote site remotely.
- Put a remote site into (or out of) maintenance mode from the dashboard.
- Collect project/version and available-update info from many sites for a fleet overview.
- Pull a remote site's error logs (watchdog) into the dashboard.
- Trigger core/contrib updates and translation updates remotely.
- Take a database or files download/backup action via the agent.
- Monitor sites by exposing the Monitoring module's sensors through the agent.
- Surface Security Review results from the agent to the dashboard.
- Detect hacked/modified project code (with the `hacked` module) across the fleet.
- Authorize a specific DRD instance to control the site (stored in State, encrypted).
- Use shared-secret or username/password authentication for the agent connection.
- Encrypt agent traffic with OpenSSL or TLS crypt methods.
- Connect DRD to sites hosted on Acquia via the `acquia` drd_pi_auth plugin.
- Connect DRD to Pantheon-hosted sites via the `pantheon` plugin.
- Connect DRD to Platform.sh-hosted sites via the `platformsh` plugin.
- Add a new hosting-provider auth integration by implementing a `drd_pi_auth` plugin.
- Bootstrap the agent-to-dashboard link on the CLI with `drush drd:agent:setup <token>`.
- Toggle Debug mode on the agent to diagnose connection issues.
- Report runtime requirements back to DRD only when it calls (via the X-DRD-Version header).
- Manage blocks or job-scheduler tasks on a remote site through the agent.
- Standardise maintenance operations across dozens of sites from a single dashboard.
