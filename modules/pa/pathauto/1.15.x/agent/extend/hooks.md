# Alter hooks (pathauto.api.php)

Implement in `mymodule.module` or a `src/Hook/` class.

| Hook | Signature | Use |
|---|---|---|
| `hook_pathauto_alias_alter` | `(&$alias, array &$context)` | Change the final alias string before it's saved; `$context` has `module`, `op`, `source`, `data`, `type`, `language`, `pattern`. |
| `hook_pathauto_is_alias_reserved` | `($alias, $source, $langcode): bool` | Return TRUE to force pathauto to add a uniquifying suffix (reserve a path). |
| `hook_pathauto_pattern_alter` | `(PathautoPatternInterface $pattern, array $context)` | Swap/modify which pattern applies for a given entity/context. |
| `hook_path_alias_types_alter` | `(array &$definitions)` | Add/remove AliasType plugin definitions (see [../plugins/alias-type.md](../plugins/alias-type.md)). |
| `hook_pathauto_punctuation_chars_alter` | `(array &$punctuation)` | Change how punctuation characters are handled during cleaning. |

Example — reserve paths owned by your module:
```php
function mymodule_pathauto_is_alias_reserved($alias, $source, $langcode) {
  return in_array($alias, ['dashboard', 'api'], TRUE);
}
```

Also relevant: providing tokens for your pattern uses core `hook_token_info` /
`hook_tokens` (see the token module docs).
