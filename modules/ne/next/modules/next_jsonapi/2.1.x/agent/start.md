<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js JSON:API — agent index

Thin JSON:API helper for [next](../../../../2.1.x/agent/start.md): raises the JSON:API max page size
to **1000** so a Next.js build can fetch large collections in fewer requests. Pure service
decoration — no config UI, no config entities, no permissions, no Drush. Depends on `jsonapi`,
`decoupled_router`, `subrequests`, `next`.

- **How the decoration works (ServiceProvider, EntityResource subclass, size_max)** →
  [api/jsonapi.md](api/jsonapi.md)

Key facts:
- `NextJsonapiServiceProvider::alter()` sets the `jsonapi.entity_resource` service class to
  `Drupal\next_jsonapi\Controller\EntityResource` and calls `setMaxSize('%next_jsonapi.size_max%')`.
- Parameter `next_jsonapi.size_max` = **1000** (core JSON:API default max is 50).
- The subclass overrides `getJsonApiParams()` to apply the larger `OffsetPage` max when `fields` is set.
- Change the cap by overriding the `next_jsonapi.size_max` parameter (no admin form).
