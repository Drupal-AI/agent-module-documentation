# Provide your own tokens

Declaring tokens uses **core** hooks — Token just gives them a UI and ships missing ones.
Implement both hooks in your `mymodule.tokens.inc` (or a `Hook` class).

**1. Announce the tokens (`hook_token_info`):**
```php
function mymodule_token_info() {
  return [
    'types' => [
      'mytype' => ['name' => t('My type'), 'description' => t('My token group.')],
    ],
    'tokens' => [
      'mytype' => [
        'greeting' => ['name' => t('Greeting'), 'description' => t('A greeting.')],
      ],
      // You may also add tokens to an existing type, e.g. 'node' => [...].
    ],
  ];
}
```

**2. Produce the values (`hook_tokens`):**
```php
function mymodule_tokens($type, $tokens, array $data, array $options, BubbleableMetadata $bubbleable_metadata) {
  $replacements = [];
  if ($type === 'mytype') {
    foreach ($tokens as $name => $original) {
      if ($name === 'greeting') {
        $replacements[$original] = 'Hello';
      }
    }
  }
  return $replacements;
}
```

- Alter others' tokens with `hook_token_info_alter()` / `hook_tokens_alter()`.
- After adding tokens, clear caches so they appear: `drush cache:clear token` (see
  [../drush/cache-clear.md](../drush/cache-clear.md)) or `drush cr`.
- To attach a token type to an entity type, register it via the entity mapper
  (see [../api/token-service.md](../api/token-service.md)).
