# The `[current-page:*]` tokens

## What is registered

`hook_token_info()` adds a token **type** `current-page`. For every content entity type whose
definition sets a `token_type` (node, taxonomy_term, user, media, comment, …), it adds a child token
`current-page:<entity_type_id>` whose `type` is that entity's token type. So the available tokens
depend on the site's entity types.

## How a token resolves (`hook_tokens()`)

For a token under `current-page`:
1. The first `:`-segment is treated as an entity type id; unknown ids are skipped.
2. The entity is fetched from the request: `\Drupal::request()->attributes->get('<entity_type>')`.
   This is the **route-upcast object** — i.e. it only resolves on a route that has that entity as a
   parameter (a node's canonical/edit page for `node`, a term page for `taxonomy_term`, etc.). If the
   current route has no such parameter, the token yields nothing.
3. `[current-page:node]` (no sub-property) → `$entity->label()`.
4. `[current-page:node:<anything>]` → delegated to `\Drupal::token()->generate(<token_type>,
   <subtokens>, [<token_type> => $entity], $options, $bubbleable_metadata)`, so the entity's entire
   normal token tree is available (`:title`, `:field_x`, `:author:name`, …).

Bubbleable cache metadata from the delegated generation is preserved.

## Usage

Use the tokens anywhere Drupal performs token replacement (field/setting defaults, Views global text,
blocks, other modules' token fields):

```
[current-page:node:title]
[current-page:node:field_email]
[current-page:taxonomy_term:name]
[current-page:user:mail]
[current-page:media:field_credit]
```

## Notes / gotchas

- Only **content** entity types with a declared `token_type` are exposed (config entities are not).
- Resolution depends entirely on the route parameter being present and upcast for that entity type on
  the current page.
- Token replacement does not itself add view-access checks — treat `[current-page:*]` like any other
  entity token and only place it where the surrounding output is appropriate for the audience.
- No code API of its own beyond the two hooks; to add behavior, implement your own `hook_tokens()`
  keyed on `current-page` or on the delegated entity token type.
