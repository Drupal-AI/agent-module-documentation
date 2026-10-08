<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Next.js JSON:API raises core JSON:API's maximum page size (to 1000) and tweaks query handling so a Next.js front end can fetch large collections in fewer requests when building/regenerating pages.

---

The submodule is a thin service decoration. `NextJsonapiServiceProvider::alter()` swaps the class of the core `jsonapi.entity_resource` service to `Drupal\next_jsonapi\Controller\EntityResource` and calls `setMaxSize('%next_jsonapi.size_max%')` on it; the `next_jsonapi.size_max` container parameter defaults to **1000** (vs core JSON:API's default max of 50). The subclassed `EntityResource` overrides `getJsonApiParams()` so that when a request supplies `fields`, its `OffsetPage` size limit uses the larger `maxSize`, letting the front end request bigger pages (e.g. for static generation of all nodes) without hitting the default cap. It has no configuration UI, config entities, permissions, or Drush; changing the limit means overriding the `next_jsonapi.size_max` parameter (e.g. via a `services.yml` parameter) rather than an admin form. It depends on `jsonapi`, `decoupled_router`, `subrequests`, and `next`. The JSON:API traffic itself is consumed by the external Next.js app (via next-drupal).

---

- Let a Next.js build fetch up to 1000 entities per JSON:API page instead of 50.
- Reduce the number of JSON:API round-trips when statically generating many pages.
- Speed up incremental static regeneration by pulling large collections in one request.
- Raise the effective `page[limit]` cap for the decoupled front end.
- Support `getStaticPaths`-style enumeration of all nodes with fewer requests.
- Keep sparse fieldsets (`fields[...]`) working while allowing bigger pages.
- Override `next_jsonapi.size_max` to a custom cap via a container parameter.
- Avoid patching core JSON:API to change the max page size.
- Pair with next_jsonapi + decoupled_router + subrequests for the standard next-drupal data layer.
- Inspect the live `jsonapi.entity_resource` service to confirm the Next.js decoration is active.
- Serve large menu/taxonomy trees to the front end in one call.
- Improve cold-build performance of a large decoupled site.
- Provide the JSON:API side of the next-drupal integration (vs GraphQL via next_graphql).
- Diagnose page-size limits by reading the `next_jsonapi.size_max` parameter.
- Enable only the JSON:API helpers without other experimental next submodules.
- Keep JSON:API responses standards-compliant while lifting the page cap.
- Batch-fetch related entities via subrequests with a higher page ceiling.
- Reduce API pagination overhead for a headless catalog/blog.
- Confirm the decoration reverts (core class restored) when the submodule is uninstalled.
- Tune `next_jsonapi.size_max` down if a large cap causes memory pressure.
