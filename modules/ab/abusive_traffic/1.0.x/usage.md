<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Parses Apache access logs from Acquia Cloud to find IP addresses hammering your site and emails you when one crosses a hit threshold, so you can ban it.

---

Abusive Traffic is an Acquia-Cloud-specific operations tool for spotting abusive IPs (spam bots, scrapers, brute-forcers). Two Drush commands, meant to run as hourly cron jobs, use the Acquia Cloud API (v2) to generate an Apache access log for the last hour, download it into the private file system, count hits per client IP, drop IPs on an admin ignore list, and — if any single IP is at or above a configurable threshold — send an HTML alert email to a configured recipient list. The email links each flagged IP to abuseipdb.com and to the site's Ban page. The module only *identifies* IPs; you still block them yourself with the core Ban module or, better, a .htaccess/firewall rule. Credentials (Acquia client id/secret, application UUID, optional SFTP details) are read from Acquia secrets, and log files can optionally be forwarded over SFTP for parsing by Splunk or similar. Threshold, ignore list, email list and the SFTP toggle are set at /admin/config/system/abusive-traffic (permission: administer site configuration). Requires Acquia Cloud Next hosting and the phpseclib library.

---

- Detect IP addresses making an abnormal number of requests to your site in the last hour.
- Run hourly, hands-off, as two scheduled cron jobs (generate-log, then get-log).
- Generate an on-demand Apache access log via the Acquia Cloud API for a rolling 1-hour window.
- Download the Acquia-generated Apache log and store a copy in Drupal's private file directory.
- Count hits per client IP by parsing the first field of each Apache access-log line.
- Get emailed only when a single IP is at or above your chosen threshold (start at 100 to calibrate).
- Send a formatted HTML alert to a comma-separated list of admin/ops recipients.
- Follow one-click links in the alert to abuseipdb.com to research each flagged IP.
- Jump straight from the alert to /admin/config/people/ban to temporarily ban an IP.
- Exclude known-good or already-blocked IPs with a wildcard-capable ignore list (e.g. 127.0.0.* ).
- List the Acquia application UUIDs your token can access, to save into Acquia secrets.
- Store Acquia API and SFTP credentials in Acquia secrets rather than in module config.
- Forward downloaded log files over SFTP to Splunk or another log-analysis service.
- Feed a lightweight abuse-detection workflow when you lack a full WAF/CDN.
- Calibrate sensitivity by tuning the threshold up or down after reviewing real alerts.
- Identify rotating bad-actor ranges (e.g. the module notes Alibaba's 47.76.* range) for banning.
- Complement the core Ban module with automated discovery of which IPs to ban.
- Support an ops runbook where discovery is automated but blocking stays a human decision.
- Keep a per-hour archive of parsed access logs under private://default/ for later review.
- Alert multiple stakeholders at once by listing several addresses in the email list.
- Restrict all configuration to site administrators (administer site configuration permission).
