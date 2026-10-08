<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Hypermedia — agent index

Adds custom, **access-aware** hyperlinks to the `links` objects of JSON:API responses via a
`LinkProvider` plugin type. Depends on `jsonapi`. Pure developer/API module: **no** config UI
(`configure: null`), no permissions, no routes, no Drush. You extend it by writing plugins.

- **Write a link provider plugin (annotation keys, contexts, `getLink`, AccessRestrictedLink),
  derivers, the info-alter hook, and declaring link relation types** →
  [plugins/link-providers.md](plugins/link-providers.md)
- **How it hooks into JSON:API (normalizer decoration, the manager, execution flow)** →
  [api/architecture.md](api/architecture.md)

Key facts:
- Plugin type: annotation `@JsonapiHypermediaLinkProvider`, namespace
  `Plugin/jsonapi_hypermedia/LinkProvider`, manager service
  `jsonapi_hypermedia_provider.manager` (`LinkProviderManager`), base class
  `Drupal\jsonapi_hypermedia\Plugin\LinkProviderBase`.
- A plugin returns a `Drupal\jsonapi_hypermedia\AccessRestrictedLink` from `getLink($context)`;
  return `AccessRestrictedLink::createInaccessibleLink()` to omit the link.
- Contexts: `top_level_object` (with sub-type: entrypoint/collection/individual/error/…),
  `resource_object` (`true` or `type--bundle`), `relationship_object` (`true` or
  `[type, field]`).
- Custom relation types are declared in `{module}.link_relation_types.yml`.
- Worked examples live in the module's `examples/` folder (not enabled by default).
