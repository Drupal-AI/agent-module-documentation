<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary for Search API — agent index

Adds Search API support to Views Filters Summary: fulltext keyword output plus correct handling of Search API term and options facets.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Depends only on the parent `views_filters_summary` (works with Search API-backed views).

- Implements: `hook_views_filters_summary_plugin_alias`, `hook_views_filters_summary_replacements_alter`, `hook_form_alter`, `hook_views_filters_summary_valid_index`.
- Primary hook: `views_filters_summary_replacements_alter`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
