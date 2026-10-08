# field_formatter_class — agent start

Adds a **Field Formatter Class** text setting to every field formatter and widget, letting site
builders attach CSS classes to a field's outer HTML wrapper from **Manage display** (and Manage
form). The value is stored as a third-party setting (`field_formatter_class.class`) on the display
config and rendered onto the field template's wrapper `attributes`. Requires only core `field`.
No config UI route, no permissions — the setting appears on every field automatically.

- Where the setting lives, how it's stored, token support → [configure/field_formatter_class.md](configure/field_formatter_class.md)
- How the class reaches the field wrapper (preprocess, escaping, tokens) → [theming/field_formatter_class.md](theming/field_formatter_class.md)
