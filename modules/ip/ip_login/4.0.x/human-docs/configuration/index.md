# Configuration

IP Login is configured on its settings form (route `ip_login.settings`, reached
under **Site configuration → IP Login**), on individual user accounts (where you
enter the IP ranges), and on the permissions page. Because this module
authenticates people by IP, treat every mapping as a security decision.

> **Prerequisite:** confirm your reverse‑proxy / trusted‑host settings in
> `settings.php` are correct before mapping any IPs — see the warning on the
> [overview page](../index.md). Everything below assumes Drupal computes the true
> client IP.

## Map IPs to users

The IP ranges that trigger auto‑login are stored **per user** via the Field IP
address module. On a user's account, enter the IP(s) that should log in as that
account. The matching supports:

- **Single IPs**, comma‑separated: `123.4.5.6` or `123.4.5.6, 234.5.6.7`
- **Ranges**: `123.4.5.6-10` or `123.4-111.5.6`
- **Wildcards**: `123.4.5.*` or `123.*.*.*`
- **Any combination** of the above: `127.0.0.1, 123.4.5-66.*, 234.4-5.6-77.*`

Only map an IP that genuinely belongs to **one trusted person** or to an
intentionally shared kiosk. Never map an IP that many people share (office NAT,
CGNAT, VPN) unless you truly intend everyone on it to become that account.

## The settings form

From the IP Login settings form you can:

- **Integrate with the login page and block** — customize the text and labels
  shown, or use the separate **"Log in by IP"** block, which offers a simple
  auto‑login link for users who don't want the modified login block.
- **Restrict auto‑login to specific paths** — have IP Login run only on chosen
  pages (or when your custom PHP returns TRUE). Path restriction also makes the
  module compatible with external caches like Varnish.
- **Set a destination** — optionally send users to a specific address after they
  are logged in by IP.
- **Review IP‑enabled users** — the settings page lists which users have IP
  mappings.

## Permissions

Two permissions govern behavior on **People → Permissions**:

- **Administer IP login** — who can manage the module's settings and mappings.
  Grant to trusted admins only.
- **Log in as another user** — a user matched by IP who has this permission can
  choose to log out and log back in as a normal (different) account. Users
  *without* it are auto‑logged back in by IP, which keeps a device firmly tied to
  one account (useful for kiosks).

## Security checklist before you rely on it

- IPs are matched only against **active** user accounts.
- **Do not** map admin or other high‑privilege accounts on any shared network.
- Re‑confirm trusted‑proxy settings so `X-Forwarded-For` cannot be spoofed.
- Prefer path restrictions and single‑person IPs for the tightest scope.
- Treat this strictly as **trusted‑network authentication** — kiosks,
  single‑tenant office IPs, controlled devices. Outside those constraints it is an
  authentication‑bypass risk.
