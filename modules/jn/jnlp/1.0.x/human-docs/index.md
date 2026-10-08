# Japanese NLP (jnlp) — manual setup guide

**Japanese NLP** (`jnlp`) provides Japanese **morphological analysis and
tokenization** (word segmentation) as reusable Drupal services. Japanese text has
no spaces between words, so tasks like search indexing, keyword extraction, and
reading generation all need natural‑language processing to split a sentence into
meaningful words. JNLP is the foundation library that other modules build on to do
that — for example, to power accurate Japanese search.

It offers a single, stable service API — `process($text)` returns an immutable
result object with tokens and morphemes (surface form, part of speech, base form,
normalized form) — backed by **four interchangeable analyzers**, each shipped as
its own submodule:

- **JNLP MeCab** (`jnlp_mecab`) — a fast, widely used analyzer that relies on an
  external MeCab binary and dictionary on the server.
- **JNLP Sudachi** (`jnlp_sudachi`) — a modern analyzer with word normalization and
  selectable split modes (A/B/C); runs on Java.
- **JNLP Igo‑php** (`jnlp_igo_php`) — a pure‑PHP analyzer needing no server
  binaries (uses the `logue/igo-php` Composer package with a bundled dictionary).
- **JNLP TinySegmenter** (`jnlp_tinysegmenter`) — a compact pure‑PHP tokenizer
  using machine learning (uses the `u7aro/tinysegmenter-php` Composer package).

You enable the base module plus the submodule(s) for the analyzer you want, and the
module includes **admin test forms** so you can verify a setup and inspect
tokenization results without writing any code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the analyzer submodule(s) you need.
2. [Configuration](configuration/index.md) — set analyzer paths in `settings.php`,
   choose Sudachi's split mode, and use the test forms.

## Where it lives in the admin menu

The test forms live at **Configuration → Region and language → Japanese Natural
Language Processing** (`/admin/config/regional/jnlp`), with Sudachi's split mode at
`/admin/config/regional/jnlp/sudachi`. Access is gated by the **Administer Japanese
Natural Language Processing** permission.
