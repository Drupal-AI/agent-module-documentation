<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Japanese NLP provides Japanese natural language processing functionality.

---

Japanese NLP (jnlp) provides **Japanese natural-language-processing** — primarily tokenization (word
segmentation), which Japanese needs because words aren't space-separated — via pluggable engine submodules
(`jnlp_igo_php`, `jnlp_mecab`, `jnlp_sudachi`, `jnlp_tinysegmenter`). It provides its own permissions, in the
Natural Language Processing package.

Use it as the NLP backend for Japanese text (e.g. search tokenization). It is a developer/language-processing
library; it processes text and has no content or access role. Note the engines have different requirements
(some need a system binary like MeCab). Enable the engine submodule you need.

---

- Provide Japanese NLP/tokenization.
- Segment Japanese words.
- Offer pluggable engines.
- Ship igo/mecab/sudachi/tinysegmenter.
- Back Japanese search tokenization.
- Serve language processing.
- Process text (no content/access role).
- Note engine requirements (e.g. MeCab binary).
- Provide its own permissions.
- Enable the needed engine.
- Handle Japanese NLP.
- Tokenize Japanese.
- Configure the engine.
- Handle the library.
- Segment text.
- Configure NLP.
- Handle tokenization.
- Process Japanese.
- Enable an engine.
- Provide Japanese NLP.
