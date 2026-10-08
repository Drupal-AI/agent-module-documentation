<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Japanese Tokenizer — agent index

A **Search API processor that tokenizes Japanese text** via pluggable NLP engines (`search_api_igo_php`/
`_mecab`/`_sudachi`/`_tinysegmenter`) — proper Japanese search indexing (word segmentation). Depends on
`search_api`. Version **2.0.0-beta1**. Core `^10||^11`.

Search — processes indexed text (index/query still governs access; no access role). Engines differ (some need
a system binary like MeCab).
