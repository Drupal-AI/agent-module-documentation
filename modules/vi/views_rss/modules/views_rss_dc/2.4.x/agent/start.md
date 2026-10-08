<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: DC Elements — agent index

Adds the Dublin Core Metadata Element Set (`dc:title`, `dc:creator`, `dc:date`, `dc:subject`,
...) as selectable RSS **item** elements via the parent `views_rss` module's
`hook_views_rss_*` hooks. No channel elements, no settings page — its 15 elements appear in
the row plugin's "Item elements : dc" fieldset on any View using the `views_rss_fields` row
plugin.

- **The 15 dc:* elements, their config path, and the two with special preprocessing
  (dc:creator, dc:date)** → [configure/dc-elements.md](configure/dc-elements.md)

Key fact: elements live under namespace `dc`, module key `views_rss_dc`, e.g.
`row.options.item.dc.views_rss_dc.creator` in `views.view.<name>` config. See the parent's
[hooks/element-hooks.md](../../../../2.4.x/agent/hooks/element-hooks.md) for the underlying
`hook_views_rss_*` mechanism.
