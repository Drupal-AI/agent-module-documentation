<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Japanese Tokenizer provides a tokenizer using natural language processing for Japanese.

---

Search API Japanese Tokenizer provides a **Search API processor that tokenizes Japanese text** — Japanese
has no word spaces, so proper search indexing needs word segmentation, which this does via pluggable NLP engine
submodules (`search_api_igo_php`, `search_api_mecab`, `search_api_sudachi`, `search_api_tinysegmenter`). It
depends on the Search API module, in the Search package.

Use it to index/search Japanese content properly. It is a search feature; it processes indexed text (no access
role — the Search API index/query still governs access). Note the engines have different requirements (some
need a system binary like MeCab). Enable the engine submodule you need and add the processor to the index.

---

- Tokenize Japanese for Search API.
- Segment Japanese words for indexing.
- Improve Japanese search.
- Offer pluggable NLP engines.
- Ship igo/mecab/sudachi/tinysegmenter.
- Depend on the Search API module.
- Process indexed text (no access role).
- Rely on the index/query for access.
- Note engine requirements (MeCab binary).
- Enable the needed engine.
- Add the processor to the index.
- Handle Japanese tokenization.
- Tokenize text.
- Configure the processor.
- Segment Japanese.
- Configure Search API.
- Handle the tokenizer.
- Index Japanese.
- Enable an engine.
- Provide Japanese tokenization.
