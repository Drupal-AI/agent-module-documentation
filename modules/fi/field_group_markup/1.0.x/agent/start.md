# field_group_markup — agent start

Adds one **Field Group formatter** (`markup`) to the `field_group` module. When you create a
field group on an entity's *Manage form display* or *Manage display*, "Markup" becomes a
selectable formatter that renders authored, token-replaced processed text inside a
`field_group_html_element` div. No admin page, no permissions, no config UI of its own — all
settings live on the field group. Requires the `field_group` module.

- Configure a Markup group and its settings keys (`markup.value`/`markup.format`, `id`, `classes`, `show_empty_fields`) → [configure/markup-formatter.md](configure/markup-formatter.md)
