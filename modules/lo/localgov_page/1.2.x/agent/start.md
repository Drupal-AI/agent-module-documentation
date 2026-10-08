<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Page (localgov_page) — agent index

**Installs the `localgov_page` node type for building rich pages with Paragraphs / Layout Paragraphs.**

- **Version:** 1.2.x (1.2.2)
- **Core:** ^10 || ^11
- **Provides:** `node.type.localgov_page` + fields (`localgov_paragraph_content`, `localgov_page_summary`, `localgov_page_banner`, `localgov_hide_summary`) and view/form displays.
- **Code:** one `hook_preprocess_node` that unsets the summary on the full view when `localgov_hide_summary` is `1`. No routing, no permissions.yml, no services.
- **Depends on:** node, paragraphs, layout_paragraphs, field_group, localgov_paragraphs*, localgov_core:localgov_media.
- **Security:** Config-only content type; access is standard core node access with no custom permissions or routes. No security-relevant surface.