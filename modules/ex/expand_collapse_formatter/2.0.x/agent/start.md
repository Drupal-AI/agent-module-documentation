<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# expand_collapse_formatter — agent start

Adds one field formatter, `expand_collapse_formatter` (label "Expand collapse formatter"),
that renders a long text field trimmed to a configurable length with a JavaScript
"Show more / Show less" toggle. Applies to `text_long`, `string_long`, `text_with_summary`
and `text_long_with_summary` fields. No admin settings page (`configure` is null); all
options are per-field formatter settings on the entity's **Manage display** screen, stored
in the view-display config under `field.formatter.settings.expand_collapse_formatter`.

- Apply the formatter + its trim-length / default-state / link text & class settings → [configure/expand_collapse_formatter.md](configure/expand_collapse_formatter.md)
- The FieldFormatter plugin: id, field types, default settings, theme hook & JS behavior → [plugins/expand_collapse_formatter.md](plugins/expand_collapse_formatter.md)
