<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Rest Extra adds REST resources that expose a site's entity configuration (bundles, fields, view modes) for headless/decoupled clients.

---

Entity Rest Extra ships three read-only REST resource plugins that answer structural questions about the content model instead of serving content: which bundles an entity type has (`/entity/{entity_type}/bundles`), which view modes a bundle supports (`/entity/{entity_type}/{bundle}/view_modes`), and which configured fields a bundle has, with their field-config and field-storage definitions (`/entity/{entity_type}/{bundle}/fields`). It is built on core's REST and Serialization stack and lists the contributed REST UI module as a dependency, which is the recommended way to enable the resources, pick an authentication provider, and choose the JSON format. It is meant for headless Drupal setups where a JavaScript or mobile front end needs to discover the content model over the API rather than hard-coding it.

Each resource is a standard Drupal `@RestResource` plugin, so it is turned on per-resource through Drupal's REST configuration and each resource carries the usual `restful get …` permission that you assign to roles. The bundles resource enriches node responses with each node type's description; the fields resource resolves every `field_config` whose id starts with `{entity_type}.{bundle}.`; the view-modes resource lists the `entity_view_display` config entries for the bundle. The module has no settings form and no config of its own — everything is configured through the REST layer.

---

- Let a decoupled front end discover which bundles exist for an entity type.
- List node content types with labels, translatable flags, and descriptions over REST.
- Enumerate the bundles of any entity type (comment, taxonomy_term, media, etc.).
- Fetch the full field list for a specific bundle, e.g. `node/article/fields`.
- Read field-config and field-storage definitions per field for a headless client.
- Retrieve the view modes configured for a bundle to drive display switching.
- Build a client-side form generator that adapts to the site's actual fields.
- Introspect the content model instead of hard-coding bundle/field names in JS.
- Power a mobile app that needs the site's structure at runtime.
- Provide admin/structural metadata to an external integration.
- Generate documentation of a site's content model from live API responses.
- Feed a static-site generator with bundle and field metadata.
- Detect newly added fields or view modes without redeploying the client.
- Map a bundle's fields to a GraphQL or TypeScript type in a build step.
- Serve content-model metadata as JSON to any authenticated API consumer.
- Combine with core REST content endpoints so a client can both discover and read content.
- Enable only the resources you need through the REST UI screen.
- Choose an authentication provider and JSON format when enabling each resource.
- Assign each resource's `restful get …` permission to the intended roles.
- Query view modes to know which display variants a client can request.
- Discover taxonomy or media bundles for a dynamic admin UI.
- Let a CI job verify that expected fields exist on a bundle via the API.
