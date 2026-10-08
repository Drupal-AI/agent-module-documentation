# Configuration — flood limits and unblocking

Flood Control does two things: it lets you **tune the flood thresholds** that decide
when repeated failed logins get blocked, and it lets you **clear flood entries** so
a legitimately locked-out user or IP can log in again. This page covers both.

## Open the settings form

1. Go to **Configuration → People → Flood control**
   (`/admin/config/people/flood-control`).

The form opens on the **Login** section, which is where the flood thresholds live.

![The Flood control settings page: login limits, time windows, and the allowed-IPs field](../images/settings.png)

## Understanding the thresholds

Drupal core blocks login attempts once a limit is reached within a time window. It
tracks failures two ways at once — by **IP address** and by **username** — so a
single lockout can be triggered by either. The **Login** section exposes four
settings:

- **IP login limit** — the number of failed login attempts allowed from a single IP
  address within the IP time window before that IP is blocked. In the screenshot
  above this is set to `50`.
- **IP time window** — how long the site remembers those failed IP logins (and
  therefore how long the IP stays blocked once it hits the limit). Shown as `1 hour`
  above.
- **Username login limit** — the number of failed login attempts allowed against a
  single username within the username time window before that account is blocked.
  Set to `5` above. Keeping this low is what mitigates a targeted brute-force attack
  against a specific account.
- **Username login time window** — how long the site remembers those failed
  username logins (and how long the username stays blocked). Shown as `6 hours`
  above.

Raising a limit or shortening a window makes the site **more forgiving** (useful
during a large onboarding or support event); lowering a limit or lengthening a
window makes it **stricter** (useful for slowing credential-stuffing on a
high-value site).

## Allowing trusted IPs to bypass flood limits

Below the Login section is a **Flood control** section with an **Allowed IPs**
field. Enter IP addresses or IP-address ranges here — one per line — and those
addresses bypass the flood limits entirely. This is handy for a trusted office or
NAT IP that many staff share, or for an uptime/health-check service that would
otherwise trip the limits. Leave it empty if you do not need any exemptions.

## Adjust the limits and save

1. Choose new values from the **IP login limit** and **IP time window** selectors to
   control how repeated failures from one IP are handled.
2. Choose new values from the **Username login limit** and **Username login time
   window** selectors to control per-account lockouts.
3. If you want any trusted addresses to skip flood protection, add them to the
   **Allowed IPs** field, one per line.
4. Click **Save configuration** at the bottom of the form.

Your new thresholds take effect immediately for subsequent login attempts.

## Unblocking a locked-out user or IP

Changing the thresholds does not clear an existing lockout — a user or IP that has
already hit the limit stays blocked until its time window expires. To let them log
in again straight away, you clear their **flood entries**.

1. On the settings form, follow the **Flood Unblock page** link in the Login
   section's description (it points to `/admin/people/flood-unblock`).
2. The Flood unblock screen lists the IP addresses and user IDs that are currently
   blocked, with a per-row action to clear each one.
3. Find the row for the affected user or IP and clear its flood entries. The lockout
   is lifted immediately and that person can log in again.

This is the everyday fix for a legitimate user who got locked out after mistyping
their password, or an office/NAT IP that hit the shared-IP login limit because many
people log in from behind it.
