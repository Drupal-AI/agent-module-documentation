<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hide Non-Editable Content (hide_non_editable_content) — agent index

**Filters the core `content` view (and its exposed Type filter) so users see only nodes they can edit/delete.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10`
- **Dependencies:** views, node
- **Services:** `hide_none_editable_content.views_query_alter` (`ViewsQueryAlter`), `hide_none_editable_content.form_views_exposed_form_alter` (`FormViewsExposedFormAlter`).
- **Hooks:** `hook_views_query_alter`, `hook_form_views_exposed_form_alter`. No config, no permissions of its own.

**Security:** server-side enforcement — restrictions are added to the Views SQL query, so hidden rows never reach the client (not a JS hide). It only ever removes rows/filter options, never grants access, so it cannot over-expose. Scoped to the `content` view only; it is a UX filter, not a node-access API (does not cover REST/other views/direct URLs). See [hooks/behavior.md](hooks/behavior.md).
