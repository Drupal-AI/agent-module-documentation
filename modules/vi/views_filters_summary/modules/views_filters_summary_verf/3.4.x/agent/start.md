<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary for VERF — agent index

Renders referenced entity labels in the summary for the Views Entity Reference Filter (VERF) filter.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Requires companion module `verf` (Views Entity Reference Filter).

- Implements: `hook_views_filters_summary_info_alter`.
- Primary hook: `views_filters_summary_info_alter`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
