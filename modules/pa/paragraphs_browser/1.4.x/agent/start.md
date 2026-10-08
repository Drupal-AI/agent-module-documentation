<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Browser

A modal "browser" widget for Paragraphs `entity_reference_revisions` fields: editors pick a
paragraph type from user-defined, filterable groups, each with an optional preview image and
description. Requires the `paragraphs` module. Drupal 10.2+ or 11.

Core moving parts:
- Config entity `paragraphs_browser_type` (a "Browser Type") holds ordered `groups` and a
  `map` of paragraph-type-id → group.
- Two field widgets replace the default Paragraphs add UI: `paragraphs_browser`
  (label "Paragraphs Browser (stable)") and `entity_reference_paragraphs_browser`
  (label "Paragraphs Browser Legacy").
- The browser card's description comes from the paragraph type's own `description`; a
  per-paragraph-type third-party setting (`image_path`, under provider `paragraphs_browser`)
  supplies the preview image.

Capabilities:
- [Configure browsers, groups, mappings, widgets & templates](configure/paragraphs_browser.md)

## Diff 1.3.x → 1.4.x

- **Core requirement raised:** `core_version_requirement` is now `^10.2 || ^11` (Drupal 9 and
  10.0/10.1 dropped); `composer.json` requires `drupal/core: ^10.2 || ^11`.
- **Card description source changed.** The browser card description now reads the paragraph
  type's native `description` (`ParagraphsType::getDescription()`), not a `paragraphs_browser`
  third-party `description` setting. The paragraph-type edit-form fieldset no longer adds a
  description field (it keeps only the image path / upload fields).
- **New update hook `paragraphs_browser_update_8001`** migrates any existing
  `paragraphs_browser` third-party `description` into the paragraph type's native
  `description` (only when that native description is empty).
- **Widget labels renamed:** `paragraphs_browser` "Paragraphs Browser EXPERIMENTAL" →
  "Paragraphs Browser (stable)"; `entity_reference_paragraphs_browser` "Paragraphs Browser
  Classic" → "Paragraphs Browser Legacy" (described as legacy/deprecated).
