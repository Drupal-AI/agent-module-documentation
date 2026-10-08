# Wrapper / renderer variants

A repository's `wrappers` and `renderers` are declared as
`Drupal\typed_entity\ClassWithVariants($fallback, [$variant, ...])`. When wrapping or rendering,
the repository asks the `ClassWithVariants` to **negotiate** which class to use: it walks the
variants in order, calls each one's static `applies(TypedEntityContext $context): bool`, and
uses the first that returns TRUE; otherwise it uses the fallback.

```php
wrappers: new ClassWithVariants(Article::class, [BakingArticle::class]),
// -> BakingArticle if BakingArticle::applies($context) is TRUE, else Article.
```

Rules enforced by `ClassWithVariants`:
- The **fallback** must exist and (when a base class is required) be an instance of it — wrapper
  fallbacks must extend `WrappedEntityBase`, renderer fallbacks `TypedEntityRendererBase`.
- A **variant** is only considered if it exists and implements `VariantInterface` (which requires
  the static `applies()` method) and extends the required base class.

## Writing `applies()`

`TypedEntityContext` is an `ArrayAccess` bag; for wrappers it contains the `entity` key, and for
renderers it carries the render context (including `view_mode`). Simple example:

```php
public static function applies(TypedEntityContext $context): bool {
  $entity = $context['entity'] ?? NULL;
  return $entity instanceof NodeInterface
    && !$entity->get('field_tags')->isEmpty();
}
```

## Reusable field conditions

Instead of hand-writing `applies()`, use the configurable conditions in
`Drupal\typed_entity\WrappedEntityVariants`:

- **`FieldValueVariantCondition($field_name, $value, TypedEntityContext $context, bool $is_negated = FALSE)`**
  — `evaluate()` is TRUE when any value of `$field_name` (its main property) equals `$value`.
  Pass `$value = NULL` to defer to `EmptyFieldVariantCondition`. Throws
  `InvalidValueException` if the entity is not fieldable or lacks the field.
- **`EmptyFieldVariantCondition($field_name, TypedEntityContext $context, bool $is_negated = FALSE)`**
  — TRUE when the field is empty (negate for "is populated").
- Both extend `VariantConditionBase` and expose `isNegated()`, `evaluate()`, `summary()`,
  `validateContext()`. Wire one inside your variant's `applies()`:

```php
public static function applies(TypedEntityContext $context): bool {
  return (new FieldValueVariantCondition('field_tags', 'Baking', $context))->evaluate();
}
```

Negation is done with the `$is_negated` constructor flag (it inverts `evaluate()`).
