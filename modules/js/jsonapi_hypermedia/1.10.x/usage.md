<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Hypermedia lets you add custom, access-aware hyperlinks (HATEOAS affordances) to the `links` objects of Drupal's JSON:API responses through a `LinkProvider` plugin type, so clients can discover actions like "publish", "authenticate", or "next page" instead of hard-coding backend knowledge.

---

The module adds a plugin type, `JsonapiHypermediaLinkProvider` (annotation-based, namespace
`Plugin/jsonapi_hypermedia/LinkProvider`, managed by `LinkProviderManager` /
`jsonapi_hypermedia_provider.manager`), and **decorates** the core JSON:API link-collection
normalizer (`serializer.normalizer.link_collection.jsonapi`) so that whenever JSON:API builds a
`links` object it also runs the applicable link providers and merges in their links. Each plugin
declares a `link_relation_type`, an optional `link_key` (the member name in the `links` object),
and a `link_context` naming where it applies: a `top_level_object` (whole-document links, with a
sub-type such as `entrypoint`, `collection`, `individual`, `error`, …), a `resource_object`
(all resources or a specific `type--bundle`), or a `relationship_object` (all relationships or a
`[type, field]` tuple). Its `getLink($context)` returns an `AccessRestrictedLink` built from an
`AccessResult`, cacheability, a `Url`, the relation type, and optional target attributes; a
provider can also return `AccessRestrictedLink::createInaccessibleLink()` to *omit* a link (e.g.
hide "publish" on already-published content or from users lacking permission), so a link's mere
presence conveys an available action. Providers can be derived (via a plugin deriver) to fan out
across many resource types, and definitions can be altered with
`hook_jsonapi_hypermedia_provider_info_alter()`. New link relation type names are declared in a
`{module}.link_relation_types.yml` file. The module ships **no** configuration UI, permissions,
routes, or Drush commands — it is a pure developer/API extension of JSON:API, with worked
examples under its `examples/` directory (authentication link, publish/unpublish link, image
relationship link).

---

- Add an `authenticate`/`logout` link to the JSON:API entrypoint so clients discover how to log in.
- Expose a `publish` link only on unpublished nodes the user may publish (and `unpublish` vice-versa).
- Convey "this action is available" purely by the presence/absence of a link (access-aware HATEOAS).
- Add `next`/`prev`/`first`/`last` style affordances to collection documents.
- Attach a `related` or `enclosure` link to a specific relationship (e.g. an article's author avatar).
- Decouple clients from backend field names by giving them ready-to-follow action links.
- Provide an `item` link on each collection entry pointing at its individual resource.
- Add operation links (edit/delete) to resource objects gated by entity access.
- Surface a workflow-transition endpoint as a link on moderated content.
- Add links to error documents pointing at documentation or a support endpoint.
- Build a self-describing API where the entrypoint advertises available operations.
- Generate per-resource-type links automatically via a plugin deriver.
- Target links at one exact resource type + bundle (`node--article`) only.
- Target links at one relationship field (`[node--article, uid]`) only.
- Hide a link (return an inaccessible link) when following it would cause a client error.
- Set link target attributes such as `type` (media type) or a JSON:API `data` payload for the action.
- Declare custom link relation types in a `*.link_relation_types.yml` file.
- Alter or remove other modules' link providers with `hook_jsonapi_hypermedia_provider_info_alter()`.
- Add cache contexts/tags to links so they vary correctly per user/session.
- Provide a `describedby` link to an OpenAPI/schema resource.
- Give a decoupled front-end discoverable "add to cart"/"checkout" style affordances.
- Add absolute `anchor` context to a link when its context differs from its document location.
- Progressively enhance an existing JSON:API without changing resource schemas.
- Teach clients about available state transitions without out-of-band documentation.
- Ship reusable link-provider plugins in a custom module for a decoupled application.
