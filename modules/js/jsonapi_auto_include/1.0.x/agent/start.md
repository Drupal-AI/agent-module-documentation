<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Auto Include (jsonapi_auto_include) — agent index

**Adds `jsonapi_auto_include=1` support that auto-fills the JSON:API `include` parameter with every relationship (recursive, depth 3) on the matched resource type.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Dependencies:** drupal:jsonapi (compatible with jsonapi_extras)
- **Service:** `jsonapi_auto_include.event_subscriber` → `IncludeAllRelationshipsSubscriber` on KernelEvents::REQUEST (priority 300)
- **Trigger:** query flag `jsonapi_auto_include=1` on any path under the JSON:API prefix (`jsonapi_extras.settings:path_prefix`, default `/jsonapi`)
- **Config:** none (works on enable)
- **Security:** Does NOT bypass entity/node access. It only rewrites the `include` query parameter and returns control to core JSON:API, which still applies its normal per-resource access checks to every included entity — unauthorized includes are omitted by core, not exposed. No routes, permissions, or entity loading of its own. Main risk is performance/response-size (full-graph includes to depth 3), not access control.

See [api/auto-include.md](api/auto-include.md)