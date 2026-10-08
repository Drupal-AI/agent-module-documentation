<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Exclude Paragraphs (search_api_exclude_paragraphs) — agent index

**A Search API processor that removes chosen Paragraph types from indexed content so they are not searchable.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^10 || ^11
- **Dependencies:** paragraphs:paragraphs, search_api:search_api

## Surface
- No routes, permissions, or services.
- `Plugin\search_api\processor\SearchApiExcludeParagraphs` — index-time processor; its settings list the Paragraph bundles to exclude from indexed content.

**Security:** no request-facing surface; configured only through the Search API index processor UI (`administer search_api`). No security findings.
