<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin-backed fields

- Field type `pluggable_item` exposes derivatives driven by a plugin type; its selectable values come from registered plugins rather than a static allowed-values list.
- Widgets: `pluggable_select`, `pluggable_radios`. Formatter: `pluggable_default`.
- Because core does not auto-expose derivative field types to widgets/formatters, `pluggable.module` implements `hook_field_widget_info_alter()` and `hook_field_formatter_info_alter()` to append every `pluggable_item` derivative to those widgets and the default formatter.

Extend by defining new plugins for the backing plugin type; they then appear as options wherever the `pluggable_item`-derived field is used. No routes or permissions — access follows host-entity field access.
