# link_attributes — agent start

Adds a **Link (with attributes)** field widget so editors can set HTML attributes (target,
rel, class, aria-label, title, id, name, accesskey…) on link-field values. Depends on core
`link`. No central config UI — configured per form-display widget settings.

- Enable the widget + choose attributes per field → [configure/widget.md](configure/widget.md)
- Define a new attribute (YAML plugin) → [plugins/link-attributes.md](plugins/link-attributes.md)
- Alter attribute plugin definitions in code → [hooks/hooks.md](hooks/hooks.md)
- Menu-link attributes submodule → link_attributes_menu_link_content
- Linkit + attributes submodule → linkit_attributes
