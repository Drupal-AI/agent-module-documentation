<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Content Groups — plugins

Three CKEditor 5 plugins under `src/Plugin/CKEditor5Plugin/`, all extending `ContentGroupsBase`:

- **Accordion** — collapsible sections.
- **TabsHorizontal** — horizontal tab strip.
- **TabsVertical** — vertical tab strip.

Enable per text format: add the corresponding toolbar button in the format's CKEditor 5 configuration. Editor-side styling is injected via the `.info.yml` `ckeditor5-stylesheets` (accordion/tabs admin CSS) so the structures are legible while editing.

**Schema submodule:** `ckeditor_content_groups_schema` ships `AccordionSchema`, `TabsHorizontalSchema`, `TabsVerticalSchema` plus JS schema definitions for schema-aware editing. Enable it when you need the schema-driven variants.

No routes, permissions, or services — everything is CKEditor plugin + config. The generated markup is constrained by the text format's HTML-restricting filters.
