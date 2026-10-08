<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Coveo connects a Drupal site to the Coveo hosted (SaaS) search platform for pushing content and rendering Coveo-powered search experiences.

---

The Coveo project (2.0.x, a large refactor of version 1) integrates Drupal with the Coveo Cloud search platform. The base `coveo` module defines two config entities — a `coveo_organization` (holds the Coveo organization ID, a push source ID + push API key, a read-only flag, an auto-sync flag and an environment prefix) and a `coveo_search_component` (holds a search access key, its organization and a security provider) — plus a pluggable `coveo_security_provider` plugin type and an admin UI under `/admin/config/search/coveo`. A `/coveo/refresh` JSON endpoint mints per-user Coveo search tokens for the front end. Three submodules build on it: `coveo_search_api` adds Search API backends/processors that push indexed content (and file attachments) to a Coveo Push source; `coveo_secured_search` adds custom security providers and identity push so Coveo enforces Drupal-style access on results; and `coveo_atomic` provides a block and Twig helpers that embed Coveo's Atomic (web-component) search UI. It requires PHP 8.3+, ext-curl and several `neclimdul/coveo-*` OpenAPI client libraries via Composer, and targets Drupal core ^10 || ^11. Search API is a suggested (and, for the search-api submodule, required) dependency. The module is marked as still under active development.

---

- Push Drupal content into a Coveo Cloud index via Search API and a Coveo Push source.
- Serve site search results from Coveo's hosted (SaaS) search platform.
- Embed a Coveo Atomic search interface (search box, facets, tabs, results, pager) as a Drupal block.
- Configure one or more Coveo organizations under `/admin/config/search/coveo/organization`.
- Store a push source ID and push API key per organization for indexing.
- Link a second organization as read-only to preview production changes safely.
- Namespace fields/elements per environment with an organization prefix (dev/test sub-environments).
- Auto-sync Coveo field definitions when Search API fields change.
- Define reusable search components with their own search access key at `/admin/config/search/coveo/search_components`.
- Generate per-user Coveo search tokens through the `/coveo/refresh` endpoint for the Atomic UI.
- Choose a security provider (Email, Token pass-through, or Drupal) per search component.
- Enforce access control on search results using Coveo security identities that mirror Drupal users.
- Push Drupal user identities to Coveo custom security providers (secured search).
- Index file/attachment content by uploading to Coveo file containers.
- Build faceted search UIs with Coveo Atomic facet, tab and sort components.
- Override the default Atomic template per search ID or component in your own theme.
- Convert Drupal field names to Coveo field names in Twig with `atomic_field` / `atomic_fields` filters.
- Run admin audit and Views-driven queries against a Coveo organization with a Search API key.
- Alter documents, batches, fields, tokens and identities via dispatched events before they reach Coveo.
- Manage multiple Coveo search experiences (organizations + components) from one Drupal admin section.
- Provide granular permissions: administer Coveo search vs. access Coveo search.
