<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Menu Anchor provides an anchor menu field for paragraphs and a block to render anchor links.

---

It ships a field type (`PmaAnchorItem`), widget (`PmaAnchorWidget`) and formatter (`PmaAnchorFormatter`) that let an editor attach a named anchor to a paragraph, plus a block plugin (`ParagraphsMenuAnchorBlock`) that collects those anchors from the paragraphs on the current entity and renders them as an in-page navigation menu (jump links). The formatter outputs the anchor target on the paragraph markup so the block's links scroll to it.

This solves the common need for a "table of contents" or section-jump menu on long paragraph-built pages (landing pages, documentation, marketing pages) without hand-maintaining anchors. It is implemented purely as field plugins and a block — there are no custom routes or permissions — so access follows normal field and block visibility. Typical setup: add the anchor field to your paragraph type(s), set an anchor label per paragraph, place the anchor-menu block in a region (e.g. a sidebar), and the block builds the jump navigation automatically.

---
- Add jump-link navigation to a long paragraph page
- Attach a named anchor to a paragraph
- Render a table-of-contents style menu block
- Let editors label each section for navigation
- Build in-page navigation for a landing page
- Provide section shortcuts on documentation pages
- Place the anchor menu in a sidebar region
- Generate anchor links automatically from paragraphs
- Improve navigation on marketing one-pagers
- Scroll users to a specific paragraph section
- Show only sections that have an anchor set
- Reuse anchors across multiple paragraph types
- Give each anchor a human-friendly label
- Keep anchors in sync with paragraph content
- Add accessible in-page navigation
