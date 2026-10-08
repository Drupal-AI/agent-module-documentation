# Configuration

IP Limiter is configured at **Configuration → System → IP Limiter**
(`/admin/config/system/ip-limiter`), where you create and manage rate‑limiting
rules. You can have as many rules as you like, and the same plugin type can be
used more than once.

## Building a rule

Each rule is defined by these settings:

- **Plugin** — the rule type:
  - **Path** — matches against the request path.
  - **Route** — matches against the Drupal route name.
  - **User‑Agent** — matches against the User‑Agent header, with
    blacklist/whitelist strategies and built‑in bot‑detection presets.
- **Condition** — the values to match against, one per line. Turn on **regular
  expression** support if you want pattern matching for paths or routes.
- **Max Requests / Time Period** — the request threshold and the rolling window
  (in seconds) it's measured over. For example, "50 requests per 60 seconds".
- **Ban Duration** — how long (in seconds) to ban an IP once it exceeds the limit.
- **Response Type** — what a blocked request receives: **403 Forbidden**,
  **404 Not Found**, or **429 Too Many Requests**.

You can also add optional **matcher conditions** per rule — user‑agent filtering,
query‑string patterns, and referer requirements — to narrow when a rule applies.

## Escalation and decay

Bans **escalate automatically** for repeat offenders (a multiplier increases the
ban duration), and they **decay over time via cron**. Make sure Drupal cron is
running so this lifecycle works as intended.

## Managing banned IPs

The admin interface lets you **view and manage the IP addresses that are currently
banned**, so you can review who's been caught and lift a ban manually if needed.

## Important cautions

- **Shared IPs cause false positives.** Many legitimate people share a single
  public IP behind CGNAT, corporate NAT, or a VPN. Because a ban blocks
  *everyone* behind that IP, set thresholds and ban durations generously enough to
  avoid locking out real users. Legitimate crawlers can be affected too.
- **Use the real client IP behind a proxy.** If your site sits behind a reverse
  proxy or CDN, configure Drupal's **trusted‑proxy** settings in `settings.php` —
  otherwise the module may see (and ban) the proxy's IP instead of the visitor's.
- **It's not a firewall.** Blocked requests still reach your web server and write
  logs. For persistent malicious IPs, a server‑ or network‑level firewall ban
  remains the recommended solution; use IP Limiter as an additional layer, not the
  only one.

## Save

Save each rule to put it into effect. Start with conservative thresholds and
tighten them as you observe real traffic.
