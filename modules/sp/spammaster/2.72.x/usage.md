Spam Master is a SaaS-backed anti-spam firewall for Drupal that blocks spam user registrations, comments, and posts using real-time threat lists from spammaster.org, plus a honeypot, IP/email whitelist and blacklist ("buffer"), and optional flood control.

---

On install the module generates a random license key and a rotating "db protection hash", then contacts `https://www.spammaster.org` to auto-create a FREE license (`SpamMasterLicService`, via `SpamMasterApiService`). A kernel `REQUEST` event subscriber (`SpamMasterFirewallSubscriber`) runs on every request when the license status is valid and the subtype is `prod`: it exempts admins and whitelisted IPs/form-ids, optionally enforces POST flood control, blocks IPs present in the local threats "buffer", and on form submissions checks bundled honeypot fields (`spammaster_extra_field_1/2`) and an "elusive" bot heuristic — serving a themed 403/429 firewall page (`/firewall`, `SpamMasterFirewallController`) when it blocks. Cron and a lazy per-request sync call the license API daily; the API can return `a=1` to trigger `SpamMasterActionService::spamMasterAct()`, which POSTs the site's license key + hash to spammaster.org and applies the returned Add/Remove/Change instructions to the local threat/white/exempt tables and to `spammaster.settings_protection` config/state. A POST endpoint `/spam-master/v1` (`SpamMasterActionController`) lets the SaaS backend push the same actions and read statistics, but only after the caller proves knowledge of the site's license key AND db protection hash. Admin lives under `/admin/config/system/spammaster` (five forms: Settings, Protection Tools, Spam Buffer, Whitelist, Statistics & Log), all gated by core `administer site configuration`. It stores threats, keys/logs, and whitelist rows in its own `spammaster_threats`, `spammaster_keys`, and `spammaster_white` tables, cleans them on configurable schedules, and emails alerts/reports. It defines one `manage spam master` permission (`restrict access: TRUE`) and no Drush.

---

- Block spam new-user registrations using real-time anti-spam lists.
- Block spam comments and forum/node submissions from known-bad IPs and emails.
- Run a honeypot on site forms to trap automated bot submissions.
- Maintain a local blacklist ("buffer") of threat IPs/emails that are blocked on every request.
- Whitelist trusted IPs or specific form-ids so they bypass spam checks.
- Enforce POST flood control (configurable window + limit) to throttle rapid submissions.
- Serve a branded 403 firewall page to blocked visitors showing their IP and browser.
- Sync threat intelligence daily from spammaster.org via cron.
- Auto-create a FREE Spam Master license on install without manual signup.
- Upgrade to a Pro license key for higher-volume/threat coverage.
- Detect "elusive" bots with an advanced heuristic beyond simple lists.
- Exempt administrators (users with `administer site configuration`/`administer nodes`) from spam blocking.
- Rate-limit repeated blocked-IP firewall logging to avoid log-flooding DOS.
- Configure separate cleanup retention (days) for firewall, honeypot, whitelist, system, mail, and cron logs.
- Receive email alerts when a threat alert level 3 is reached.
- Receive daily or weekly spam-protection summary reports by email.
- Add signature/branding output or hide it via the signature setting.
- Support sites behind Cloudflare with a CDN client-IP mode.
- View spam statistics and an activity log under Statistics & Log.
- Temporarily whitelist a visitor after they pass checks (transient whitelist).
- Let the Spam Master SaaS backend push threat/whitelist updates to the site over an authenticated endpoint.
- Run a customizable block message shown to banned emails/domains/IPs.
- Protect anonymous-reachable forms (registration, contact, comment) without adding CAPTCHA.
- Keep a local, queryable log of firewall blocks for auditing.
- Disable protection quickly by switching the subtype away from `prod`.
