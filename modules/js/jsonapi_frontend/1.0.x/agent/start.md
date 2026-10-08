<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Frontend — agent index

Makes Drupal **JSON:API frontend-ready**: `/jsonapi/resolve` (path→entity+JSON:API URL) and `/jsonapi/routes`
(routes feed). Depends on core `jsonapi`, `path_alias`. Provides permissions. Version **1.0.13**. Core
`^10||^11||^12`.

Decoupled — public endpoints **guarded correctly**: resolver checks `$entity->access('view')`; routes feed
secret-gated with **`hash_equals`**, fails closed with no secret. JSON:API enforces entity/field access on data.
No access role beyond that.
