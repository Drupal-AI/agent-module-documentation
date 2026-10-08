<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Invalidate Cache provides a REST endpoint that invalidates cache tags.

---

REST Invalidate Cache provides a **REST endpoint that invalidates specific cache tags** — letting an
external system (e.g. a CI/deploy pipeline or CMS integration) tell Drupal to clear caches for given tags over
REST, without a full cache rebuild. It depends on core REST, in the Performance package.

Use it to trigger targeted cache invalidation from outside. It is a performance/integration feature. Security
note: it is a **REST resource** (so it requires the granted REST permission — not anonymous by default), but
**cache invalidation is a privileged, abusable action** — repeatedly invalidating tags forces expensive rebuilds
(a performance/DoS lever), so grant the permission **only to trusted machine accounts**, authenticate the caller,
and consider rate-limiting. It has no access-control role beyond that permission. Configure the REST resource and
permission.

---

- Invalidate cache tags via REST.
- Clear caches for given tags.
- Serve external cache integration.
- Depend on core REST.
- Serve performance/integration.
- Avoid a full rebuild.
- REQUIRE the granted REST permission (not anonymous).
- KNOW cache invalidation is privileged/abusable.
- Grant it only to trusted machine accounts.
- Authenticate the caller + consider rate-limiting.
- Have no access-control role beyond permission.
- Configure the resource and permission.
- Handle cache invalidation.
- Invalidate tags.
- Configure the endpoint.
- Clear caches.
- Handle the integration.
- Trigger invalidation.
- Restrict the permission.
- Provide REST cache invalidation.
