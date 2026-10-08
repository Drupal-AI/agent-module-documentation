DDoS Security is an application-layer per-IP request-rate limiter that counts each anonymous visitor's hits per minute, blocks IPs that exceed a configurable threshold, and gives admins an IP block/unblock list, CSV/mail reporting, and simple user-agent/URL malicious-request filtering.

---

The module registers a `KernelEvents::REQUEST` event subscriber (`AttackProtection`) that runs early on every request. For anonymous users, while DDoS protection is enabled, it records the client IP with a per-minute serial number in its own `ddos_security` database table, counts how many "allowed" rows that IP accrued in the last minute, and — when the count reaches the configured `total_hits` threshold — flips the IP's status to `blocked` and redirects it to an internal alert page (`/ddos-alert-message`). Whitelisted IP addresses and whitelisted paths are excluded from logging. Optionally it rejects requests whose `User-Agent` contains `bot`/`crawler`/`spider` or whose URL contains configured malicious substrings (e.g. `<script`, `<?php`). Administrators (permission `administer site configuration`) get a settings form, a paged entry list with per-IP block/unblock/delete actions, a CSV export of the log, and an optional daily cron mail with the report link. Note this is not a network-layer or edge DDoS defence — it is a PHP-level throttle inside the Drupal request lifecycle, effective only against relatively low-volume floods and only for anonymous traffic; a real volumetric DDoS never reaches PHP.

---

- Throttle abusive anonymous request floods against a Drupal site without an upstream WAF/CDN.
- Automatically block an IP after it exceeds N page hits within one minute.
- Redirect blocked visitors to a customizable "access denied / blocked" alert page instead of serving content.
- Show a configurable pre-attack 403-style message to anonymous users hitting the alert page.
- Whitelist trusted IP addresses (e.g. `127.0.0.1`, office ranges) so they are never rate-logged or blocked.
- Whitelist specific paths so hits to those pages are not counted toward the threshold.
- Tune the sensitivity by setting the allowed hits-per-minute (`total_hits`) value.
- Review all tracked IPs, their hit counts, last-access time, and status in a paged admin table.
- Manually block a specific IP from the admin entry list.
- Manually unblock (allow) an IP that was auto-blocked or manually blocked.
- Delete all log rows for a given IP from the admin entry list.
- Search the entry list by IP address or status (allowed/blocked).
- Export the full IP/hit-count/status log as a CSV file for offline analysis or record-keeping.
- Receive a daily cron email containing a link to download the CSV report.
- Send the report mail to a custom address (falls back to the site email).
- Reject requests from crawler/bot user-agent strings when malicious-request filtering is enabled.
- Block requests whose URL contains configured attack substrings (e.g. `<script`, `<?php`, XSS/injection markers).
- Reject requests with an over-long query-string parameter value (>1024 chars) as suspicious.
- Localize the block/redirect flow for multilingual sites (language-prefixed redirect URL).
- Provide a lightweight, dependency-free (core `user` only) throttle for sites that cannot deploy edge protection.
- Customize the blocked-user and pre-attack messages with full-HTML formatted text.
- Keep an audit trail of which IPs were blocked and when, for incident review.
