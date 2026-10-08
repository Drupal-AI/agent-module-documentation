<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Table Header Scope Attribute — agent index

Two `filter` plugins for text formats that make author-entered tables accessible: set `scope`
on `<th>` cells, and demote empty `<th>` to `<td>`. No config entity, no configure route, no
permissions, no Drush, no new plugin types.

- **Enable the filters on a text format (ids, weights, the required order)** →
  [configure/filters.md](configure/filters.md)
- **How the scope logic + empty-cell detection work (plugins, validator service)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Filter ids: `table_header_scope_attribute` ("Set scope attribute for table headers") and
  `table_header_scope_attribute_empty_th_to_td` ("Transform empty table header to table data").
- Config lives inside the text format: `filter.format.<id>` → `filters.<filter_id>.status` /
  `.weight`. The module has no config of its own.
- **Order matters:** the scope filter must run *before* the empty-to-td filter, and both below
  core "Limit allowed HTML tags". A form validation on the text-format form enforces this.
- Scope filter only acts on tables containing a `<td>`; skips `<th>` that already have `scope`
  or are empty. Service `table_header_scope_attribute.html_element_validator` defines "empty".
