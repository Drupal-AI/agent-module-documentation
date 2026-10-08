# Configuration

Oh Dear Integration is configured in a few places: the module's own settings page
(the health‑check secret), the Monitoring module (which sensors to report), and Oh
Dear's own dashboard (where you copy the secret and the cron ping URL from).

## 1. Set the health‑check secret

1. In the [Oh Dear dashboard](https://ohdear.app), open your site's **Application
   health** tab and copy the health‑check secret it provides.
2. In Drupal, go to **Configuration → System → Oh Dear settings**
   (`/admin/config/system/ohdear-settings`) — you need the **Administer site
   configuration** permission.
3. Paste the secret into the **oh‑dear‑health‑check‑secret** field and save.

From then on, the endpoint at `/json/oh-dear-health-check-results` accepts a request
only if it presents this secret in the `oh-dear-health-check-secret` **header** (or
holds the `monitoring reports` permission). Configure your Oh Dear monitor to send
the secret as a **header** rather than a query parameter — a secret in a URL can end
up in web‑server access logs, `Referer` headers, and proxy logs, whereas a header
does not.

### Where to store the secret

Treat the health‑check secret (and any Oh Dear API token you use for the reports and
Drush commands) as a credential:

- With DDEV, keep the value out of version control by storing it in an environment
  variable: `ddev dotenv set .ddev/.env --ohdear-secret=<value>` (never commit
  `.ddev/.env`), then `ddev restart` so the container picks it up.
- Where the module or your settings support it, reference the value through the
  [Key](https://www.drupal.org/project/key) module or from `settings.php` via
  `getenv()`, rather than typing the raw secret into config that gets exported.

## 2. Configure which sensors are reported

The health endpoint publishes whatever the **Monitoring** module's sensors report —
cron status, available security updates, disk and database health, and so on. Choose
and tune those sensors at **Configuration → System → Monitoring →
Settings** (`/admin/config/system/monitoring/settings`).

> Because the endpoint exposes real operational detail about your site, this is
> exactly why the secret matters — that information is useful to your operations team
> and would be useful to an attacker too.

## 3. Connect cron monitoring (optional)

Oh Dear can monitor that your cron actually runs, via its **Scheduled tasks**
feature. Copy the ping URI Oh Dear provides under Scheduled tasks into the module's
configuration; once set, Drupal automatically pings Oh Dear on each cron run, so a
missed cron shows up as an alert.

## 4. Drush commands

The module adds Drush commands for day‑to‑day operations, including:

- `drush ohdear:maintenance` — view maintenance windows, and start or stop one with
  the start/stop flags;
- `drush ohdear:info` — print basic info about the configured site;
- `drush ohdear:broken-links` — list broken links for the current site;
- `drush ohdear:uptime` — show uptime (last week by default, with arguments to adjust
  the range and period).

## A note the maintainers would appreciate

The secret comparison in the current release is exact but not constant‑time
(`===` rather than `hash_equals()`), and the secret can also be supplied as a query
parameter. Prefer the header form, and keep an eye on the issue queue for hardening
of the comparison.
