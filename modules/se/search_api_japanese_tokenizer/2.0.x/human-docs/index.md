# Search API Japanese Tokenizer — manual setup guide

**Search API Japanese Tokenizer** (`search_api_japanese_tokenizer`) teaches
Drupal how to split Japanese text into real words before it is indexed. Japanese
does not put spaces between words — `これはペンです。` is one unbroken run of
characters — so Drupal's default approach falls back to N-gram segmentation,
which chops text into fixed-length character chunks. That has real drawbacks:
single-character words are effectively impossible to search, unintended matches
creep in, and only exact phrase matching really works. This module solves the
problem with proper natural-language word segmentation, and it does so *without*
requiring a heavyweight external engine like Solr or Elasticsearch.

You choose from four tokenizers, each shipped as its own submodule: two pure-PHP
options that need nothing installed on the server — **TinySegmenter** (a
machine-learning tokenizer, and the only one that can exclude tokens by character
type) and **Igo-php** — and two morphological analyzers that give the best
results but rely on server-side software — **MeCab** and **Sudachi**. The
morphological analyzers (Igo-php, MeCab, Sudachi) can also resolve spelling
variations by reducing words to their base form and can exclude tokens by part of
speech. In the 2.x series all of the actual language processing is delegated to
the separate **JNLP** (Japanese Natural Language Processing) module, which is now
a required dependency.

The base module depends on the **Search API** module; the JNLP module and one of
the tokenizer submodules complete the picture. This is a search-indexing feature
only — it processes indexed text and has no access-control role, so results still
follow the search index's own access rules. There is no standalone settings page;
you configure everything on your search index's *Processors* tab (plus, for MeCab
and Sudachi, a couple of lines in `settings.php`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module plus JNLP and your chosen tokenizer submodule.
2. [Configuration](configuration/index.md) — pick a tokenizer on the index, and
   the core processors you must turn *off* for it to work correctly.

## How to use it

Once the module, JNLP, and a tokenizer submodule are enabled, go to
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), open your index's **Processors** tab, choose
your Japanese tokenizer, disable the conflicting core processors, and re-index.
See [Configuration](configuration/index.md) for the step-by-step.
