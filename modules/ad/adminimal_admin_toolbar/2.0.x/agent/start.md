# adminimal_admin_toolbar — agent start

A CSS/library layer that restyles the Admin Toolbar with the minimalist "Adminimal" dark
look. Adds no toolbar features — it attaches stylesheets and a body class. Requires contrib
`admin_toolbar` (which pulls in core `toolbar`). Styling loads only for users with the core
`access toolbar` permission. Version 2.0.x is a **dev** release (no version in info.yml).

- Enable it, the one setting (avoid Open Sans font), config object/route → [configure/adminimal_admin_toolbar.md](configure/adminimal_admin_toolbar.md)
- How the restyle works: libraries, body class, hooks, CSS files → [theming/adminimal_admin_toolbar.md](theming/adminimal_admin_toolbar.md)
