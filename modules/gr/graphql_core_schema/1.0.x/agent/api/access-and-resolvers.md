# Access & resolution model

This is the key question for a public GraphQL endpoint: **can an anonymous / low-privilege client read
fields or unpublished entities they shouldn't?** For the generated schema, access **is enforced** by the
default resolver and the entity-query producer. Summary of the mechanics (all in
`src/CoreComposableResolver.php` unless noted):

## Field / entity resolution (`resolveFieldDefault`)

- After resolving a value and translating it, `filterAccessible()` runs:
  - If the value is an `AccessibleInterface` (entity, field item list) it calls `->access('view', NULL,
    TRUE)` and returns the value **only if `isAllowed()`**, else `NULL`. The access result is added as a
    cacheable dependency.
  - For arrays it filters each `AccessibleInterface` item the same way (unallowed items dropped).
- Value fields (`resolveFieldValue`) call `$field->access('view')` before returning a field's scalar
  values; a non-allowed field returns nothing.
- Referenced entities are returned via `referencedEntities()` and then themselves pass through the same
  access filtering as they are resolved.

Consequence: fields/entities that the current session cannot `view` are omitted (resolve to null / are
filtered out), for anonymous and authenticated clients alike.

## Entity queries (`entity_query` / `entityById`)

`EntityQueryBase::getBaseQuery()` builds `$storage->getQuery()->accessCheck(TRUE)`, so listing/query
fields respect entity access (including node grants and the published/unpublished distinction as
enforced by core access). `MAX_LIMIT` is 1000; the `user` entity type explicitly excludes uid 0.

## Important caveat (documented by the module)

Per `docs/basics/security.md`: many entity types return a **neutral** access result for `view`, and the
default resolver only returns a value when the result is **allowed** — so those are NOT resolved unless
the site adds an access hook. In other words the default is fail-closed. Two things a site must still do:

1. **Add entity access hooks** (`hook_ENTITY_TYPE_access`) to *grant* view where appropriate (e.g. the
   `Menu` config entity), otherwise those reads return null even for legitimate users.
2. **Custom field resolvers** written in schema extensions **bypass** `resolveFieldDefault` and its
   access filtering — the author of such a resolver must perform access checks themselves. This is the
   main place a misconfiguration could over-expose data; it is developer-controlled, not a default.

## `call_method` data producer

`CallMethod` invokes `$object->$method()` where `method` is always supplied via `fromValue(...)`
(hard-coded in the resolver registration, e.g. `isEmpty`, `getEntity`), never from a client argument —
so clients cannot invoke arbitrary methods.

## Net assessment

Out of the box the generated schema does not leak fields or unpublished entities to low-privilege
clients: entity access, field access, and query access checks are all applied and fail-closed. Risk of
over-exposure comes only from (a) a developer writing a custom field resolver without access checks, or
(b) a site adding overly broad entity access hooks — both are opt-in, not module defaults.
