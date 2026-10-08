# Configuration

GeoDeny has a single, simple settings form: you choose which countries or regions
to block, and it applies that list site‑wide. Everything else — the actual
lookup — is handled by the ip2country module behind the scenes.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → GeoDeny**, or navigate directly to
   `/admin/config/services/geodeny` (config route `geodeny.config_form`).

## Choose the blocked countries/regions

The form presents the list of countries/regions you want to deny. Select the ones
that should be blocked and save. From then on, any request whose client IP
resolves (via ip2country) to a country on this list receives an empty **HTTP 400**
instead of the page. The selection is stored in the module's configuration
(`geodeny.settings`), so it moves with your configuration exports.

Click **Save configuration** to apply the block. Changes take effect on
subsequent requests.

## How the block behaves — and its limits

Keep these behaviours in mind when deciding what to put on the list:

- **It's site‑wide.** There's no per‑page or per‑role granularity here — a blocked
  country is blocked everywhere on the site.
- **It runs late in the request.** The block replaces the *response*, so the page
  has effectively already been assembled before the body is discarded. This makes
  GeoDeny an output‑level deterrent, not a pre‑execution access gate.
- **It depends on accurate client IPs.** If your site is behind a proxy or CDN,
  your reverse‑proxy/trusted‑proxy settings must be correct, or GeoDeny will read
  the wrong IP.
- **It fails open.** An IP that ip2country cannot resolve to a country is *not*
  blocked.
- **Geolocation is coarse and spoofable.** Country detection is fairly reliable
  but is easily bypassed with a VPN or proxy. Use GeoDeny as one loose layer, not
  as your only line of defence — for real security, combine it with a firewall/WAF
  and proper per‑route access control.

## Keeping the country data current

Because the country lookup relies on ip2country's database, keep that database up
to date (through the ip2country module) so your blocking stays accurate as IP
allocations change over time.
