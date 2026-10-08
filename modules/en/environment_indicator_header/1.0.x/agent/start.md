<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment Indicator Header (environment_indicator_header) — agent index

Adds a `Release` HTTP response header carrying the current release string, complementing the
Environment Indicator toolbar. Package `Development`. Depends on `environment_indicator`. Core
`^9.3 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.1.

- **The service, the response subscriber, the `Release` header and the state key that feeds it** →
  [api/release-header.md](api/release-header.md)

## What it actually is

- One service `environment_indicator_header.current_release_service`
  (`Service\CurrentReleaseService`, arg `@state`): `getCurrentRelease()` returns the string in the
  `environment_indicator.current_release` state key (default `''`).
- One event subscriber `environment_indicator_header.release_header_subscriber`
  (`EventSubscriber\ReleaseHeaderSubscriber`, tagged `event_subscriber`), subscribed to
  `KernelEvents::RESPONSE`. `onResponse()` reads the service; if the value is non-empty it sets
  `$response->headers->set('Release', $current_release)`.
- No config schema, no config objects, no settings form, no routes, no permissions, no plugins,
  no hooks, no Drush commands, no libraries, no submodules. `configure` is null.
- The header value is not configurable and does not come from request input — it is the release
  string an operator stores in state (the same value Environment Indicator's "current release"
  version identifier uses).

## Operate it

- Enable: `drush en environment_indicator_header -y` (pulls in `environment_indicator`).
- Set the value: `drush state:set environment_indicator.current_release v1.2.44` — or in PHP
  `\Drupal::state()->set('environment_indicator.current_release', 'v1.2.44');`.
- Verify: `curl -sI https://site.example | grep -i '^Release:'`.
- Empty/unset state ⇒ no header is added.
