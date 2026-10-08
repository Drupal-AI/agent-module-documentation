<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary for BEF — agent index

Fixes the summary label for boolean filters that Better Exposed Filters renders as a single checkbox.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Requires companion module `better_exposed_filters` (Better Exposed Filters).

- Implements: `hook_views_filters_summary_filter_value_label_alter`.
- Primary hook: `views_filters_summary_filter_value_label_alter`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
