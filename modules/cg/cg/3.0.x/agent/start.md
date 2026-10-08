<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Guide (cg) — agent index

**Per-field editorial guidance** rendered from Markdown and shown beside form widgets for editors.

**Version:** 3.0.x (git branch `3.0.x`). Core: `^10.3 || ^11`. Depends on core `filter` + PHP lib `erusev/parsedown`. Submodule: `cg_field_group`.

Enable per widget via third-party settings (`document_path`) on the form display. Routes: `cg.settings` at `/admin/config/content/content_guide` (`administer content guide`, restricted); `cg.data` at `/content-guide/{langcode}` (`use content guide`) — reads the doc, renders with Parsedown, `Xss::filterAdmin`; `cg.autocomplete_md_files` (`administer content guide`). Requires a CSRF token bound to the `X-CG-Identifier` header + `X-CG-Document-Path` header. Event subscribers: Paragraphs, Media, EntityReference. Config `cg.settings` (`document_base_path`).

See [configure/guides.md](configure/guides.md).