<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect JSON:API resource

Class `Drupal\decoupled_kit_redirect\Resource\Redirect` (extends `jsonapi_resources`
`EntityResourceBase`, implements `ContainerInjectionInterface`). Route `decoupled_kit.redirect`
(`decoupled_kit_redirect.routing.yml`):

```yaml
decoupled_kit.redirect:
  path: '%jsonapi%/decoupled_kit/redirect'
  defaults:
    _jsonapi_resource: Drupal\decoupled_kit_redirect\Resource\Redirect
    _jsonapi_resource_types: ['redirect--redirect']
  requirements:
    _access: 'TRUE'
```

Constructor injects `decoupled_kit` and `path_alias.manager`.

## Request contract

- `current_path` (required). Note it calls `decoupledKit->checkPath($request, FALSE)` — the second
  arg `FALSE` skips canonicalization so the **raw** path is kept for alias resolution.
- Missing/empty `current_path` → `NotFoundHttpException`.

## Processing (`process()`)

1. `inner_path = aliasManager->getPathByAlias($path)` — turn an aliased front-end path into its
   internal path.
2. Load `redirect` entities via `loadByProperties(['redirect_source.path' => ltrim($inner_path, '/')])`.
3. **No match:** build an empty `JsonApiDocumentTopLevel` (`ResourceObjectData([])`,
   `NullIncludedData`, empty `LinkCollection`) and return it.
4. **Match:** take the first entity, `createIndividualDataFromEntity($entity)`; read
   `redirect_redirect` field value, strip the scheme prefix (`preg_replace('/^[^:]+:/', '/', $uri)`)
   to a system path, resolve `aliasManager->getAliasByPath()` to an alias, and return the JSON:API
   document with `meta = ['alias' => $alias]`.

Cacheability: adds context `url.query_args:current_page`.

## Response shape

- Individual `redirect--redirect` JSON:API document (source, destination, status code, etc.) plus a
  top-level `meta.alias` giving the destination's path alias. The resource returns **data about** the
  redirect; it does not itself send an HTTP 3xx — the decoupled front end performs the redirect.

## Operating it

```bash
curl 'https://SITE/jsonapi/decoupled_kit/redirect?current_path=/old-url'
```

Empty `data` means no redirect for that path; a populated document plus `meta.alias` means the front
end should redirect to that target.
