<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token integration

Implemented in `src/Hook/Token.php` (class `Token`, Drupal 11 `#[Hook]` attributes). It autowires
three services: `token` (`TokenInterface`), `entity_fallback_value.plugin_manager`, and
`entity_fallback_value.manager`. The **Token module must be enabled** for this to resolve (the
`token` service is autowired into the hook class).

Tokens are named `[<entity>:efv_<key>]`, e.g. `[node:efv_title]`, `[node:efv_description]`.

## `hook_token_info()` — `tokenInfo()`

Iterates every EntityFallbackValue plugin definition; for each plugin key returned by
`getEntityFallbackDefinitions()` and each `applies_on` target, it registers a token type per
`entity_type_id` and a token `efv_<field>` (type `entity`, name = plugin label) under it. So the
available `efv_*` tokens are exactly the keys your plugins declare — no plugins means no tokens.

## `hook_tokens()` — `tokenReplacement()`

For each requested token part starting with `efv_`, if the corresponding `$data[$type]` is an
`AccessibleInterface`, it calls `replaceWithFallbackValues()`:

- `$fallbackValues = $this->manager->getEntityFallbackValues($entity);` (plugin-defaults path).
- `$value = $fallbackValues[$field] ?? NULL;`
- If `$value` is a **string**, it is set as the replacement (`$replacements[$tokenValue] = $value`).
  Core's `Token::replace()` wraps non-`MarkupInterface` replacements in `HtmlEscapedText`, so the
  value is escaped when rendered into markup.
- It also supports **chained** sub-tokens: `token->findWithPrefix()` + `token->generate('entity',
  …, ['entity' => $fallbackValues[$field]])` — so when the resolved value is an entity (a reference
  hop), `[node:efv_ref:title]`-style chaining expands core entity tokens on the resolved entity.

## Example

```
[node:efv_title]
[node:efv_description]
```

Values come from the plugin whose `applies()` matches the entity; resolution follows the field-path
rules in [service.md](service.md).
