# How the token is resolved at runtime

All logic is in `TokenArgument::getArgument()` (returned to Views as the default argument).
It reads the five options and resolves `argument` (the token string) in this order:

1. **Scan tokens.** `tokenScan()` regex-groups tokens by type, e.g.
   `[node:title]` → `$results['node']['title']`.

2. **current-user tokens.** If a `current-user` token is present:
   - with `process` on, field tokens are replaced with the loaded user's **raw field values**
     via `processToken()`;
   - any remaining `current-user` token is replaced by `\Drupal::token()->replace(..., ['clear' => TRUE])`.

3. **Route entity tokens.** The current path's route parameters are read
   (`Url::fromUri('internal:'.$path)->getRouteParameters()`), the first parameter's entity type
   is mapped to its token type with `token.entity_mapper`
   (`getTokenTypeForEntityType()`), and if that token type appears in the string **and** the
   route provides the entity, it is replaced (raw values first when `process` is on, then a
   normal token replace). So on `node/5` a `[node:*]` token uses node 5; on `taxonomy/term/3`
   a `[term:*]` token uses term 3, etc.

4. **Global tokens.** If neither current-user nor a route-entity token was found, the string is
   passed through a plain `token->replace()` (handles globals like `[current-date:*]`).

5. **Cleanup.**
   - Any still-unresolved `[type:name]` pattern (regex `/\[[a-zA-Z0-9:_-]+\]/`) blanks the whole
     argument to `''`.
   - HTML entities are decoded (`PlainTextOutput::renderFromHtml`).
   - If `debug` is on, the value is shown as a status message.
   - If the value is empty: return `''` unless `all_option` is on, in which case return `all`.
   - Leading/trailing `+` or `,` are trimmed (`cleanArgumentValue()`).

## Raw values (`processToken()`)

For each field token of the entity, `$entity->get($field_name)->getValue()` is read and the
**first property of each delta** (`array_values($field_value)[0]`) is taken — for an
entity-reference field that is the `target_id`, for a plain field the main value. Deltas are
imploded with `and_or` (`+` or `,`). This is what "Get fields raw values" produces: IDs instead
of rendered token output, suitable for numeric/ID contextual filters and multi-value matching.

## Caching

`getCacheMaxAge()` returns `Cache::PERMANENT` and `getCacheContexts()` returns `[]` (a documented
`@todo`). The resolved argument is therefore not varied by user/route cache contexts — prefer it
for values that are stable within the rendered view's cache, and be aware of this when the token
depends on the current user.
