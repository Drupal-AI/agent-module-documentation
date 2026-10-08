<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig filters (new in 1.1.x)

`src/Twig/UrlEntityExtension.php` registers a Twig extension (service
`url_entity.twig_extension`, tagged `twig.extension`, constructed with `@url_entity.extractor`)
that exposes the four extractor methods as filters. Each filter returns an `EntityInterface` or
`NULL`; assign it to a variable and render the fields you need.

| Filter | Backed by | Argument piped in | Extra args |
|---|---|---|---|
| `\| current_entity` | `UrlEntityExtractor::getCurrentEntity()` | optional `Request` (usually omit) | — |
| `\| referer_entity` | `UrlEntityExtractor::getRefererEntity()` | optional `Request` (usually omit) | — |
| `\| entity_by_route` | `UrlEntityExtension::getEntityByRoute()` → extractor | route name string (nullable) | `routeParameters` array, `options` array |
| `\| entity_by_url` | `UrlEntityExtension::getEntityByUrl()` → extractor | `Drupal\Core\Url` object (nullable) | — |

`getEntityByRoute()` and `getEntityByUrl()` on the extension are thin null-guards: if the piped
route name or `Url` is `NULL` they return `NULL`, otherwise they delegate to the extractor.

## Examples

```twig
{# Entity of the current page #}
{% set entity = null|current_entity %}
{% if entity %}<h2>{{ entity.label }}</h2>{% endif %}

{# Entity of the referring page (depends on the Referer header being sent) #}
{% set from = null|referer_entity %}

{# Entity behind a named route + params #}
{% set node = 'entity.node.canonical'|entity_by_route({ node: 42 }) %}

{# Entity behind a Url object #}
{% set target = my_url_object|entity_by_url %}
```

## Behaviour to know

- The filters carry the same characteristics as the service: router-based resolution (aliases,
  language prefixes, non-node types), `NULL` instead of throwing, and no outbound HTTP request.
- Resolution is **not access-filtered** (the `router.no_access_checks` matcher). Before printing
  fields of a resolved entity in a template, ensure the value is one the current user may view —
  e.g. resolve access-checked data upstream, or only expose labels/fields you intend to be public.
