# The stemmer service and language event

## `snowball_stemmer.stemmer` service

Class `Drupal\snowball_stemmer\Stemmer` (constructor arg: `@event_dispatcher`). Usage:

```php
$stemmer = \Drupal::service('snowball_stemmer.stemmer');
if ($stemmer->setLanguage('en')) {      // FALSE if language unsupported
  $stem = $stemmer->stem('running');    // "run"
}
```

Methods:
- `setLanguage($langcode): bool` — dispatches `SetLanguageEvent` to normalize the code, then builds a
  `Wamania\Snowball` stemmer via `StemmerFactory`. Returns FALSE (and stems nothing) for unsupported
  languages. **Must be called before `stem()`** or `stem()` throws `LanguageNotSetException`.
- `stem($word): string` — returns the stem; results are cached per language/word. On non-UTF-8 or
  library error it logs and returns the word unchanged.
- `setOverrides(array $overrides, $language = LANGCODE_NOT_SPECIFIED)` — word→value exceptions (this
  is what the processor's `exceptions` config feeds in). A language-specific override wins over the
  not-specified one.
- `hasOverride($word)` — returns the override value or FALSE.

## `SetLanguageEvent` — remapping language codes

Drupal langcodes don't always equal the stemmer's language names, so `setLanguage()` fires
`SetLanguageEvent` (event name constant `SetLanguageEvent::LANGUAGE_CODE` =
`'snowball_stemmer.set_language_code'`) with the requested code; a subscriber may call
`$event->setLanguageCode(...)` to change it before a stemmer is chosen.

Shipped subscribers (both tagged `event_subscriber`):
- `RegionLanguageCodeSubscriber` — strips a region/locale suffix: `pt-br` → `pt`, `en-gb` → `en`.
- `NorwegianLanguageCodeSubscriber` — maps `nb` and `nn` → `no`.

Add your own to support an unusual code:

```php
class MyLangSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [SetLanguageEvent::LANGUAGE_CODE => ['alter']];
  }
  public function alter(SetLanguageEvent $event): void {
    if ($event->getLanguageCode() === 'nb-NO') { $event->setLanguageCode('no'); }
  }
}
```
