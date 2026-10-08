# Configuration

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → Security → Challenge Mitigation**.

## Main settings

On the settings form you control:

- **Enable/disable the system** — the master switch for the whole mitigation layer.
- **Challenge URLs** — the paths to protect, one per line. Patterns are matched
  against the **full request URI, including query parameters**, and support the
  `*` wildcard. Examples:

  ```
  /user
  /search?*
  /news?*f%5B0%5D=*
  /node/*?preview=*
  ```

  Alternatively, enable **full-site protection mode** to challenge every path.
- **Enforcement (challenge) mode** — choose how visitors are challenged:
  - **Automatic JS** — an invisible, auto-submitting JavaScript check; no user
    interaction required.
  - **Hard** — the user must manually submit a form; a CAPTCHA is required if you
    enable the CAPTCHA integration.
  - **Adaptive Hard** — automatically uses the Hard challenge for suspicious
    User-Agents and Automatic JS for everyone else.
- **CAPTCHA integration** (optional) — turn this on to require a CAPTCHA on the
  Hard challenge (needs the CAPTCHA module installed).
- **Whitelist duration** — how long (in minutes) a passing IP stays whitelisted
  before it must pass the challenge again.

## Manual IP whitelist

You can list IP addresses or ranges that always bypass the challenge, regardless
of path or mode. Enter one per line in the **Manually whitelisted IPs** field.
Supported formats:

- Individual IPv4 addresses — `192.168.0.1`
- Individual IPv6 addresses — `2001:db8::1`
- CIDR subnets — `10.0.0.0/8`, `192.168.0.0/24`, `2a01:e0a::/32`

## Manual User-Agent whitelist (advanced)

The **manual User-Agent whitelist** field accepts one **regular expression per
line**, each tested against the incoming request's User-Agent header. A match skips
the challenge. This is useful for letting trusted bots or services through —
monitoring tools, CDN health checks, and the like.

## Managing whitelisted IPs

View and manage the IPs that have passed the challenge (or that you've added
manually) at **Configuration → Security → Challenge Mitigation → Whitelist IPs**.
Expired entries are removed automatically on cron (see
[Installation](../installation/index.md)).

## Save and test

Save the form, then visit a protected path in a fresh browser session (no existing
whitelist entry). You should see the challenge; once you pass it, your IP is
whitelisted for the duration you set and subsequent visits go straight through.

## Setting expectations

Remember this is an application-layer mitigation, not a WAF — it acts once requests
reach Drupal. It reduces bots, spam, and scraping on the paths you choose, but for
high-volume/volumetric attacks a dedicated WAF or CDN remains the right tool. Tune
your protected paths, challenge mode, and whitelist duration to balance protection
against friction for real visitors.
