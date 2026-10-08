<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metatag: Google Scholar — agent index

Adds the Highwire Press `citation_*` meta tags to Metatag for Google Scholar indexing. Depends on
`metatag`. No settings form (`configure` null), no permissions, no services/Drush. Just a Metatag
group + tag plugins; all behaviour is inherited from Metatag core.

- **The Google Scholar group, every `citation_*` tag id, and how/where to set values** →
  [configure/tags.md](configure/tags.md)

Key facts:
- Group plugin `google_scholar` (`GroupBase`), 14 tag plugins extending `MetaNameBase`.
- Configure via Metatag defaults at `/admin/config/search/metatag` or a per-entity Metatag field —
  a "Google Scholar" section appears there. Values accept tokens.
