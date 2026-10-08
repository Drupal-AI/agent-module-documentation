<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary for Commerce — agent index

Teaches Views Filters Summary how to render Commerce's entity-bundle exposed filter.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Requires companion module `commerce` (Commerce).

- Implements: `hook_views_filters_summary_plugin_alias`.
- Primary hook: `views_filters_summary_plugin_alias`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
