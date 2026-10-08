<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Topics — agent index

Config-only module for the LocalGovDrupal distribution: a shared **Topic** taxonomy
(`localgov_topic`), a node entity-reference **field storage** (`localgov_topic_classified`), and an
optional **Topics view** with entity_reference displays. No admin UI (`configure` null), no own
permissions, no services/plugins/Drush. Depends on core `taxonomy`.

- **The vocabulary, the field storage, the Topics view, and the roles hook** →
  [configure/structure.md](configure/structure.md)

Key facts:
- Vocabulary `localgov_topic` ("Topic"). Field storage `node.localgov_topic_classified`
  (entity_reference → taxonomy_term, cardinality -1, translatable, not attached to any bundle).
- `views.view.topics` is **optional** config: `default` page display + `entity_reference_1`
  ("Private topics") and `entity_reference_2` ("Public topics", published only) displays.
- `localgov_topics_localgov_roles_default()` grants the LocalGov Editor role
  `create/edit/delete terms in localgov_topic` (only when `localgov_roles` is installed).
