# colorbox_inline — agent start

Extends the parent **Colorbox** module to open content **already present on the page** inside
a Colorbox lightbox, driven by `data-colorbox-inline` HTML attributes. No AJAX (use
`colorbox_load` for that). No admin UI, no config, no permissions, no Drush — enabling the
module is the whole setup. Depends on `colorbox:colorbox`.

- Mark up a link/element to open inline content in a modal (data attributes) → [theming/data-attributes.md](theming/data-attributes.md)
- How the JS behavior + library attach and run at runtime → [api/behavior.md](api/behavior.md)
