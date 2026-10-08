<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity to Text - Paragraphs adds a developer service that converts a Paragraphs reference field into an array of clean plain-text blocks.

---

This submodule of Entity to Text ships one container service, `entity_to_text_paragraphs.extractor.paragraphs_to_text` (`ParagraphsToText`). Given a paragraph-reference field item list (`EntityReferenceRevisionsFieldItemList`), it loads each referenced Paragraph, renders it with its view builder in `full` view mode and the item's langcode, and runs the rendered markup through the base module's `HtmlPurifier` to produce trimmed plain text — returning one string per Paragraph. It requires the base `entity_to_text` module plus the Paragraphs (`drupal/paragraphs`) module at runtime, and provides no routes, permissions, config, or plugin types.

---

- Convert a node's paragraph-reference field into an array of plain-text blocks.
- Index layered Paragraphs content into Solr or Elasticsearch as text.
- Build embeddings/AI prompt context from Paragraphs-based page bodies.
- Generate plain-text output of Paragraphs for SEO or JSON-LD.
- Flatten a landing page assembled from Paragraphs into searchable text.
- Extract text from each Paragraph rendered in its `full` view mode.
- Produce per-Paragraph text segments for chunked embedding pipelines.
- Combine Paragraph text with node-field text for a complete indexed document.
- Feed Paragraphs content into automatic tagging or classification.
- Include translated Paragraph text using the reference item's langcode.
- Strip all HTML/CSS from rendered Paragraphs via the shared purifier.
- Pull text from nested/complex Paragraph layouts for previews or summaries.
- Migrate Paragraphs content to a plain-text store.
- Supply Paragraphs text to a search index during content import.
- Prepare Paragraphs content for readability or word-count analysis.
