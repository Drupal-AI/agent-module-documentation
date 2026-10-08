# Conversion API, string_translation override, and locale subscriber

## Static converter — `CyrillicToLatinManager::convertCyrillicToLatin()`

`Drupal\cyrillic_to_latin\CyrillicToLatinManager::convertCyrillicToLatin(string $string): string`
(`src/CyrillicToLatinManager.php:48`). The only reusable public API. Pure, side-effect-free
`str_replace` over a fixed Serbian Cyrillic→Latin character map (including the digraphs
`њ→nj`, `љ→lj`, `џ→dž` and their capitalized forms `Њ→Nj`, `Љ→Lj`, `Џ→Dž`). It is **static** and reads
no config — it always converts, regardless of the `enabled`/`languages` settings.

```php
use Drupal\cyrillic_to_latin\CyrillicToLatinManager;

$latin = CyrillicToLatinManager::convertCyrillicToLatin('Ђорђе'); // 'Đorđe'
```

Because it is a one-way, per-character map: Cyrillic→Latin is unambiguous, but the result is not
round-trippable (Latin `nj`/`lj`/`dž` map back to single Cyrillic letters). It does not skip proper
nouns, URLs, or Latin-script substrings embedded in Cyrillic text — every mapped character is replaced.

## `string_translation` service override

`Drupal\cyrillic_to_latin\CyrillicToLatinServiceProvider` (`src/CyrillicToLatinServiceProvider.php`)
implements `ServiceProviderBase::alter()` and re-classes the core `string_translation` service:

```php
$definition = $container->getDefinition('string_translation');
$definition->setClass('Drupal\cyrillic_to_latin\CyrillicToLatinManager');
```

`CyrillicToLatinManager extends TranslationManager` and overrides `doTranslate($string, $options)`
(`CyrillicToLatinManager.php:15`). After resolving the normal translation, it converts the result to
Latin **only when** `cyrillic_to_latin.settings:enabled` is truthy AND the current language id
(`\Drupal::languageManager()->getCurrentLanguage()->getId()`) is in the filtered `languages` list.
Effect: every `t()` / `$this->t()` / `TranslationManager::translate*()` call — UI strings, menu labels,
field labels, messages — is transliterated at render time for the selected language(s). The override is
container-wide, so a **cache rebuild is required** after enabling the module or changing settings for
it to swap in. Verify at runtime with:

```
ddev drush php:eval "echo get_class(\Drupal::service('string_translation'));"
# => Drupal\cyrillic_to_latin\CyrillicToLatinManager
```

## Field / views display conversion (hooks)

Defined in `cyrillic_to_latin.module`, both gated by `cyrillic_to_latin_is_module_enabled()` (checks
`enabled` + current language in `languages`):

- `cyrillic_to_latin_preprocess_field()` — rewrites the rendered value in `$variables['items']` for
  field types `string`, `string_long` (`#context.value`), `text`, `text_long`, `text_with_summary`
  (`#text`), `list_string` (`#markup`), and the `address` field's country name (both the plain and
  default address formatters).
- `cyrillic_to_latin_preprocess_views_view_field()` — for a views field whose machine name is exactly
  `address`, converts `$variables['output']` and re-wraps it in `TranslatableMarkup`.

## Locale `.po` import subscriber — `cyrillic_to_latin.locale_subscriber`

`Drupal\cyrillic_to_latin\EventSubscriber\LocaleSubscriber` (args `@config.factory`,
`@locale.storage`) subscribes to `locale.save_translation`. In `localeSaveTranslation(LocaleEvent $event)`
it returns early unless BOTH `enabled` and `transliterate_on_po_import` are set; otherwise, for each
saved `lid` and each configured language it loads the translated strings via
`StringStorageInterface::getTranslations()`, runs each through `convertCyrillicToLatin()`, and
**persists the Latin form back** with `$string->setString($new_string)->save()`. Unlike the display
hooks, this permanently rewrites the stored translation at import time (destructive — not reversible
without re-importing the Cyrillic `.po`).
