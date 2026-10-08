<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture: how links get injected

## Services (`jsonapi_hypermedia.services.yml`)

1. **`jsonapi_hypermedia_provider.manager`** — the plugin manager
   (`Drupal\jsonapi_hypermedia\Plugin\LinkProviderManager`, `parent: default_plugin_manager`).
   It is injected with `@current_route_match` and `@plugin.manager.link_relation_type`.
2. **`serializer.normalizer.link_collection.jsonapi_hypermedia`** — **decorates** the core
   `serializer.normalizer.link_collection.jsonapi` normalizer (decoration_priority 5), class
   `Drupal\jsonapi\Normalizer\JsonapiHypermediaImpostor\JsonapiHypermediaLinkCollectionNormalizer`.
   It receives `@current_user`, the provider manager, and `@renderer`, and is tagged as a
   `api_json` normalizer.

Note the "impostor" namespace: the decorating normalizer is deliberately placed in the
`Drupal\jsonapi\Normalizer\...` namespace to satisfy a JSON:API internal check; the
`service_collector` tag is applied manually in `JsonApiHypermediaServiceProvider` instead of the
YAML (see the commented tag in the services file).

## Execution flow

1. JSON:API builds a `LinkCollection` for some context (top-level document, resource object, or
   relationship) and normalizes it.
2. The decorating normalizer calls the manager's `getLinkCollection($context)`.
3. `LinkProviderManager::getApplicableDefinitions($context)` filters plugins by context type
   (`top_level_object` → `JsonApiDocumentTopLevel`, `resource_object` → `ResourceObject`,
   `relationship_object` → `Relationship`) and by the specific subtype / resource type /
   `[type, field]` tuple in each definition's `link_context`.
4. For each applicable provider it calls `getLink($context)`, receiving an
   `AccessRestrictedLink`. Inaccessible links are skipped; accessible ones are validated and
   merged into the link collection under the provider's `link_key`.
5. Access + cacheability from every provider is accumulated and bubbled up so responses vary and
   invalidate correctly (per user/session/entity as the provider declared).

## `AccessRestrictedLink` (the return type)

`Drupal\jsonapi_hypermedia\AccessRestrictedLink` wraps a `jsonapi\JsonApiResource\Link` behind an
`AccessResult`:

- `createLink($access_result, $link_cacheability, $url, $link_relation_type, $target_attributes = [], $context = NULL)`
  — an accessible (or access-checked) link. An optional `$context` `Url` sets an absolute
  `anchor` target attribute when the link's context differs from its document location.
- `createInaccessibleLink($access_cacheability)` — a forbidden link that is dropped from output.
- `isAllowed()` / `getInnerLink()` — used by the manager; `getInnerLink()` throws if not allowed.

## What an agent should know

- There is **no runtime configuration** — behaviour is entirely defined by the installed
  `LinkProvider` plugins. To change output, add/alter plugins (see
  [../plugins/link-providers.md](../plugins/link-providers.md)).
- The module only affects the `api_json` (JSON:API) format responses.
- Because it decorates a normalizer and collects plugins, after adding a plugin or changing
  services you must rebuild caches (`drush cr`).
