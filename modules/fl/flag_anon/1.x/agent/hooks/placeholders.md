# Hook: alter the anonymous message placeholders

`flag_anon.api.php` documents one hook.

## `hook_flag_anon_message_placeholders_alter(array &$placeholders, FlagInterface $flag, EntityInterface $entity)`

Invoked (via `$moduleHandler->alter('flag_anon_message_placeholders', ...)`) inside
`FlagAnonLinkBuilder::buildAnonMessage()` just before the message string is rendered. The
`$placeholders` array already contains `@login` and `@register` (rendered link HTML). Add your
own keys to make new placeholders usable in a flag's configured **Message** field.

```php
/**
 * Implements hook_flag_anon_message_placeholders_alter().
 */
function mymodule_flag_anon_message_placeholders_alter(array &$placeholders, \Drupal\flag\FlagInterface $flag, \Drupal\Core\Entity\EntityInterface $entity) {
  // Now usable as @help in the flag's Anonymous "Message" field.
  $placeholders['@help'] = \Drupal\Core\Link::createFromRoute(
    t('Why register?'),
    'user.register'
  )->toString();
}
```

Keys are used as `FormattableMarkup` arguments, so they must be safe/rendered strings (e.g.
`Link::toString()`), and placeholders in the message must start with `@`. That is the module's
only hook — there are no events or plugin types.
