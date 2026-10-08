# Search API Exclude Paragraphs — manual setup guide

**Search API Exclude Paragraphs** (`search_api_exclude_paragraphs`) is a Search
API *processor* that strips selected Paragraph types out of content before it is
indexed, so their text never becomes searchable. If you index the **rendered
HTML** of a node — a common approach on Paragraphs-based layouts — you often end up
indexing things you'd rather not: embedded Views output, promotional link blocks,
calls to action, or repetitive layout features that have nothing to do with the
node itself. This processor lets you leave those out.

The way it works is simple. In the processor's settings you tick the Paragraph
bundles you want excluded. During indexing, the processor removes those paragraphs
from the item's rendered/extracted content, so their body text is never written
into the search index. The result is cleaner, more relevant search results and a
smaller index, without you having to abandon the convenient "index the rendered
HTML" approach. You can apply different exclusions on different indexes, and the
exclusions combine with any other Search API processors in the pipeline.

This is not an on-enable feature — enabling the module makes the processor
available, and you then turn it on and pick the Paragraph types per index. It
depends on **Paragraphs** (`paragraphs`) and **Search API** (`search_api`). The
module has no routes, permissions, or services of its own: configuration lives
entirely inside the Search API index's processor settings, which are already gated
by the `administer search_api` permission. Note this release (`1.0.0-alpha1`) is an
alpha and is **not covered** by Drupal's security advisory policy.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Configuration happens on each Search API index:

1. Add a search **server** and an **index** in Search API (if you don't already
   have them), and make sure the index draws on rendered/extracted content.
2. Edit the index and open the **Processors** tab.
3. Enable the **Exclude Paragraphs** processor.
4. In the processor's settings, select the Paragraph types that should be excluded
   from that index.
5. Save and **re-index** so the change takes effect.
