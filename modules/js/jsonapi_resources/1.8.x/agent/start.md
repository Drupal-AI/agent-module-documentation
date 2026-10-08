<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jsonapi_resources — agent start

**Developer framework, no runtime surface of its own.** Core JSON:API won't let you mint your
own JSON:API URLs; this module does. It ships **no routes, resources, config, permissions, or
Drush** — a bare install exposes nothing. Depends on `jsonapi`. Configure = null.

You author a resource by declaring an ordinary route whose default is `_jsonapi_resource`
(a class or service id extending `ResourceBase`) instead of `_controller`, at a path that
starts with `/%jsonapi%`.

- Write a resource class + route (`_jsonapi_resource`, `_jsonapi_resource_types`, `%jsonapi%` path,
  `process()`, response building, the three base classes) → [api/extend.md](api/extend.md)

Key names: base class `Drupal\jsonapi_resources\Resource\ResourceBase` (also `EntityResourceBase`,
`EntityQueryResourceBase`); required public method `process(Request $request, …)`; route defaults
`_jsonapi_resource` + `_jsonapi_resource_types`; response helper `createJsonapiResponse()`;
path placeholder `%jsonapi%` → JSON:API base path (`/jsonapi`); route validator/decorator
`Drupal\jsonapi_resources\Unstable\Routing\ResourceRoutes` (RoutingEvents::ALTER, prio 6000).
The `Unstable\` namespace is **not** public API — depend only on the `ResourceBase` family.

Any `entity:*` route parameter on a resource route is upcast by **either** the entity's UUID
**or** its integer ID automatically (no `converter:` line needed) — the module wires
`AutoEntityConverter` onto it at route-build time. Set an explicit `converter:` to force one form.

## Diff 1.7.x → 1.8.x

Framework behavior is unchanged; the resource-authoring contract (base classes, route defaults,
`process()`, `createJsonapiResponse()`) is identical. Real changes:

- **New: automatic UUID-or-ID upcasting on entity route params.** A new param converter
  `Drupal\jsonapi_resources\ParamConverter\AutoEntityConverter` (service
  `paramconverter.jsonapi_resources.entity_auto`) is auto-assigned by `ResourceRoutes` to every
  `entity:*` parameter that has no explicit `converter:`. The same route now resolves both the
  UUID form (`/jsonapi/user/{uuid}/content`) and the legacy integer-ID form (`/jsonapi/user/42/content`).
  The converter is deliberately scoped to resource routes only — its `applies()` returns FALSE, so it
  never attaches itself to entity params on other routes across the site. An explicit `converter:`
  (e.g. `paramconverter.jsonapi.entity_uuid` or `paramconverter.entity`) opts a parameter out.
- **Include-path validation reworked in `ResourceResponseFactory`** (Unstable, internal). `include`
  paths are now validated against the union of the route's declared resource types' relatable-field
  graph, and applicable paths are resolved in a single call per resource-object type group instead
  of per-path (a correctness + performance change). Invalid include paths still yield a 400 with the
  list of possible values.
- **New tests** cover the param converter and `jsonapi_extras` custom-resource / enhancer-chain
  integration. `LICENSE.txt` added. `.info.yml` version bump to `8.x-1.8`.
