<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Title Help Text — agent index

Adds per-content-type help text under the **Title** field on node add/edit forms. No settings
page (`configure: null`), no permissions, no Drush, no plugins. Its only state is a
third-party setting on each node type.

- **Where the text is stored and how to set it (UI, drush, PHP)** →
  [configure/help-text.md](configure/help-text.md)
- **Which hooks add the textarea and inject the description (incl. Inline Entity Form)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the text lives at
`node.type.<bundle>.third_party.node_title_help_text.title_help`. It is injected as the title
widget's `#description` **only if the field has no description already**. Schema:
`node.type.*.third_party.node_title_help_text` (one `title_help` text value).
