<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Translation — the utility service

Service `auto_translation.utility` → `Drupal\auto_translation\Utility` (constructed with
`config.factory`, `http_client`, `messenger`, `language_manager`, `module_handler`, `cache.default`,
`logger.factory`). This is the whole translation engine; call it instead of reading the ~3.8k-line
source.

## Core method
```php
$u = \Drupal::service('auto_translation.utility');
$translated = $u->translate($text, $source_langcode, $target_langcode);
```
`translate()` reads the active provider from config, checks a 24h cache
(`CACHE_TTL = 86400`), and — for HTML input — splits markup with `HTML_PARSE_PATTERN`
(`/(<[^>]*>)|([^<]+)/`) so only text nodes are translated (`translateHtmlSafely()` /
`translatePlainText()`). `MAX_TEXT_LENGTH = 10000` bounds a single request; longer text is chunked.

## Per-provider calls (all endpoints hard-coded)
- `translateApiBrowserCall()` — free Google `translate.googleapis.com/translate_a/single` (GET).
- `translateApiServerCall()` — Google Cloud `TranslateClient` (needs key).
- `deeplTranslateApiCall()` — `https://{api-free|api}.deepl.com/v2/translate` (POST).
- `libreTranslateApiCall()` — `https://libretranslate.com/translate` (POST).
- Amazon Translate via AWS SDK; Drupal AI via `ai.provider`.

## Entity translation
`formTranslate(&$form, &$form_state, &$entity, &$t_lang, &$d_lang, &$action, &$chunk)` drives the
whole entity flow used by the form-alter hooks and the bulk Actions: it iterates translatable fields
(honoring `auto_translation_excluded_fields`), recurses into Paragraphs
(`translateEntityReferenceField()` and nested-paragraph handling) and entity references, translates
each value, and saves new entity translations. Bulk Action plugins call into this per target language.

## Key handling
`encryptApiKey()` / `decryptApiKey()` wrap stored credentials — the settings form escapes and encrypts
keys before persisting them to `auto_translation.settings`; provider calls decrypt at request time.
(Keys are configuration, so they can also be overridden via `settings.php`/env as usual.)

## Notes for callers
- Translation is **server-side only** — there is no public/AJAX translate route; the only route is the
  admin settings form. Provider URLs are not user-controllable (no SSRF surface).
- Respect `auto translation translate content` when triggering programmatically.
- Debug logging goes to the `auto_translation` logger channel when `enable_debug` is set.
