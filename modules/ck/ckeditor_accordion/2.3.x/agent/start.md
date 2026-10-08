# ckeditor_accordion — agent start

Adds a CKEditor 5 button ("Accordion", plugin id `accordion.Accordion`) that inserts
collapsible accordion markup — `<dl class="ckeditor-accordion">` with paired `<dt>`/`<dd>`
rows — into rich-text fields, plus a global frontend behavior that renders it. Requires
core `ckeditor5`. Settings UI: **Admin → Config → Content authoring → CKEditor Accordion**
(`/admin/config/content/ckeditor-accordion`, route `ckeditor_accordion.settings`, permission
`administer ckeditor accordion`).

- Enable the button per text format, allowed tags, display settings → [configure/ckeditor_accordion.md](configure/ckeditor_accordion.md)
- Accordion markup/classes, frontend library, event, style overrides → [theming/ckeditor_accordion.md](theming/ckeditor_accordion.md)
