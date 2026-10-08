# gText translation API & mechanism

## Twig `gtext()` helper

`src/Twig/TwigTranslateExtension.php` (service `gtext.translate_extension`, args `['@gtext']`)
exposes a translation helper in templates, backed by the `gtext` service. It lets templates emit
context-aware translatable strings; `t`/`plural` are whitelisted for the Twig sandbox by the
install hook so they work in sandboxed themes.

## The `gtext` service (TextTranslationFactory)

Service id `gtext` → `Drupal\gtext\TextTranslationFactory`. It uses PHP magic methods so that
`\Drupal::service('gtext')->SomeContext` / `->SomeContext($string, $args)` returns/translates a
string within the named locale **context** (each context is lazily wrapped in a
`TextTranslationWrapper`). The module's `gtext($context = NULL)` function is a thin accessor:
`gtext()` returns the service, `gtext('ctx')` returns that context's wrapper.

## Google translation + free fallback

`src/GoogleTranslate.php` — `GoogleTranslate::translate($source, $target, $text)`:

1. Reads `gtext.settings:google_api_key`. **If set**, it calls the official
   `Google\Cloud\Translate\V2\TranslateClient` to translate `$text` into `$target`.
2. **If no key** (or the official call yields nothing), it falls back to an unofficial
   `translate.google.com/translate_a/single` request (cURL). This fallback **throws** when
   `$text` is ≥ 1000 characters (message links to the settings page to add a key).
3. Errors are surfaced as warning messages on the `gtext` messenger channel.

So the presence/absence of `google_api_key` is exactly what switches between the paid client and
the free endpoint.

## Endpoint used by the inline buttons

`gtext.translate.google` → `/api/gtext/google` (permission
`access gtext translate+access gtext translate strings`) is the AJAX endpoint the inline
"translate" buttons call. `gtext_form_alter()` attaches the `gtext/entity-form-translate` library
and `data-gtext-*` attributes (source/target language, endpoint URL) to config-translation and
entity-translation forms for users with `access gtext translate`.

## `hook_gtext_contexts` extension point

`gtext.module` implements `hook_gtext_contexts()` (returning `['gtext' => 'gText'] + contexts`
harvested from `locales_source`). Other modules may implement `hook_gtext_contexts()` to add
their own translation contexts to the UI's grouping.

## Notes for an agent

- This is **string/locale translation**, not typography — "Google" here means Google **Translate**.
- No Drush commands; drive it via the config value and the `/admin/config/texts` UI, or the
  `gtext` service / `gtext()` Twig helper in code.
- Machine translation is a convenience; the stored translations live in core locale storage and
  saving them refreshes JS/locale caches and fires `locale.save_translation`.
