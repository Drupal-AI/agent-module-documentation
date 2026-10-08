# How token_or_webform works

Webform replaces tokens through its own **`webform.token_manager`** service
(`Drupal\webform\WebformTokenManager`), not the core `token` service that token_or overrides.
So without this submodule, `[a|b|"literal"]` OR syntax is bypassed inside Webform text.

## The decorator

`token_or_webform.services.yml` decorates the Webform token manager:

```yaml
services:
  token_or_webform.token_manager:
    class: Drupal\token_or_webform\TokenOrWebformTokenManager
    decorates: webform.token_manager
    decoration_priority: 50
    public: false
    arguments: ['@current_user', '@language_manager', '@config.factory', '@module_handler', '@token']
```

`TokenOrWebformTokenManager extends WebformTokenManager` and overrides only `replace()`:

```php
public function replace($text, ?EntityInterface $entity = NULL, array $data = [], array $options = [], ?BubbleableMetadata $bubbleable_metadata = NULL) {
  if (!$text) {
    return $text;
  }
  // Arrays and non-piped strings go straight to the parent (normal Webform behaviour).
  if (is_array($text) || strpos($text, '|') === FALSE) {
    return parent::replace($text, $entity, $data, $options, $bubbleable_metadata);
  }
  $options['clear'] = 1;               // remove unresolved OR groups
  // ... anonymous current-user handling ...
  return parent::replace($text, $entity, $data, $options, $bubbleable_metadata);
}
```

Key behaviours:

- **Only piped text is special-cased.** Text without `|`, and array input, pass through to the
  parent unchanged.
- **`clear` is forced on** for piped text, so an OR group that resolves to nothing is removed
  rather than left as literal `[a|b]`.
- Because the parent eventually calls through token_or's overridden `token` service, the
  actual `|` / `"literal"` parsing is done by token_or (`token_or.tokens_pre_alter`).

## Anonymous `[current-user:*]` handling

For anonymous users, `[current-user:display-name]` would render "Anonymous". So when the text
is piped **and** the user is anonymous **and** contains `[current-user:`:

```php
if ($this->currentUser->isAnonymous() && strpos($text, '[current-user:') !== FALSE) {
  // Drop the leading current-user: candidate of each OR group.
  $text = preg_replace('/\[current-user:[^|]+\|/', '[', $text);
  // If that leaves a lone quoted-string token, unwrap it to the literal.
  $text = preg_replace('/\["([^]"]+)"\]/', '$1', $text);
}
```

Effect: `[current-user:display-name|"foobar"]` becomes the literal `foobar` for anonymous
users (the current-user candidate is stripped and the remaining quoted literal is used),
instead of falling back to "Anonymous".

## Notes

- Adds no configuration, permissions, Drush commands, or plugin type — it is purely a service
  decorator.
- Requires `webform:webform` and `token_or:token_or`.
