# Hooks

## `hook_tokens_pre_alter(&$text, $data, $options)` — the hook token_or adds

`token_or` invents one alter hook, invoked by its overridden `token` service **before** normal
replacement runs (from `Token::replace()` / `replacePlain()`):

```php
$moduleHandler->alter('tokens_pre', $text, $data, $options);
```

`token_or`'s own implementation (`token_or_tokens_pre_alter()`) delegates to the
`token_or.tokens_pre_alter` service to expand the `[a|b|"c"]` OR syntax. You can implement
`hook_tokens_pre_alter()` in your own module to pre-process the raw token text (before any
token is resolved), e.g. to normalise or rewrite token expressions:

```php
/**
 * Implements hook_tokens_pre_alter().
 */
function mymodule_tokens_pre_alter(&$text, $data, $options) {
  // $text is the not-yet-replaced string (may contain [a|b|"c"] groups).
}
```

Note: there is no `token_or.api.php` in the module; this hook is defined implicitly by the
`alter('tokens_pre', …)` call in `Drupal\token_or\Token`.

## Adding your own tokens for use in OR chains

`token_or` has **no plugin type**. To make a custom token usable inside an OR expression you
register it with the **standard Token API** — nothing token_or-specific is required. Any token
that resolves normally will participate in `[…|…]` fallback automatically.

```php
/**
 * Implements hook_token_info().
 */
function mymodule_token_info() {
  return [
    'tokens' => [
      'node' => [
        'my_fallback' => ['name' => t('My fallback value')],
      ],
    ],
  ];
}

/**
 * Implements hook_tokens().
 */
function mymodule_tokens($type, $tokens, array $data, array $options, \Drupal\Core\Render\BubbleableMetadata $bubbleable_metadata) {
  $replacements = [];
  if ($type === 'node' && isset($tokens['my_fallback'])) {
    // Return '' to let the NEXT candidate in an OR chain win.
    $replacements[$tokens['my_fallback']] = $data['node']->somethingOrEmpty();
  }
  return $replacements;
}
```

Then use it: `[node:my_fallback|node:title|"Untitled"]`. Returning an **empty string** from
your `hook_tokens()` is what lets the next candidate take over.
