<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Texts — developer API

## PHP: global functions (`texts.module`)

```php
getTexts(string $key, array $args = [], array $options = []): string
getTextsPlural(int $count, string $key, string $singular, string $plural, array $args = [], array $options = []): string
```

- `$key` — dot-style translation key, e.g. `login.button`.
- `$args` — placeholder replacements, same rules as `t()` (`@name`, `%name`, `:url`).
- `$options` — `context` (default `'default'`) and `default_translation`.
- **Side effect:** if the key/context does not yet exist, `trans()` creates and saves a new `texts` entity with `default_translation` as its value, then returns it. Requesting a key seeds it.

Both delegate to the `texts.translator` service.

## Service: `texts.translator` (`Drupal\texts\TextsTranslator`)

```php
trans(string $key, array $args = [], array $options = [], mixed $text = NULL): string
formatPlural(int $count, string $key, string $singular = '', string $plural = '', array $args = [], array $options = []): string
translateMultiple(array $translations, &$cache_tags = []): array
```

- `trans()` loads the entity for the current language via `TextsStorage::loadByKey($key, $context)`, falls back to `default_translation`, auto-creates on miss, then runs placeholder substitution through `TextsTranslatableMarkup` / `TextsPluralTranslatableMarkup`.
- `translateMultiple()` takes an array of `['key' => ..., 'context' => ..., 'default' => ..., 'args' => ...]` and returns results keyed `"{context}.{key}"`; it accumulates `texts_context:{context}` cache tags by reference.
- Plurals are stored as `singular` + `plural` joined by `\Drupal\Component\Gettext\PoItem::DELIMITER`; helpers `TextsTranslator::isPlural()`, `getPluralsParts()`, `getPluralMerged()` split/merge them.

## Trait

`Drupal\texts\TextsTranslationTrait` gives a class protected `getTexts()` / `getTextsPlural()` methods, lazily resolving `texts.translator` from the container.

## Twig filters (`Drupal\texts\Twig\TextsExtension`)

```twig
{{ 'login.button'|getTexts }}
{{ 'items.count'|getTextsPlural }}
```

The filtered value is the **key**. Both filters are registered with `is_safe => ['html']`, so their output is emitted without Twig autoescaping.

## Storage

`Drupal\texts\TextsStorage` (`texts.translator` uses it internally):

```php
loadByKey(string $key, string $context = 'default'): TextsInterface|null
loadMultipleByKey(array $keys = []): array   // keyed "{context}.{key}"
```

## GraphQL (`texts_graphql` submodule — requires `graphql:graphql`)

Schema extension `Drupal\texts_graphql\Plugin\GraphQL\SchemaExtension\TextsExtension` (schema `core_composable`) adds to `Query` (and a `textsLoader` object):

```graphql
getText(key: String!, default: String, context: String): String
getTextPlural(key: String!, singular: String, plural: String, context: String): TextsPlural
getTextMultiple(texts: [TextsInput]): [TextsInterface]
textsLoader: TextsLoader
```

Types: `TextsInterface` (interface), `TextsDefault`, `TextsPlural`, input `TextsInput`. Resolvers call `texts.translator` and add `texts_context:{context}` cache tags. Access is governed entirely by the configured GraphQL server's request permission — the resolvers add no per-field access check, and (like the PHP API) they run through the auto-creating `trans()`/`translateMultiple()` path.
