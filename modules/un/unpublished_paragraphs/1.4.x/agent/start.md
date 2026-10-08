<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unpublished Paragraphs — agent index

A front-end-only helper for the **Paragraphs** module. On non-admin routes it marks every
**unpublished** paragraph and adds a floating toggle button so a privileged viewer can show/hide
them. **No config page, no settings, no config schema, no permission, no Drush, no plugins** —
just two hooks and one asset library. Depends on `paragraphs`.

- **How it works (hooks, CSS classes, the toggle library) and how to restyle it** →
  [theming/toggle.md](theming/toggle.md)

Key facts:
- `hook_preprocess_paragraph()` runs only when NOT an admin route
  (`router.admin_context`->`isAdminRoute()` is FALSE).
- For a paragraph where `$paragraph->isPublished()` is FALSE it adds classes `paragraph` +
  `unpublished` and attaches the `unpublished_paragraphs/unpublished-toggle` library.
- CSS hides `.paragraph.unpublished` by default; JS appends a fixed "Toggle visibility of
  unpublished items" button only when the page contains at least one unpublished paragraph;
  click toggles them.
- The module grants **no** access itself — whether an unpublished paragraph renders at all is
  core Paragraphs / entity access. `configure: null`.
