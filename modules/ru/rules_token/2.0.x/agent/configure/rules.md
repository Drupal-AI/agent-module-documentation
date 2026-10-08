# Rules Token — the Rules action & conditions

All three plugins live in `src/Plugin/`. They are configured inside a Rules reaction rule /
component (config entity `rules.reaction.*` / `rules.component.*`), not via a settings page.

## Common: token resolution
```php
$options = ['clear' => TRUE];               // unresolved token → '' not '[node:x]'
if ($token && $token_entity) {
  $entity_name = mb_substr($token, 1, strpos($token, ':') - 1);  // '[node:title]' → 'node'
  $value = \Drupal::token()->replace($token, [$entity_name => $token_entity], $options);
}
elseif ($token) {
  $value = \Drupal::token()->replace($token, [], $options);      // global token
}
```
- **Entity of Token**: for context-bound tokens select the entity in data-selection mode; for global tokens (`[date:...]`, `[site:...]`, `[random:...]`) leave it empty.

## Action — Get token value
- Id `rules_token_get_token_value` (`src/Plugin/RulesAction/GetTokenValue.php`), category "Data".
- Contexts: `token` (string, input-only), `token_entity` (any, optional).
- Provides: `token_value` (any) — usable by later Rules steps via the data selector.

## Condition — Compare Data with Token
- Id `rules_token_compare_data_with_token` (`src/Plugin/Condition/CompareDataWithToken.php`).
- Contexts: `data` (any), `operation` (string, default `==`), `token` (string, input-only), `token_entity` (entity, optional).
- Evaluates `data <op> resolved(token)`.

## Condition — Compare Token with Token
- Id `rules_token_compare_token_with_token` (`src/Plugin/Condition/CompareTokenWithToken.php`).
- Contexts: `token_1`, `token_entity_1`, `operation`, `token_2`, `token_entity_2`.
- Evaluates `resolved(token_1) <op> resolved(token_2)`.

## Operators (case-insensitive)
`==` (default; NULL-vs-FALSE aware), `<`, `>`, `contains` (substring for strings, `in_array` for arrays), `in` (membership in an array/list value).

## Form helper
`rules_token_form_rules_expression_edit_alter` adds a `token_tree_link` (`#token_types => 'all'`, `#show_restricted => TRUE`) next to each token field on the Rules expression edit form, so editors can browse tokens.
