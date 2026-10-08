<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Content Groups adds accordion, horizontal-tab, and vertical-tab structures to the CKEditor 5 editor in a modular, extensible way.

It ships three CKEditor 5 plugins (`Accordion`, `TabsHorizontal`, `TabsVertical`, sharing a `ContentGroupsBase`) that insert grouped, collapsible/tabbed markup, with admin CSS injected into the editor via `ckeditor5-stylesheets` so the structures render meaningfully while editing. Editors add the buttons to a text format's CKEditor toolbar; the allowed markup is governed by the format's own filters. An optional `ckeditor_content_groups_schema` submodule provides schema-aware variants of each widget. The module has no routes, permissions, or services of its own — all behavior is client-side CKEditor 5 plugins plus config.

Use it to let editors build tabbed panels and FAQ-style accordions directly in rich text without custom paragraph types or code.
---
Adds accordion and horizontal/vertical tab content groups to the CKEditor 5 editor.
---
- Insert an accordion into rich-text content
- Add horizontal tabs to a body field
- Add vertical tabs to a body field
- Build FAQ-style collapsible sections in CKEditor
- Create tabbed panels without custom paragraph types
- Add the content-group buttons to a text format's toolbar
- Style the groups inside the editor via injected admin CSS
- Use schema-aware variants via the schema submodule
- Nest content within tab/accordion panels
- Provide structured content blocks to editors
- Keep grouping markup governed by the format's HTML filters
- Reorganize long content into digestible tabs
- Offer modular, extensible content-group widgets
- Localize/label tabs and accordion headers in content
- Enable only the base plugins or add schema support
- Improve readability of dense editorial pages
