<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary A11y — agent index

Accessibility improvements for the Views Filters Summary remove links: it rewrites each remove-`X` link with screen-reader-friendly markup and adds an accessibility stylesheet.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Depends only on the parent `views_filters_summary` (works with the summary-backed views).

- Implements: `hook_theme`, `hook_library_info_alter`, `hook_views_filters_summary_item_alter`.
- Primary hook: `views_filters_summary_item_alter`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
