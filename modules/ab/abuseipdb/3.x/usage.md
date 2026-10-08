AbuseIPDB connects a Drupal site to the AbuseIPDB threat-intelligence API to check visitor IPs against its reputation database and optionally report and ban abusive addresses.

---

The module wraps the AbuseIPDB v2 REST API (`https://api.abuseipdb.com/api/v2/`) behind a `check` (query an IP's abuse-confidence score) and a `report` (submit an abusive IP with category codes) service. A configurable **abuse confidence score** threshold (0–100, default 75) decides when a checked IP is treated as abusive. Three enforcement surfaces consume this: a `hook_form_alter` validator that rejects (and optionally bans) abusive submitters on named form IDs; a `KernelEvents::REQUEST` subscriber that checks configured "check paths" and either bans the IP or redirects it to a safe path; and a `KernelEvents::TERMINATE` subscriber that reports (Web App Attack, category 21) and optionally bans IPs that hit configured "report/blacklist paths" such as `/wp-login.php`. Banning is delegated to a pluggable **ban-manager** system (a `service_collector` on tag `abuseipdb_ban_manager`); the base module ships an empty no-op manager, and the `abuseipdb_core_ban` and `abuseipdb_advban` submodules add Core Ban and Advanced Ban integrations. A CIDR-aware IP whitelist, an `abuseipdb bypass check` permission, and an emergency-shutdown switch let you exempt trusted traffic. All admin screens live under `/admin/config/services/abuseipdb` and require `administer site configuration`.

---

- Block known-abusive IPs from submitting specific Drupal forms (login, register, contact, comment) by listing their form IDs on the Form Check tab.
- Automatically ban an IP (via Core Ban or Advanced Ban) when it fails the confidence-score check during form validation.
- Protect sensitive Drupal paths by listing them on the Paths Check tab so visitor IPs are checked on every request to those paths.
- Redirect abusive visitors away from a checked path to a configured safe path (e.g. `/`) instead of banning them.
- Auto-report and ban bots probing WordPress/Joomla-style attack paths (`/wp-login.php`, `/joomla/*`) via the Paths Report (blacklist) tab.
- Tune the sensitivity of "abusive" by setting the Abuse Confidence Score threshold (AbuseIPDB recommends 75–100).
- Manually report an arbitrary IP address to AbuseIPDB with one or more abuse categories and an optional comment.
- Manually ban an IP from the Drupal site at the same time you report it.
- Whitelist trusted IPs or CIDR ranges (e.g. office egress, monitoring, CDN) so they are never checked or banned.
- Grant staff or authenticated roles the `abuseipdb bypass check` permission so their traffic skips all checks, reports, and bans.
- Flip the Emergency shutdown switch to instantly disable all checks and reports without uninstalling the module.
- Cap the AbuseIPDB check request time with the Check API Timeout to avoid slow API responses stalling page loads.
- Choose which ban backend to use (None, Core Ban, or Advanced Ban) from a single Ban Manager dropdown.
- Report crawlers and bad web bots that ignore robots.txt by pointing report paths at honeypot URLs.
- Feed AbuseIPDB's crowd-sourced blacklist so other sites benefit from abuse your site observes.
- Use the AJAX "Test a path" field on the Paths Check / Paths Report tabs to verify a wildcard pattern matches before saving.
- Keep authenticated traffic fast by scoping checks to anonymous-facing paths and giving trusted roles the bypass permission.
- Combine path checking (proactive block) and path reporting (report + ban) to both defend the site and contribute intelligence.
- Reset the ban manager to "None" automatically when a ban submodule is uninstalled, avoiding a dangling reference.
- Roll site config forward with the module's `hook_update_N` routines (confidence-score default, 3.x setting renames, whitelist addition).
- Categorise manual reports using AbuseIPDB's full category vocabulary (DDoS, Brute-Force, SQL Injection, Web App Attack, Bad Web Bot, etc.).
