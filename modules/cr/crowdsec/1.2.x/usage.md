<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CrowdSec integrates a Drupal site with the CrowdSec crowd-sourced security network: it detects bad behaviour locally, bans offending IP addresses, optionally reports (signals) those detections upstream, and downloads/enforces CrowdSec blocklists — all in-process, with no separate CrowdSec agent to install.

---

The module combines three concerns. (1) **Ban plugins** (a `crowdsec_scenario` plugin type) detect bad behaviour on this site and ban IPs locally; three ship in-box: `flood` (Drupal flood-control / auth brute force → `drupal/auth-bruteforce`), `core-ban` (IPs banned via the core Ban / Advanced Ban module → `drupal/core-ban`), and `whisper` (repeated 4xx responses within a time window → `drupal/4xx-scan`, the buffered default). (2) **Signal scenarios** decide which of those local bans are also reported upstream to CrowdSec. (3) **Subscribe scenarios** decide which upstream CrowdSec blocklists (e.g. `crowdsecurity/http-probing`, `crowdsecurity/http-sqli-probing`) this site downloads and enforces, rejecting matching requests with a 403 via an HTTP middleware. All of this is driven by one config object, `crowdsec.settings` (log level, `env` dev/prod, `api_timeout`, optional CTI API key, `signal_scenarios[]`, `scenarios[]`, and per-plugin `plugins.<id>` settings). A `Buffer` batches signals for upstream sending; `hook_cron()` pushes buffered signals and refreshes blocklists. Caching auto-detects Redis, else falls back to `temporary://crowdsec`. Events (`crowdsec.ip.banned`, `crowdsec.ip.blocked`, `crowdsec.ip.signalled`, etc.) let other code react, and the bundled **eca_crowdsec** submodule exposes them to ECA. Drush commands cover enrolment, signalling, collection, and IP test/verify. Admin config lives at `/admin/config/services/crowdsec` (route `crowdsec.settings`, permission `administer site configuration`).

---

- Automatically ban IP addresses that trigger repeated failed logins (flood / auth brute force).
- Ban IPs that generate many 4xx responses in a short window (scanning / probing detection).
- Feed the core Ban module's manually-banned IPs into CrowdSec's local remediation.
- Download and enforce CrowdSec community blocklists so known-malicious IPs get a 403.
- Block SQL-injection probing by subscribing to the `crowdsecurity/http-sqli-probing` scenario.
- Block XSS probing via `crowdsecurity/http-xss-probing`.
- Detect and block path-traversal attempts (`crowdsecurity/http-path-traversal-probing`).
- Reject requests to sensitive files/folders (`.git`, `.log`) via `crowdsecurity/http-sensitive-files`.
- Block bad or scanning user-agents and aggressive crawlers.
- Contribute this site's local detections upstream so the CrowdSec network learns from them.
- Choose per scenario whether to only ban locally or also signal upstream.
- Tune each ban plugin's duration, time window (leak speed) and threshold (bucket capacity).
- Switch between dev and prod environments (prod optimises performance and reduces logging).
- Set an API timeout and fall back to cached remediation decisions when CrowdSec is slow.
- Enroll the site into a CrowdSec console account with `drush crowdsec:enroll`.
- Manually flush buffered signals upstream with `drush crowdsec:signal`.
- Force a blocklist refresh with `drush crowdsec:collect`.
- Test the integration by signalling or verifying a specific IP (`drush crowdsec:test:signal` / `:test:ip`).
- Add a CTI API key to receive smoke/threat data about IP addresses.
- Use Redis automatically for the remediation cache when the site already has Redis configured.
- Extend detection by writing a custom `crowdsec_scenario` plugin for your own bad-behaviour signals.
- React to ban/block/signal events in custom code via the CrowdSec event constants.
- Drive automations off CrowdSec events with ECA using the eca_crowdsec submodule.
- Run signal pushing and blocklist refresh on cron with no extra setup.
- Protect a Drupal 11 site from many attack vectors without installing a separate CrowdSec bouncer.
- Adjust the module's log verbosity (RFC log level 0-7) for debugging or quiet production operation.
