<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs auto anchor — agent index

Renders a UUID-based anchor target before each Paragraph (deep-linking via `#<uuid>`) and adds a
"Copy anchor to clipboard" button to the Paragraphs widget. Depends on `paragraphs`. No config, no permissions.

Quick facts:
- Display: `hook_preprocess_paragraph()` injects a `paragraphs_auto_anchor_target` element (template `paragraphs-auto-anchor-target`) with the paragraph UUID as the id.
- Editing: `hook_field_widget_single_element_paragraphs_form_alter()` adds the copy-anchor button; for `from_library` bundles it resolves the referenced reusable paragraph's UUID.
- Automatic once enabled — nothing to configure.
