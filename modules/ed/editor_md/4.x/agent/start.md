<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editor.md (editor_md) — agent index

**Registers the Editor.md JavaScript Markdown editor as a Drupal text editor plugin for textareas; rendering/sanitization is delegated to the text format's filters.**

- **Version:** 4.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Dependency:** `markdown` (contrib) — provides the Markdown-to-HTML filter.
- **Library:** Editor.md must be installed at `/libraries/editor.md`.
- **Plugin:** `@Editor(id="editor_md", is_xss_safe=FALSE, supported_element_types={"textarea"})`.
- **Configure:** *Config > Content authoring > Text formats and editors* → set editor to Editor.md.

**Security:** the editor declares `is_xss_safe = FALSE`, so stored Markdown is sanitized by the text-format filter pipeline (markdown filter + Drupal XSS/HTML restriction), not by this module — output safety depends on correct format configuration. Custom toolbar-icon input is run through `Xss::filterAdmin()`. No stored-XSS introduced by the module itself; no findings.

See [configure/editor_md.md](configure/editor_md.md).