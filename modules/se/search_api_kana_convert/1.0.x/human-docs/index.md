# Search API Kana Convert — manual setup guide

**Search API Kana Convert** (`search_api_kana_convert`) is a Search API
*processor* that smooths over the many ways Japanese text can be written so that
searches match regardless of character type. It is essentially a thin wrapper
around PHP's built-in `mb_convert_kana` function, which converts between
zenkaku (full-width) and hankaku (half-width) forms, and between hiragana and
katakana.

Why this matters: Drupal core's Search module and Search API's standard features
cannot, for example, find text entered in full-width form when you search using
half-width characters. If a page contains `ＡＢＣ　１２３` typed in full-width,
searching for `ABC 123` in half-width simply misses it. This processor normalizes
those differences — both when content is indexed and when a query runs — so the
same words match no matter which width or kana form was used. It also converts the
full-width space `　` to a normal half-width space so tokenizers can split words
properly.

The module depends only on the **Search API** module and works on Drupal 9, 10,
and 11. It has no settings page of its own — once enabled, a Kana Convert
processor appears on your index's *Processors* tab, and turning it on there is all
that's required. It has no access-control role; results always follow the search
index's own access rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and turn the processor on for your index.

## How to use it

After enabling the module, edit your search index and open its **Processors** tab
(**Configuration → Search and metadata → Search API → your index → Processors**).
Enable the Kana Convert processor, save, and re-index your content. From then on
full-width/half-width and hiragana/katakana differences are ironed out on both
sides, so variant Japanese spellings of the same word line up and match.
