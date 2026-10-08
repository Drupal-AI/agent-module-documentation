<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary for Entity Browser — agent index

Makes the summary's remove/reset links target the correct DOM form when a view's exposed filters are embedded inside an Entity Browser.

Thin integration submodule of **views_filters_summary**. No config, routes, permissions, services, or plugins of its own — it only implements alter hook(s). Requires companion module `entity_browser` (Entity Browser).

- Implements: `hook_views_filters_summary_exposed_form_id_alter`.
- Primary hook: `views_filters_summary_exposed_form_id_alter`.
- To understand the summary area it enhances, see the parent module docs (`modules/views_filters_summary/3.4.x/agent/`), especially `api/hooks.md`.

This submodule has no solution docs of its own: its entire behaviour is the hook(s) above. It has no `configure` route and adds no settings.
