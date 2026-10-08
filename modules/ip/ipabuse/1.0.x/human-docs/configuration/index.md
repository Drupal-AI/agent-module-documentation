# Configuration

IPAbuse Firewall is configured at **Configuration → Security → IPAbuse Firewall**
(`/admin/config/security/ipabuse`). The setup is short and, once done, needs no
day‑to‑day management.

## Post‑installation steps

1. **Create a free account** at [ipabuse.org](https://ipabuse.org) and copy your
   API key.
2. On the settings page, paste the key into the **API Key** field.
3. Click **Test Connection** to confirm the key works.
4. Click **Sync Blocklist Now** to immediately download the first set of blocked
   IPs into your local database (otherwise the first sync waits for cron).
5. Adjust the **Minimum Score** threshold if needed — the default of **75** is a
   safe starting point.
6. Enable or disable **Block IPs** and **Report Failed Logins** independently to
   suit your needs.
7. Make sure **Drupal cron** is running (`/admin/config/system/cron`) so the
   blocklist refreshes automatically.

## The settings, explained

- **API Key** — authenticates your site to ipabuse.org. Keep it secret (see
  below). The **Test Connection** button validates it without saving bad values.
- **Minimum Score** — every IP in the database has an abuse‑confidence score from
  0 to 100. This is the minimum score required to block an IP. Lower it for
  stricter blocking (more IPs blocked, higher chance of false positives); raise it
  to be more conservative. Default: 75.
- **Block IPs** — turns request‑level blocking on or off. When on, matching IPs
  get an immediate `403 Forbidden` before Drupal fully bootstraps.
- **Report Failed Logins** — turns brute‑force reporting on or off. When on,
  failed Drupal logins are reported back to ipabuse.org (deduplicated via Drupal's
  Flood API so the same IP isn't reported repeatedly).
- **Sync Blocklist Now** — forces an immediate blocklist refresh outside of cron.

## Store the API key securely

Treat the ipabuse.org API key as a secret. Prefer keeping it in an environment
variable rather than committed configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --ipabuse-api-key=your-key-here
ddev restart
```

Keep `.ddev/.env` out of version control, and rotate the key at ipabuse.org if it
is ever exposed.

## Caution: shared IPs

IP‑based blocking is a blunt instrument — a block affects *everyone* behind a given
IP. On networks where many legitimate users share one public address (CGNAT,
corporate NAT, VPN), a high‑scoring IP could take real users with it. The default
threshold of 75 is a reasonable balance; tune it if you see false positives.
