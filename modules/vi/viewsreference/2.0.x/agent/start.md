# viewsreference — agent start

Adds a `viewsreference` field type (extends core entity reference) to embed a View + display
inside a fieldable entity. Widget `viewsreference_autocomplete`; formatters
`viewsreference_formatter` and `viewsreference_lazy_formatter`. Depends on core `views`.
No admin config page — everything is configured on the field's form/display settings.

- Field type, widget, formatter, stored data model → [api/field.md](api/field.md)
- Per-embed controls (argument/title/header/pager…) as ViewsReferenceSetting plugins → [plugins/viewsreference-setting.md](plugins/viewsreference-setting.md)
- Alter the available setting plugins → [hooks/hooks.md](hooks/hooks.md)
- Theme the embedded title / loading placeholder → [theming/theming.md](theming/theming.md)
