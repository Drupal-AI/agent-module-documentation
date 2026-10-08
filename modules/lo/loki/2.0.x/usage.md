<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Deliberately injects random configurable 5xx error responses so you can test how CDNs and proxies handle origin failures.
---
Despite the name, this is **not** the Grafana Loki log shipper — it is a chaos/testing dev module (named after the Norse trickster god). A response event subscriber (`\Drupal\loki\EventSubscriber\LokiSubscriber`, service `loki.response_subscriber`) hooks `KernelEvents::RESPONSE` and, when enabled, may throw an `HttpException` with a random configured status code (default set: 500/502/503/504) instead of the real response.

Triggering is gated by several config conditions: a master `enable` flag (off by default), a per-request `randomness` percentage (`mt_rand(0,100)`), an optional time-of-day window (`time_min`/`time_max`), and an affected-roles list (default `anonymous`). The Loki settings route itself is always exempt so admins never lock themselves out. Everything is configured at `/admin/config/development/loki` behind the `administer loki` permission (marked `restrict access: true`). The primary use case is testing `Stale-If-Error` (RFC 5861) and edge/origin failover between a CDN/proxy and Drupal. The `mt_rand` usage is only a chaos-probability roll, not a security token.
---
- Test CDN `Stale-If-Error` behaviour against a flaky origin.
- Verify a reverse proxy serves stale content on 5xx.
- Simulate intermittent 500/502/503/504 responses.
- Restrict simulated failures to anonymous users only.
- Restrict simulated failures to a specific role.
- Set a percentage chance of failure per request.
- Limit chaos to a time-of-day window.
- Validate monitoring/alerting fires on 5xx spikes.
- Exercise retry logic in front-end or API clients.
- Confirm error pages render correctly under load.
- Test edge caching failover configuration.
- Choose which 5xx codes are eligible.
- Keep the module installed but disabled until needed.
- Ensure the settings page stays reachable during chaos.
- Demonstrate resilience patterns in a staging environment.
- Turn chaos on/off quickly via one checkbox.
- Reproduce a customer-reported intermittent error.
- Load-test proxy behaviour with randomised failures.