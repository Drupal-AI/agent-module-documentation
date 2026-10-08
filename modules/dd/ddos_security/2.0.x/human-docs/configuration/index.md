# Configuration

DDoS Security needs a little configuration to be useful: you tell it how many
requests per client IP count as "too many", what should happen to an IP that
crosses that line, and what blocked visitors see. You also manage the blocked-IP
list from here.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/ddos-security`** (the module's screens live under the
   **Security** area of the admin configuration).

## Rate threshold

The core setting is the **request-rate threshold** — how many requests from a
single client IP, within the module's measurement window, are allowed before that
IP is blocked. Set this to match your real traffic patterns:

- Too low, and you risk blocking legitimate users (shared office IPs, mobile
  carrier gateways, or a busy CDN edge can all send many requests from one
  address).
- Too high, and abusive clients get more room before they're stopped.

Start conservative, watch the blocked-IP list, and tune from there.

## Block behaviour and message

- **Block behaviour** — how the module responds once an IP is over the threshold
  (for example, denying further requests from that IP).
- **Block / alert message** — the message shown to a visitor whose IP has been
  blocked. Keep it clear but generic; there's no need to reveal your threshold or
  internal logic.

## Managing blocked IPs

The admin UI lets you **view, search, and export** the list of currently blocked
IP addresses. Use it to:

- Confirm the module is catching the abuse you expect.
- Spot false positives (a legitimate IP that shouldn't be blocked) and act on
  them.
- Export the list for record-keeping or to feed an upstream block at your CDN or
  firewall.

## Save and monitor

Save your settings, then keep an eye on the blocked-IP list for the first days
after enabling — that's the fastest way to tell whether your threshold is right.

> **Remember the boundary of this tool.** DDoS Security mitigates
> *application-layer* abuse from identifiable IPs. It cannot absorb a volumetric
> network DDoS, because the traffic has already reached PHP by the time this code
> runs. For real DDoS resilience, pair it with a CDN, WAF, or provider-level
> scrubbing, and make sure your trusted-proxy / `X-Forwarded-For` configuration is
> correct so the module blocks the true client IP.
