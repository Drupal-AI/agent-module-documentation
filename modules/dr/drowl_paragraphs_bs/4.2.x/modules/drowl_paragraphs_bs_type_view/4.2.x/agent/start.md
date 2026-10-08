<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: View (drowl_paragraphs_bs_type_view) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `view` Paragraph type.

- **Field**: `field_view` (`viewsreference`, required), settings allow default/page/block/attachment/feed
  plugin types and enable the `argument` + `title` viewsreference options.
- Displayed with the **`viewsreference_formatter`** (label hidden) — renders the referenced view display;
  the view's own access plugin is evaluated at render, so access is respected per viewer.
- Shared `field_settings` (hidden). Layout Builder is disabled on the view display.
- No routes/permissions/services/schema of its own. Depends on `views`, `viewsreference`.

See [paragraphs/view.md](paragraphs/view.md).
