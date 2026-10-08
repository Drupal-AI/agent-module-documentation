# Configuration

Loki does nothing until you enable it here and give it a failure probability. All
of the conditions below have to be satisfied for a given request to be turned into
an error, so you can scope the chaos quite precisely.

## Open the settings form

1. Log in as a user with the **Administer Loki** permission.
2. Go to **Configuration → Development → Loki**, or navigate directly to
   `/admin/config/development/loki`.

This settings page is **always exempt** from Loki's error injection, so you can
never lock yourself out of it.

## Enable

The master switch. **Off by default.** Nothing happens until you tick this. Turn
it off again to stop the chaos immediately without losing your other settings.

## Randomness (percentage chance)

The per‑request probability, from 0 to 100, that an eligible request is turned
into an error. For example, 25 means roughly one in four matching requests fails.
Set it low to simulate intermittent flakiness, or high to reliably trigger errors
while testing. (Internally this is a simple random roll, not a security token.)

## Time window (optional)

An optional start and end time of day. When set, Loki only injects errors during
that window; outside it, all requests are served normally. Leave it open if you
want the chaos to apply at any time.

## Affected roles

Which user roles are subject to the simulated errors. **Anonymous** by default,
which is usually what you want — it lets you hammer the site as an anonymous
visitor (the way a CDN's cache‑miss fetch would) while still browsing normally as
an authenticated admin. Add or change roles to target a specific audience.

## Response codes

Which **5xx** status codes Loki is allowed to return. The default set is **500,
502, 503, and 504**. When a request is selected to fail, Loki picks one of the
enabled codes. Narrow this down if you want to test how your edge reacts to a
specific code (for example only 503s).

## Save

Click **Save configuration**. With **Enable** ticked and a non‑zero randomness,
matching requests will now start returning the configured 5xx codes — use this to
exercise your CDN/proxy `Stale-If-Error` and failover behaviour, then turn
**Enable** off when you're finished.
