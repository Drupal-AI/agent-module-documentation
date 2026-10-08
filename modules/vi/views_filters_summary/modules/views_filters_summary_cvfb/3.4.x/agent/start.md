<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary for CVFB — agent index

Adds JavaScript so the Views Filters Summary remove/reset links work when the exposed filters are rendered in a Configurable Views Filter Block.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Requires companion module `configurable_views_filter_block` (Configurable Views Filter Block).

- Implements: `hook_library_info_alter`.
- Primary hook: `library_info_alter`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
