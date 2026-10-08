# Configuration

Setting System Status up is a short job: register the site with your monitoring
dashboard using its UUID.

## Register the site

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → System Status**
   (`/admin/config/system/system_status`).
3. Copy your **site UUID** from that page.
4. In your monitoring dashboard (for example Lumturio), add a new Drupal site and
   paste in the site UUID. From then on the dashboard contacts your site, asks for its
   installed modules and versions, and calculates any needed upgrade path.

If your site is still in development and protected by HTTP Basic authentication, your
dashboard may let you enter an HTTP username and password (in its per-site *edit*
screen) so it can still reach the endpoint.

## The reporting endpoint

The monitoring service reaches your inventory through a read-only reporting endpoint
at `/admin/reports/system_status/{token}`. The admin settings page at
`/admin/config/system/system_status` is gated by the **Administer site configuration**
permission — only the *reporting* route uses the token. Where openssl is present, the
payload inventory is encrypted for the monitoring client with a per-site shared
secret.
