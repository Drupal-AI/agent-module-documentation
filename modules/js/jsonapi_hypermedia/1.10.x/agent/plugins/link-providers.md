<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a LinkProvider plugin

## Anatomy

- **Annotation:** `@JsonapiHypermediaLinkProvider` (class
  `Drupal\jsonapi_hypermedia\Annotation\JsonapiHypermediaLinkProvider`).
- **Namespace / discovery:** `Plugin/jsonapi_hypermedia/LinkProvider` in your module.
- **Base class:** extend `Drupal\jsonapi_hypermedia\Plugin\LinkProviderBase` (implements
  `LinkProviderInterface`). Implement `ContainerFactoryPluginInterface` if you need services.

## Annotation keys

| Key | Meaning |
|---|---|
| `link_relation_type` | The RFC 8288 relation type of the link (e.g. `item`, `publish`, `authenticate`). `LinkProviderBase::getLinkRelationType()` returns the definition value; override the method for dynamic types. |
| `link_key` | The member name under `links`. Defaults to the relation type if omitted. |
| `link_context` | Where the provider runs (see below). Required. |
| `default_configuration` | Array of config values passed to the plugin instance. |
| `id` / `deriver` | Standard plugin keys; use a `deriver` to generate one provider per resource type. |

## `link_context` values

Exactly one of these keys (the manager maps context objects to types):

- `top_level_object: true | <subtype>` — the document-level `links`. Subtypes:
  `entrypoint`, `success`, `error`, `individual`, `collection`, `relationship`. Context object
  is a `JsonApiDocumentTopLevel`.
- `resource_object: true | "<type>--<bundle>"` — a resource object's `links`. `true` = every
  resource; a type name (e.g. `node--article`) limits it. Context object is a `ResourceObject`.
- `relationship_object: true | {"<type>", "<field>"}` — a relationship object's `links` (also
  appears on the top-level links of relationship responses like
  `/node/article/{id}/relationships/uid`). Context object is a `Relationship`.

## `getLink($context)` — the core method

Return a `Drupal\jsonapi_hypermedia\AccessRestrictedLink`:

```php
use Drupal\Core\Access\AccessResult;
use Drupal\Core\Cache\CacheableMetadata;
use Drupal\Core\Url;
use Drupal\jsonapi_hypermedia\AccessRestrictedLink;

public function getLink($context) {
  // $context is JsonApiDocumentTopLevel | ResourceObject | Relationship per your link_context.
  $url = Url::fromUri('internal:/user/login', ['query' => ['_format' => 'json']]);
  $cacheability = (new CacheableMetadata())->addCacheContexts(['user.roles:anonymous']);
  return AccessRestrictedLink::createLink(
    AccessResult::allowed(),   // or an access check; add cacheable dependencies!
    $cacheability,
    $url,
    $this->getLinkRelationType(),
    ['type' => 'application/json']   // optional target attributes (incl. a JSON:API `data` payload)
  );
}
```

To **omit** a link (not just deny access — remove it from the response), return:

```php
return AccessRestrictedLink::createInaccessibleLink($cacheability);
```

Use this when following the link would be invalid (e.g. a `publish` link on already-published
content) or the user lacks permission. The link's presence itself is the affordance.

## Derivers

To emit one provider per resource type, set `deriver = "…\\MyDeriver"` (a
`ContainerDeriverInterface`) and build definitions in `getDerivativeDefinitions()` — e.g. the
bundled `EntityPublishedInterfaceLinkProviderDeriver` derives publish/unpublish providers for
every publishable resource type, passing `status_field_name` in each derivative's configuration.

## Declaring link relation types

Custom relation type names go in `your_module.link_relation_types.yml`:

```yaml
publish:
  description: "Target points to a resource where the context can be published."
  reference: '[https://jsonapi.org/format/#document-links-link-relations]'
```

The module itself ships `add`, `update`, `remove`; the examples add `authenticate`, `logout`.

## Altering providers

`hook_jsonapi_hypermedia_provider_info_alter(&$definitions)` lets another module change or
remove link-provider plugin definitions.

## Worked examples (in `examples/`, not enabled)

- `AuthenticationLinkProvider` — `top_level_object: true`; emits `authenticate` (anon) or
  `logout` (auth), always accessible, with a `type` target attribute.
- `EntityPublishedInterfaceLinkProvider` (+deriver) — `resource_object`; emits `publish` /
  `unpublish` with a JSON:API `data` payload, access-gated on entity + field update access and
  current published state.
- `MutableResourceTypeLinkProvider` (+deriver) — `add`/`update`/`remove` affordances.
