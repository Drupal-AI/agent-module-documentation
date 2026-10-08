# Hooks (smart_trim.api.php)

Implement in `mymodule.module` (or a `src/Hook/` class).

| Hook | Signature | Use |
|---|---|---|
| `hook_smart_trim_link_modify` | `(EntityInterface $entity, string &$more, \Drupal\Core\Link &$url)` | Alter the "Read more" link before it is rendered — change the text (`$more`, by reference) and/or the `Link` object (`$url`, by reference, e.g. point elsewhere or add query/fragment). Invoked once per rendered item that shows a more link. |

Example:
```php
function mymodule_smart_trim_link_modify($entity, string &$more, \Drupal\Core\Link &$url) {
  $more = t('Continue reading →');
  // Redirect the link somewhere custom.
  $url = \Drupal\Core\Link::createFromRoute($more, 'entity.node.canonical', ['node' => $entity->id()], ['fragment' => 'top']);
}
```

Tokens: `smart_trim.tokens.inc` implements `hook_token_info_alter` and `hook_tokens`,
delegating to the `smart_trim.tokens` service — Smart Trim exposes trimmed-field tokens you
can use in other token contexts (the more-link text/aria-label fields already support tokens).
