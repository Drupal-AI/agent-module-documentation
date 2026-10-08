<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Next.js connects a Drupal back end to one or more Next.js front-end apps, providing authenticated preview/draft URLs, an in-Drupal iframe live preview of the decoupled site, and on-demand revalidation (ISR) so the front end rebuilds pages when content changes.

---

The module models each front end as a `next_site` config entity (base URL, preview URL, preview secret, revalidate URL, revalidate secret) and maps Drupal entity types/bundles to those sites via a `next_entity_type_config` config entity. It defines four plugin types that make the integration pluggable: **site_resolver** (which Next.js site(s) an entity belongs to — `site_selector` or `entity_reference_field`), **site_previewer** (how Drupal renders the decoupled preview — `iframe`), **preview_url_generator** (how a secure preview URL is built — `simple_oauth`, or `jwt` from the next_jwt submodule), and **revalidator** (how the front end is told to rebuild — `path` or `cache_tag`). Global choices live in `next.settings` (default previewer `iframe`, default generator `simple_oauth`, `debug`). When an entity is inserted/updated/deleted, `next.module` dispatches an `EntityActionEvent`; the `EntityActionEventRevalidateSubscriber` looks up the entity's `next_entity_type_config`, runs its revalidator, and (on success) fires an `EntityRevalidatedEvent`. For editors, the canonical entity page is replaced (via a decorated `main_content_renderer.html`) with the configured site previewer, which builds an authenticated preview URL through `NextSite::getPreviewUrlForEntity()`. It also alters `decoupled_router` output to add the entity path and exposes POST routes (`/next/draft-url`, `/next/preview-url`) that validate incoming preview requests. It depends on decoupled_router, simple_oauth, subrequests and pathauto, and the actual JSON:API/GraphQL data and the Next.js app itself live outside Drupal (see the next_jsonapi / next_graphql submodules and next-drupal).

---

- Register a Next.js front end against Drupal by creating a `next_site` (base URL + secrets).
- Preview unpublished/draft content in an iframe on the Drupal entity page before it's live.
- Generate short-lived, role-scoped preview URLs with the simple_oauth preview URL generator.
- Switch to JWT-based, user-scoped preview URLs by enabling the next_jwt submodule.
- Map the Article content type to a specific Next.js site via a `next_entity_type_config`.
- Resolve the target site from an entity reference field (multi-site) with `entity_reference_field`.
- Manually assign one or more Next.js sites to an entity type with the `site_selector` resolver.
- Trigger on-demand ISR revalidation of the front end when a node is saved (path revalidator).
- Revalidate by cache tag instead of path using the `cache_tag` revalidator.
- Revalidate additional paths (e.g. `/blog`) whenever an entity of a type changes.
- Enable draft mode per entity type so editors see live drafts in the front end.
- Run several Next.js sites from one Drupal (multisite decoupled) with per-entity resolution.
- Add extra data to the editor preview via `hook_next_site_preview_alter` (e.g. moderation controls).
- Expose the content-moderation control form inside the iframe preview automatically.
- Validate incoming preview/draft requests at `/next/draft-url` from the Next.js app.
- Configure the preview iframe width and route-syncing behavior in `next.settings`.
- Enrich `decoupled_router` responses with the resolved entity path to save a JSON:API round-trip.
- Set a per-site revalidate URL/secret so the front end's revalidation endpoint is called securely.
- Provide environment variables for a `next_site` (via its env route) to configure the Next.js app.
- Build a custom `revalidator` plugin to notify a non-Next.js front end or CDN on content change.
- Build a custom `preview_url_generator` for a bespoke auth scheme.
- React to successful revalidations with an `EntityRevalidatedEvent` subscriber (logging, metrics).
- Fall back to the live front-end URL for anonymous users while authenticated editors get preview URLs.
- Integrate GraphQL (via graphql_compose) instead of JSON:API using the next_graphql submodule.
- Cap JSON:API page size for the front end with the next_jsonapi submodule.
