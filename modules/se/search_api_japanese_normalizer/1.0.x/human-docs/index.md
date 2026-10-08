# Search API Japanese Normalizer — manual setup guide

**Search API Japanese Normalizer** (`search_api_japanese_normalizer`) is a
Search API *processor* that cleans up the many ways the same Japanese text can be
written, so searches match the way people expect. Japanese content is full of
subtle variations — full-width versus half-width letters and numbers, half-width
versus full-width katakana, stray long-vowel marks, tildes, and inconsistent
spaces — and any one of them can stop a search from finding a page that really
does contain the word. This processor standardizes all of that during indexing
and querying.

Concretely, it converts full-width alphanumerics to half-width, promotes
half-width katakana to full-width, normalizes hyphen-like and long-vowel-like
characters (collapsing runs such as スーーパーーー down to スーパー), removes tilde-like
characters, harmonizes full- and half-width symbols and spaces, and strips
needless spaces between Japanese characters. The rules follow the well-known
NEologd normalization conventions. For example, `ﾄﾞﾙｰﾊﾟﾙ` becomes `ドルーパル` and
`アルゴリズム　Ｃ` becomes `アルゴリズムC`.

The module depends only on the **Search API** module. There is no separate
settings page of its own — once enabled, a **Japanese Normalizer** processor
appears on your index's *Processors* tab, and enabling it there is all it takes.
It has no access-control role: results always follow the search index's own
access rules. If you also want proper word segmentation for Japanese, the
companion **Search API Japanese Tokenizer** module pairs well with it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and turn the processor on for your index.

## How to use it

After enabling the module, edit your search index and open its **Processors**
tab (**Configuration → Search and metadata → Search API → your index →
Processors**). Tick **Japanese Normalizer**, save, and re-index your content.
From then on both indexed text and incoming search queries are normalized the
same way, so variant spellings of the same Japanese word line up and match.
