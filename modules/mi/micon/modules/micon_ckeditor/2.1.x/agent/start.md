<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon CKEditor — agent index

Trivial glue: makes Micon icon fonts render inside the CKEditor editing area. No config, no
field, no widget, no permission, no `configure` route — **enabling it is the whole setup**.
Depends only on `micon`.

Key facts (grounded in `micon_ckeditor.module`, the entire module):
- Implements **`hook_ckeditor_css_alter()`**: for each active package
  (`\Drupal\micon\Entity\Micon::loadActive()`) it appends that package's generated `style.css`
  (via `file_url_generator`) to the editor stylesheets.
- The packages injected are exactly the active/published Micon packages (out of the box: `fa`).
- List active packages: `\Drupal\micon\Entity\Micon::loadActiveLabels()`.

See the parent `micon` docs for icon packages and the icon API.
