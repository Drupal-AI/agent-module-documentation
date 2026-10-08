<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The GraphQL 3.x schema this module adds

## Prerequisite

```bash
# Only works on the GraphQL 3.x branch:
composer require 'drupal/graphql:^3' drupal/metatag drupal/graphql_metatag
drush en graphql_core metatag graphql_metatag -y
```

With `drupal/graphql` 4.x/5.x installed, `drush en graphql_metatag` fails —
`graphql_core` does not exist on those branches. There is no 4.x-compatible code path in this
module; a decoupled site on GraphQL 4/5 has to write its own data producer around
`metatag.manager` instead.

## Fields

| Field | Type | Parents | Resolver |
|---|---|---|---|
| `entityMetatags` | `[Metatag]` | `Entity` | `EntityMetatags::resolveValues()` |
| `entitySchemaMetatags` | `String` | `Entity` | `EntitySchemaMetatags` (extends the above, returns JSON) |
| `metatags` | `[Metatag]` | `InternalUrl`, `EntityCanonicalUrl` | `Metatags::resolveValues()` |
| `key` | `String` | `Metatag` | `Key` — the tag's identifier from the render array |
| `value` | `MapArray` | `Metatag` | `Value` — the tag's attribute map |

All carry `secure = true`, so they are available without the GraphQL "insecure fields" switch.

## Entity path — what `entityMetatags` actually does

```php
$tags = $this->metatagManager->tagsFromEntityWithDefaults($entity);   // entity values + defaults
$tags = $this->replaceTokens($tags, $entity);                          // metatag.token, entity langcode
$this->moduleHandler->alter('metatags', $tags, ['entity' => &$entity, 'graphql_context' => $context]);
$elements = $this->metatagManager->generateRawElements($tags, $entity);
$elements = array_filter($elements, fn($m) => !NestedArray::getValue($m, ['#attributes', 'schema_metatag']));
foreach ($elements as $element) { yield $element; }
```

Consequences worth knowing:

- Defaults are included, so a node with no per-node Metatag values still returns the bundle/global
  defaults.
- Tokens are resolved server-side with `'langcode' => $entity->language()->getId()` — the values
  you receive are final strings, not `[node:title]`.
- `hook_metatags_alter()` implementations run, and receive `graphql_context`, so you can branch on
  "this is a GraphQL request".
- Anything `schema_metatag` owns is stripped here; use `entitySchemaMetatags` for JSON-LD.
- Only content entities that are not new resolve; otherwise the field yields `NULL`.

## URL path — `metatags`

```php
$resolve = $this->subRequestBuffer->add($value, function () {
  $tags = metatag_get_tags_from_route();
  $this->moduleHandler->alter('metatags_attachments', $tags);
  $tags = NestedArray::getValue($tags, ['#attached', 'html_head']) ?: [];
  // drop schema_metatag entries
  return array_map('reset', $tags);
});
```

This runs inside GraphQL's **sub-request buffer**, i.e. a real sub-request for the URL, so
route-context-dependent tags (views pages, taxonomy pages, front page) resolve the way they would
when the page is rendered. Note the alter hook here is `hook_metatags_attachments_alter()`, not
`hook_metatags_alter()`.

## Types and how a tag is classified

Each yielded value is a render array like
`['#tag' => 'meta', '#attributes' => ['property' => 'og:title', 'content' => '…']]`.
`applies()` picks the concrete type:

| Type | Matches |
|---|---|
| `MetaProperty` | `#tag === 'meta'` and `property` attribute present |
| `MetaHttpEquiv` | `#tag === 'meta'` and `http-equiv` present |
| `MetaItemProp` | `#tag === 'meta'` and `itemprop` present |
| `MetaValue` | `#tag === 'meta'` with none of the above (i.e. `name=`) |
| `MetaLinkHreflang` | `#tag === 'link'` and `hreflang` present |
| `MetaLink` | `#tag === 'link'` |

All implement the `Metatag` interface (`@GraphQLInterface id = "meta_tag"`, typed data `metatag`),
so `key` and `value` are available on every variant.

## Example queries

```graphql
# Entity metatags on a node route
query NodeSeo($path: String!) {
  route(path: $path) {
    ... on EntityCanonicalUrl {
      entity {
        entityLabel
        entityMetatags {
          key
          value
          __typename          # MetaValue | MetaProperty | MetaLink | …
        }
        entitySchemaMetatags  # JSON string of Schema.org output
      }
    }
  }
}
```

```graphql
# Metatags for an arbitrary internal URL
query UrlSeo($path: String!) {
  route(path: $path) {
    ... on InternalUrl {
      metatags { key value }
    }
  }
}
```

Client-side, `value` arrives as an object (the attribute map), e.g.
`{"property": "og:title", "content": "My page"}` — read `content` (or `href` for links) rather
than expecting a bare string.

## Extending

- Add a tag type the module does not classify by writing your own `@GraphQLType` with
  `interfaces = {"Metatag"}` and an `applies()` that inspects `#tag`/`#attributes`; the resolvers
  yield render arrays untouched, so no change to the field plugins is needed.
- To change values globally, implement `hook_metatags_alter()` (entity path) and/or
  `hook_metatags_attachments_alter()` (URL path) — both are honoured.
