# Hooks: extend the simplification dictionary

The dictionary maps a **list cache tag** (key) to a **regex** (value) matching the concrete
tags it subsumes. It is collected once in the subscriber constructor via
`$module_handler->invokeAll('cache_tags_simplify_dictionary')` then passed through
`$module_handler->alter('cache_tags_simplify_dictionary', $dictionary)`.

Built-in entries (module's own `hook_cache_tags_simplify_dictionary`):
`config:block_list => /^config\:block\./`, `menu_link_content_list => /^menu_link_content\:/`,
`media_list => /^media\:/`, `node_list => /^node\:/`, `file_list => /^file\:/`,
`taxonomy_term_list => /^taxonomy_term\:/`, `user_list => /^user\:/`,
`profile_list => /^profile\:/`, `group_list => /^group\:/`.

## `hook_cache_tags_simplify_dictionary(): array`

Return extra `list_tag => regex` entries. Applied the same way as the built-ins: when the list
tag is present on a response, its regex-matching concrete tags are collapsed.

```php
function mymodule_cache_tags_simplify_dictionary(): array {
  return [
    // Collapse commerce_order:N into commerce_order_list.
    'commerce_order_list' => '/^commerce_order\:/',
  ];
}
```

## `hook_cache_tags_simplify_dictionary_alter(array &$dictionary): void`

Mutate the merged dictionary — e.g. remove a mapping so those concrete tags stay granular
(finer invalidation, more tags).

```php
function mymodule_cache_tags_simplify_dictionary_alter(array &$dictionary): void {
  // Keep user:N tags intact instead of collapsing to user_list.
  unset($dictionary['user_list']);
}
```

Both hooks are documented in `cache_tags_simplify.api.php`. Keys must be a valid list cache
tag; values must be a PCRE pattern (as passed to `preg_match`).
