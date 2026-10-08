<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Guide attaches per-field editorial guidance to entity forms: an editor sees documentation (rendered from a Markdown file) beside the widget it applies to, so authoring conventions live next to the fields instead of in a separate manual.

Guidance is enabled per widget via third-party settings on the form display (a `document_path` pointing at a Markdown file under a configured base directory). At runtime a JS behaviour requests `/content-guide/{langcode}`; the `ContentGuideController` reads the Markdown file, renders it with Parsedown, resolves internal links, runs `Xss::filterAdmin()`, and returns HTML. Requests must carry a valid CSRF token bound to the field identifier and the caller needs the `use content guide` permission. Language-specific variants of a document (`name.{langcode}.md`) are used when present. Event subscribers extend coverage to Paragraphs, Media and Entity-reference widgets, and the `cg_field_group` submodule integrates with Field Group.

Settings (base document path, etc.) are at `/admin/config/content/content_guide` under `administer content guide` (restricted); a file-autocomplete endpoint helps pick Markdown files.
---
Point a form widget at a Markdown guide file; editors then see rendered guidance inline while authoring.
---
- Show authoring guidelines next to a specific field
- Render editorial help from a Markdown file
- Attach a guide to a Paragraphs widget
- Attach a guide to a Media reference widget
- Attach a guide to an entity-reference widget
- Provide language-specific guidance via `name.{langcode}.md`
- Configure the base directory where guide files live
- Autocomplete-select a Markdown file when configuring a field
- Integrate guides with Field Group (cg_field_group submodule)
- Resolve internal links inside a guide to site URLs
- Keep authoring conventions versioned as Markdown in the repo
- Grant editors the `use content guide` permission to see guidance
- Restrict guide configuration to site builders
- Reuse one guide document across multiple fields
- Localize guidance per interface language
- Filter rendered guidance through Xss admin filtering