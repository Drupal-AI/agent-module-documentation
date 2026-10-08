# Reading config-page values: the manager service

Service id: `translatable_config_pages.manager`
Class: `Drupal\translatable_config_pages\TranslatableConfigPagesManager`
Interface: `TranslatableConfigPagesManagerInterface` (constructor arg: `@entity_type.manager`).

Each type (bundle) has one values entity; the manager loads it by bundle, optionally in a language.

## Methods

| Method | Returns | Notes |
| --- | --- | --- |
| `loadConfig(string $bundle, ?LanguageInterface $language = NULL)` | `?TranslatableConfigPages` | Loads the single entity for `$bundle`. With `$language`, returns that translation, or `NULL` if the entity has no translation for it. No language → default (source) entity. Returns `NULL` if the bundle has no page. |
| `loadConfigFieldValue(string $bundle, string $field, ?LanguageInterface $language = NULL)` | `mixed` | Convenience wrapper: `loadConfig(...)` then `$entity->get($field)->getValue()` (the raw field-item array). `NULL` if the page or field is missing. |

Internally `getEntityByBundle()` does
`entityTypeManager->getStorage('translatable_config_pages')->loadByProperties(['bundle' => $bundle])`
and returns the first match.

## Examples

```php
$manager = \Drupal::service('translatable_config_pages.manager');

// Default-language values entity for a bundle.
$page = $manager->loadConfig('site_footer');
$phone = $page ? $page->get('field_phone')->value : NULL;

// A specific translation.
$es = \Drupal::languageManager()->getLanguage('es');
$pageEs = $manager->loadConfig('site_footer', $es); // NULL if no 'es' translation

// One field value directly (raw item array, e.g. [0 => ['value' => '...']]).
$value = $manager->loadConfigFieldValue('site_footer', 'field_phone', $es);
```

Twig (via a preprocess / controller that exposes `$page`): render fields through the normal entity
render pipeline so core field formatters apply and output is escaped, e.g.
`{{ page.field_phone.0.value }}` or by building `$view_builder->viewField($page->get('field_phone'))`.

## Notes for integrators

- `loadConfig` returns a full content entity — use `->hasField()`, `->get()`, `->getTranslation()`
  as usual. The entity implements `TranslatableConfigPagesInterface extends ContentEntityInterface`.
- `loadConfigFieldValue` returns the untyped field-item value; the value is unrendered stored data,
  so escape/format it at render time (use a field formatter or Twig auto-escaping) rather than
  printing it raw.
- Swallows `InvalidPluginDefinitionException` / `PluginNotFoundException` and returns `NULL` rather
  than throwing.
