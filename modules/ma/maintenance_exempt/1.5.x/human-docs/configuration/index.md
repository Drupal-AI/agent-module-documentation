# Configuration

Maintenance Exempt has **no dedicated settings page**. Instead it adds three
extra fields to Drupal's core maintenance-mode form at **Configuration →
Development → Maintenance mode** (`/admin/config/development/maintenance`). Fill
in whichever ones you need, and save. The values are stored in the
`maintenance_exempt.settings` config object.

The form also displays your current client IP, which makes it easy to add your
own address to the exempt list.

## The three exemption settings

- **Exempt IPs** (`exempt_ips`) — one entry per line. Each can be a single IP
  address (for example `203.0.113.5`) or a **CIDR range** (for example
  `203.0.113.0/24`) so a whole team or network can preview the site. Any visitor
  whose IP matches is let through.
- **Exempt URLs** (`exempt_urls`) — one path pattern per line. Requests whose path
  matches are let through, which is handy for health-check endpoints, webhooks,
  or a payment-gateway return URL that must keep working during maintenance.
  Matching works against both a path alias and its underlying system path.
- **Exempt query string** (`query_key`) — a secret token. A request that includes
  `?<query_key>` in its URL is let through, and the exemption is then remembered
  for the rest of that browser session.

All three are inactive until you fill them in. Leaving them empty means the
module matches only core's *access site in maintenance mode* permission — i.e.
identical to stock Drupal.

## How a request is let through

While maintenance mode is on, Drupal checks each request and lets it through on
the **first** of these that matches:

1. The user has the core **access site in maintenance mode** permission.
2. The client IP is listed exactly in **Exempt IPs**.
3. The client IP falls inside a **CIDR range** in Exempt IPs.
4. The request path (or the system path behind an alias) matches an **Exempt
   URL** pattern.
5. The session already carries a valid query-key exemption from earlier.
6. The **query key** is set and present in the request's query string — this also
   stores the exemption in the session for subsequent requests.

## Setting it from the command line or settings.php

```bash
ddev drush config:set maintenance_exempt.settings query_key launch2026 -y
```

```php
// settings.php — per-environment override
$config['maintenance_exempt.settings']['exempt_ips'] = "203.0.113.5\n198.51.100.0/24";
```

## Caveats worth knowing

- **The query key is a shared secret.** Anyone who has the link can bypass
  maintenance, anonymously, and the exemption sticks for their whole session.
  Treat it as a password: make it unguessable, rotate it, and use HTTPS.
- **CIDR matching is IPv4-only.** IPv6 ranges won't match as CIDR, though an
  exact IPv6 address listed in Exempt IPs still matches.
- **Behind a proxy or CDN,** make sure Drupal's trusted-proxy / `reverse_proxy`
  settings are correct, so the real visitor IP is used before you rely on IP
  exemptions.
