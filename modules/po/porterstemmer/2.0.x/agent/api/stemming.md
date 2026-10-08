# Porter-Stemmer — stemming hook & API

## Hook implementation

`PorterstemmerHooks::searchPreprocess($text, $langcode = NULL)` (registered with
`#[Hook('search_preprocess')]`; legacy shim `porterstemmer_search_preprocess()` in the `.module`).

Behaviour:
1. If `$langcode` is null, resolves the current interface language.
2. If `$langcode != 'en'` → returns `$text` unchanged (English-only).
3. Lowercases text and replaces `’` with `'`.
4. Splits into words with `preg_split('/(' . PORTERSTEMMER_BOUNDARY . '+)/', ...)` where
   `PORTERSTEMMER_BOUNDARY = "[^a-zA-Z']+"`, keeping delimiters (`PREG_SPLIT_DELIM_CAPTURE`).
5. Stems each word (skipping delimiter tokens), then re-joins.

Because core Search calls `search_preprocess` for both indexed content and parsed queries, indexed
terms and query terms get the same stems and therefore match.

## Stemmer selection

`_porterstemmer_pecl_loaded()` (static-cached) returns TRUE when the PECL `stem` extension is loaded
and `stem_english()` exists. When true the hook uses `stem_english($word)`; otherwise it uses the
bundled PHP implementation `Drupal\porterstemmer\Porter2::stem($word)`. Output is identical.

## Programmatic use

```php
use Drupal\porterstemmer\Porter2;

$stem = Porter2::stem('blogging'); // 'blog'
```

`Porter2::stem()` is a static, self-contained implementation of the Snowball Porter2 English
algorithm (with the standard exception map: skis→ski, sky→sky, news→news, …). It has no Drupal
dependencies and can be called from custom code that needs English stems. There is nothing to
configure.
