<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Coveo Secured Search lets Coveo enforce Drupal-style access on search results by defining custom security providers and pushing Drupal user identities to Coveo.

---

`coveo_secured_search` is a submodule of Coveo (depends on `coveo` and `coveo_search_api`) that builds the access-control half of a Coveo integration. It defines a `coveo_custom_security_provider` config entity (managed at `/admin/config/search/coveo/security_providers/custom`) that describes a Coveo custom security provider — its Coveo-side name, the plugin that resolves identities, its organization and the push sources it applies to. It adds a pluggable `coveo_custom_security_provider` plugin type with a `Drupal Provider` implementation that uses the Drupal user id as the identity, and a `custom_provider` (derivative) security provider that bridges these into the base module's search-token generation. A `coveo_identity` Search API backend indexes Drupal identities (item id becomes the identity) into Coveo so that when content is indexed with matching permissions, Coveo returns only results a given user is allowed to see. Identity/provider alter events (`CoveoIdentitiesAlter`, `CoveoSecurityProviderAlter`) allow customization. With this in place, a search component using a custom/Drupal provider issues per-user search tokens scoped to the user's Coveo identity.

---

- Enforce Drupal-style content access on Coveo search results.
- Define Coveo custom security providers as Drupal config entities.
- Manage security providers at `/admin/config/search/coveo/security_providers/custom`.
- Map Drupal users to Coveo identities using the Drupal user id (`Drupal Provider`).
- Push Drupal user identities into Coveo security providers via the `coveo_identity` Search API backend.
- Associate a security provider with one or more Coveo push sources.
- Bridge custom providers into per-user search-token generation (`custom_provider`).
- Issue Coveo search tokens scoped to the current user's identity.
- Preview/secure content by linking providers to a specific Coveo organization.
- Resolve identities from Search API item ids (content-entity data source).
- Alter the identities pushed to Coveo via the `CoveoIdentitiesAlter` event.
- Alter security-provider definitions via the `CoveoSecurityProviderAlter` event.
- Combine with `coveo_search_api` content indexing for a fully secured search.
- Build separate dev/prod secured environments alongside the organization prefix feature.
