# Configuration

The module adds a single field to Drupal core's maintenance settings — there's no
separate page.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Maintenance mode**
   (`/admin/config/development/maintenance`).

## The IP whitelist field

Below core's maintenance controls you'll find the **IP whitelist** textarea.
Enter the IP addresses that should be allowed through maintenance mode, **one per
line**. Anyone whose connection comes from a listed IP is treated as exempt from
maintenance and can browse the site normally (even anonymously); everyone else
sees the maintenance page.

To add temporary preview access, add the IP; to revoke it, remove the line and
save — the change takes effect immediately. The list is stored per-environment
(in Drupal's state, not exported configuration), so your production allowlist
won't accidentally travel to staging in a config export.

## Getting the right IP address

Because the module matches against the **real connection IP** (not a spoofable
header), enter the address as your server actually sees it:

- **No proxy / CDN in front of the site:** whitelist the visitor's public IP —
  the one shown by a "what is my IP" lookup from their network.
- **Behind a reverse proxy, load balancer, or CDN:** the connection IP the
  application sees may be the proxy, not the end user. Make sure Drupal's
  reverse-proxy / trusted-host settings in `settings.php` are configured so
  Drupal resolves the real client IP, and whitelist the address it then
  presents. If preview access "doesn't work," a proxy in the path is the usual
  cause.

## Save

Click **Save configuration**. The allowlist applies the next time someone visits
while maintenance mode is on.
