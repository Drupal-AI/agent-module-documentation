# Services: HostingInfo & HostingInfoFactory

Two public services translate `dropsolid_purge.config` into the values the purger and headers use.
(Defined in `dropsolid_purge.services.yml`.)

## `dropsolid_purge.hostinginfofactory` — `HostingInfoFactory`

Wraps `\Drupal::config('dropsolid_purge.config')`. Accessors:

- `getSiteName()` / `getSiteEnvironment()` / `getSiteGroup()` — raw config values.
- `getLoadBalancers()` — array of `protocol://ip:port` URIs (skips entries without an `ip`;
  protocol defaults to `http`, port omitted if empty).
- `getLoadBalancersConfig()` — the raw `loadbalancers` array.

## `dropsolid_purge.hostinginfo` — `HostingInfo`

Constructed from the request stack, `Settings`, and the factory. On build it:

- resolves the Drupal **site path** (`DrupalKernel::findSitePath`) for multisite support,
- collects the load-balancer addresses and site name/environment/group from the factory,
- sets the **balancer token** to `$settings['dropsolid_purge_token']` or, if unset, the site name,
- computes a unique **site identifier** = `Hash::siteIdentifier(siteName, sitePath, environment,
  group)` — this is the value emitted as the `X-Dropsolid-Site` header.

Accessors: `getBalancerAddresses()`, `getBalancerToken()`, `getSiteEnvironment()`, `getSiteGroup()`,
`getSiteIdentifier()`, `getSiteName()`, `getSitePath()`.

You normally don't call these directly — the purger and the `dropsolidpurgesiteheader` TagsHeader
plugin consume them. They are the seam to read/override if you extend the module.
