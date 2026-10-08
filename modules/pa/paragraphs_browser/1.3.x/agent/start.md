<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Browser

A modal "browser" widget for Paragraphs `entity_reference_revisions` fields: editors pick a
paragraph type from user-defined, filterable groups, each with an optional preview image and
description. Requires the `paragraphs` module.

Core moving parts:
- Config entity `paragraphs_browser_type` (a "Browser Type") holds ordered `groups` and a
  `map` of paragraph-type-id → group.
- Two field widgets replace the default Paragraphs add UI: `paragraphs_browser` (EXPERIMENTAL)
  and `entity_reference_paragraphs_browser` (Classic).
- Per-paragraph-type third-party settings (`description`, `image_path`) render the browser cards.

Capabilities:
- [Configure browsers, groups, mappings, widgets & templates](configure/paragraphs_browser.md)
