# Token services & helper functions

## Services

- `token` (core, `Drupal\Core\Utility\Token`) — replace/scan tokens.
  `\Drupal::token()->replace($text, $data, $options, $bubbleable_metadata)`.
- `token.tree_builder` (`Drupal\token\TreeBuilderInterface`) — build the token tree data
  used by the UI. `->buildTree($token_type, $options)`.
- `token.entity_mapper` (`Drupal\token\TokenEntityMapperInterface`) — map between entity
  type ids and token type names: `->getTokenTypeForEntityType('taxonomy_term')` →
  `'term'`; `->getEntityTypeForTokenType('term')` → `'taxonomy_term'`.

The added `Drupal\token\TokenInterface` (service id `token` is core; this interface is
implemented for extra metadata helpers) exposes:
- `getTypeInfo($token_type)` / `getTokenInfo($token_type, $token)` — metadata from
  `hook_token_info()`.
- `getGlobalTokenTypes()` — types usable without context.
- `getInvalidTokens($type, $tokens)` / `getInvalidTokensByContext($value, $valid_types)`
  — validate user-supplied tokens; returns the invalid raw tokens.

## Handy procedural helpers (token.module)

- `token_render_array(array $array, array $options = [])` — render an array as token output.
- `token_render_array_value($value, array $options = [])`.
- `token_clean_token_name($name)` — sanitize a token name.
- `token_element_validate($element, $form_state)` — `#element_validate` callback to reject
  invalid tokens in a textfield.
- `token_menu_link_load_all_parents()`, `token_taxonomy_term_load_all_parents()`,
  `token_book_load_all_parents()` — hierarchy helpers powering menu/term/book tokens.
