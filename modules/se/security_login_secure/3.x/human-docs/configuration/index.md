# Configuration

After enabling the module, its settings appear in a dedicated **miniOrange Security /
Login Security** admin section. The options below come from the module's own feature
list.

## Brute-force protection (the main feature)

This is the part most people install the module for. You can:

- Set the **number of failed logins before an IP is blocked**, and the **time period**
  the IP stays blocked.
- Set the **number of failed logins before a user account is blocked**, and the time
  period that block lasts.
- **Show remaining login attempts** to the user on the login form.
- Set the **number of failures before an attack is detected** (for notifications).

**IP-ban caveats.** On shared IP addresses (corporate NAT, CGNAT, VPNs) a block can
catch innocent users, so choose thresholds and durations with that in mind. If your
site is behind a reverse proxy, make sure Drupal is configured to see the **real client
IP** — otherwise the module blocks the proxy's address rather than the attacker's.

## IP blocking and whitelisting

- **Manual and automatic IP blocking** — deny access from unwanted addresses and
  crawlers.
- **Country blocking** — block requests originating from countries you list.
- **IP-range blocking** — deny an entire range of addresses at once.
- **IP whitelisting** — let trusted networks bypass the monitoring (use this carefully;
  an attacker on a whitelisted network is not monitored).

## Reporting

The module logs login activity and lets you **filter reports** by username, IP address,
and status, and **download reports as CSV**.

## Other controls

- **DoS protection** — slows attackers by delaying responses and increasing the delay
  on each successive request, eventually blocking them.
- **Allow role login by IP** — restrict users of a given role to logging in only from
  an allowed IP range.
- **Risk-based authentication** — challenge users for extra credentials only when the
  context (device, location, time, behaviour) looks risky.
- **Notifications** — alert administrators when an IP is blocked and warn users about
  unusual account activity; email templates are customisable.

## The miniOrange registration

Some features prompt you to **register with miniOrange** (which retrieves an API key
from the vendor backend). If you only want brute-force/IP protection, note that it does
not depend on the miniOrange backend.

Save your settings once configured, and restrict access to this admin section to
trusted administrators.
