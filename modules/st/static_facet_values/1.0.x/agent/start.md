<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Facet Values (static_facet_values) — agent index
**Facets processor that rewrites a facet's displayed values with static results from a tagged custom service.**

- **Version:** 1.0.x (1.0.0)
- **Core:** >=10
- **Depends on:** facets
- **Extension point:** implement `Drupal\static_facet_values\StaticFacetValuesServiceInterface`; register with tag `static_facet_values` (or `autoconfigure: true`).
- **Service:** `static_facet_values.collection` (StaticFacetValuesCollection) injects all tagged services via `!tagged_iterator`.
- **UI:** enable the "Static facet values" processor on a facet and pick a service.

**Security:** developer extension only — no routes, no permissions, no admin form of its own; behavior is entirely in code you supply.

See [extend/service.md](extend/service.md)
