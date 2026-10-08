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
