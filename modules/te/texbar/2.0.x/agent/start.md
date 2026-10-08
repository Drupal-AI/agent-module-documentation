<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LaTeX Toolbar (texbar) — agent index

**Attaches a markItUp LaTeX toolbar to textareas matching a configurable jQuery selector.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Configure:** `texbar.settings` → `/admin/config/content/texbar` (permission `administer texbar`, restrict access)
- **Setting:** `selector` — jQuery selector for target textareas
- **Attaches:** libraries `texbar/markitup` + `texbar/texbar` and `drupalSettings.texbar.selector` on all pages (`hook_page_attachments`)
- **Service:** `texbar.library_builder` (`LibraryBuilder`) · **Drush:** `texbar.commands` (fetch/build assets)

**Security:** single admin config route gated by `administer texbar`; the toolbar only inserts text client-side into fields the author already edits. No anonymous or mutating endpoints. LaTeX rendering is out of scope (pair with MathJax).

See [configure/settings.md](configure/settings.md)
