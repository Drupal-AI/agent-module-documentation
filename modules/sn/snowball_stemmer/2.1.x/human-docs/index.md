# Snowball stemmer — manual setup guide

**Snowball stemmer** (`snowball_stemmer`) makes your site search smarter about word
forms. "Stemming" reduces words to their root, so a search for **running** also
matches **runs** and **ran**, and vice versa. Drupal core only ships an
English-language stemmer; this module adds proper multilingual stemming — English,
French, German, Italian, Spanish, Portuguese, Russian, Romanian, Dutch, Swedish,
Norwegian, Danish, Catalan, and more — powered by the `wamania/php-stemmer` library.

It plugs into search in two ways. For **Search API** indexes it provides a
processor (labelled **"Snowball stemmer"**) that stems field values as they are
indexed and stems query terms as people search. For Drupal's built-in **core
Search** module it works automatically as soon as the module is enabled — no
configuration needed. Either way, stemming is applied per the content's or query's
language, and languages the library does not support simply skip stemming (the
Search API processor even hides itself when no site language is supported).

The one thing you can tune is an **exceptions** list — a small map of "this word →
stem to exactly this value" overrides, handy for protecting brand names or forcing
a canonical stem. Because Drupal's language codes don't always match the stemmer's
(for example `pt-br` vs `pt`), the module normalises them automatically, and
developers can add their own mapping via an event subscriber. There is a reusable
`snowball_stemmer.stemmer` service for custom code as well.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its required
   library) with Composer and enable it.

Enabling the processor on a Search API index is covered in the *How to use it*
section below.

## Where it lives in the admin menu

There is no dedicated settings page. The Search API processor is configured on the
index itself, under **Configuration → Search and metadata → Search API → (your
index) → Processors**. Core Search needs no configuration at all.

## How to use it

**For a Search API index:**

1. Edit your index and open the **Processors** tab
   (`/admin/config/search/search-api/index/<id>/processors`).
2. Tick **"Snowball stemmer"** to enable it. For the best results, enable it
   *after* the Tokenizer processor so it stems already-tokenised words.
3. (Optional) In the processor's settings, add **exceptions** — a list of
   `word: stem` overrides, for example `acme: acme` to stop a brand name being
   stemmed, or `drupaling: drupal` to force a stem.
4. **Save**, then **re-index** your content so existing items get stemmed.

**For core Search:** nothing to do. Once the module is enabled, core search
indexing and querying are stemmed for the current language automatically.

Developers can also call the service directly:

```php
$stemmer = \Drupal::service('snowball_stemmer.stemmer');
if ($stemmer->setLanguage('en')) {   // FALSE if the language is unsupported
  $stem = $stemmer->stem('running'); // "run"
}
```

See the [`agent/`](../agent/start.md) docs for the full service API and the
language-remapping event.
