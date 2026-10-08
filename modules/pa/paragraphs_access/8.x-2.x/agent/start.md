<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Access — agent index

Per-paragraph **view/edit access control** — edit enforced in the widget (`$entity->access($operation)`);
**view enforced via the ADVA (Advanced Access) framework** (`ParagraphAccessConsumer`). Depends on
`paragraphs`. Version **8.x-2.0-rc6**. Core `^10||^11||^12`.

**Caveat:** view enforcement depends on ADVA — **verify restricted paragraphs are genuinely hidden in ALL
contexts** (not just themed page): confirm no leak via JSON:API/REST, field-rendering Views, feeds (the
display-vs-data-access concern for embedded content). Test the access model against your delivery paths.
