# Extending the Twig context (alter hooks)

Each render path builds a `#context` for its Twig `inline_template` and invokes one alter hook so
other modules can add variables. The base context is always the host entity (keyed by its
entity-type id, e.g. `node`) plus `current_user`; the Views path builds context from Views
replacement tokens instead.

| Hook | Fired by | Signature |
|---|---|---|
| `hook_inline_formatter_field_formatter_context_alter` | field formatter (`InlineFormatterFieldFormatter::viewElements`) | `(array &$context, \Drupal\Core\Entity\EntityInterface $entity)` |
| `hook_inline_formatter_display_context_alter` | display submodule (`inline_formatter_display_entity_view_alter`) | `(array &$context, \Drupal\Core\Entity\EntityInterface $entity)` |
| `hook_inline_formatter_views_field_context_alter` | views submodule (`InlineFormatterViewsField::render`) | `(array &$context)` — no entity argument |

## Example (from `inline_formatter_field.api.php`)

```php
/**
 * Implements hook_inline_formatter_field_formatter_context_alter().
 */
function my_module_inline_formatter_field_formatter_context_alter(array &$context, \Drupal\Core\Entity\EntityInterface $entity) {
  $context['label'] = $entity->label();
  $context['language'] = \Drupal::languageManager()->getCurrentLanguage()->getId();
}
```

After this, templates on that field may use `{{ label }}` and `{{ language }}`. The display and Views
variants work the same way (implement the matching hook name). Whatever you add becomes a Twig
variable that authors can reference; keys must be valid Twig identifiers.

There are **no** integrator-facing services, events or plugin managers — extension is purely via
these three alter hooks (and, for the Ace editor UI, the standard `editor`/`filter` config).
