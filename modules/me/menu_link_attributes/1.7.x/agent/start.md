# menu_link_attributes — agent start

Adds an **Attributes** fieldset to the menu link add/edit form so editors can set HTML
attributes (class, target, rel, id, data-*) on links and their `<li>` containers. Depends on
core `menu_link_content`. Values live in the link field `options` (`attributes` /
`container_attributes`) and render through core menu theming.

- Define which attributes appear (YAML config) → [configure/attributes.md](configure/attributes.md)
- Permissions gating the form + config → [permissions/permissions.md](permissions/permissions.md)
- How values are read/written (form alter, entity builder, preprocess) → [extend/internals.md](extend/internals.md)
