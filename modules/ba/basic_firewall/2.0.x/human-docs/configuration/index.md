# Configuration

Everything happens from the dashboard at **Configuration → System → Basic
Firewall** (`/admin/config/system/basic-firewall`). You need the **Administer
basic firewall** permission to reach it.

## How rules are evaluated

Rules are grouped and evaluated in a fixed order:

1. **Allow** rules run first — the first allow match ends evaluation and lets the
   request through.
2. **Challenge** rules run next.
3. **Block** rules run last.

Within a group, the **lower weight runs first**, and you can drag‑reorder rows on
the Rules page. The practical upshot: an allow rule always beats a block rule, so
you can, for example, allow‑list your office IP and still block a whole country.

## Adding a rule

On the Rules page choose **Add rule** and pick a rule‑type plugin:

| Rule type | What it matches |
|-----------|-----------------|
| **IP address** | A single IP or a CIDR range |
| **User agent** | A user‑agent substring / pattern (bad bots, scanners) |
| **URL** | A request path pattern |
| **ASN** | An entire autonomous system number |
| **GeoLocation** | A country (needs a GeoIP reader available) |
| **Rate limit** | Requests per time window per client (blunts brute‑force / scraping) |
| **CRS / Vulnerability score** | A Core Rule Set / heuristic score |
| **AbuseIPDB** | An external IP‑reputation lookup |

Each rule is set to allow, challenge or block, and can be given a weight.

## The other tabs

- **Settings / Storage / Logging / Challenge** — global behaviour, the backend
  that stores blocked‑client state, the dedicated `basic_firewall` logger
  channel, and how the challenge flow works.
- **Presets** — import a rule bundle shipped with the module, or preview one
  before importing.
- **Advanced** — edit the compiled configuration directly as YAML.
- **Test a request** — dry‑run how a hypothetical request would be classified,
  so you can check a rule before it goes live.
- **Compiled** — inspect the compiled file the middleware actually reads.
- **Blocked** — the list of currently blocked clients. Releasing one needs the
  **Unblock basic firewall clients** permission.

## Important: sites behind a reverse proxy or CDN

The firewall runs just **after** Drupal's reverse‑proxy middleware, specifically
so the client IP it evaluates is trustworthy. But that only works if Drupal
itself is told about your proxy. If your site sits behind a load balancer, CDN
(Cloudflare, Fastly, …) or any reverse proxy, configure Drupal's trusted
reverse‑proxy settings in `settings.php` (`$settings['reverse_proxy']`,
`$settings['reverse_proxy_addresses']`, and the relevant forwarded headers).

If you skip this, every request appears to come from the proxy's IP: your IP,
ASN and GeoLocation rules will match the proxy instead of the real visitor, an
allow‑list of "your office IP" will silently never match, and a rate‑limit rule
may throttle all traffic as if it were one client. Get the proxy settings right
first, then build IP‑based rules.

## Permissions

Three permissions gate the module (two are marked *restrict access* — grant them
sparingly):

- **Administer basic firewall** — full access to the dashboard and rules.
- **View basic firewall reports** — see the dashboard and blocked‑client list.
- **Unblock basic firewall clients** — release a blocked client.

## After editing rules: the compiled cache

Rules live in configuration (`basic_firewall.settings`) and are compiled to a
file in the private directory. That file regenerates automatically when you save
config and on a full cache rebuild. If you imported config or the file went
missing, force a rebuild:

```bash
drush basic-firewall:rebuild   # alias: drush bfw:rebuild
```

## Drush commands

- `drush basic-firewall:rebuild` (`bfw:rebuild`) — regenerate the compiled file
  from current config. Run it after a `config:import`.
- `drush basic-firewall:status` (`bfw:status`) — report runtime state (enabled
  flag, whether the compiled file exists, library capabilities) as a table.
- `drush basic-firewall:rules` (`bfw:rules`) — list configured rules with their
  id, label, type, response, weight and enabled state.
