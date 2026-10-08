Simple Mega Menu example is a starter-kit submodule of Simple Mega Menu: enabling it installs a ready-made `megamenu` mega-menu bundle (with image/link/text fields, view modes, an image style, and a template) so you can see a working mega menu and adapt it, rather than building a bundle from scratch.

---

The submodule ships pure configuration and a theme template — it has no PHP logic beyond `hook_help()` and a `hook_theme()` that registers a `simple_mega_menu__megamenu` theme hook. On install it creates the `simple_mega_menu_type` bundle **`megamenu`** (labelled "MegaMenu", targeting the `main` menu), five fields on that bundle — `field_image` (image), `field_image_link` (link), `field_image_title` (string), `field_text` (text_long) and `field_links` (link) — an image style named `simple_megamenu`, form/view displays including the module's **before**/**after**/default view modes, and a `simple-mega-menu--megamenu.html.twig` template that renders an image (optionally wrapped in the link), a title and text in the *before* view mode. It depends on `simple_megamenu` plus core `file`, `image`, `link`, `text`, and `user`. Because it's shipped via config/install (and marked as a Feature), you can enable it to get an instant example, copy its bundle/fields/template into your own bundle, and then disable it — the parent module provides all runtime behaviour. It defines no configure route, no permissions, and no config schema of its own.

---

- Get a working mega-menu bundle instantly to learn how Simple Mega Menu is structured.
- Inspect the `megamenu` bundle's fields as a template for building your own bundle.
- See how the `before` and `after` view modes are wired to a template.
- Copy `simple-mega-menu--megamenu.html.twig` as a starting point for custom mega-menu markup.
- Reuse the shipped `field_image` / `field_links` / `field_text` field definitions.
- Study how an image style (`simple_megamenu`) is applied to a mega-menu image.
- Attach the example `megamenu` bundle to the main menu and try it end to end.
- Create example mega-menu entities of the `megamenu` bundle to preview rendering.
- Demonstrate Simple Mega Menu to stakeholders without custom configuration.
- Use the example as a reference for which fields suit a mega menu (image, links, text).
- Learn the `data-simple-mega-menu` attachment flow using the ready-made bundle.
- Bootstrap a proof-of-concept mega menu on a fresh site.
- Export the example config as a Feature and adapt it in your own module.
- Compare your custom bundle against the example's form/view display setup.
- Understand theme suggestions by examining the `simple_mega_menu__megamenu` hook.
- Provide a training sandbox for content editors to practise building mega menus.
- Seed a design prototype with realistic mega-menu fields.
- Disable after copying so only your own bundle remains in production.
- Reference the example's link-wrapped image pattern for clickable mega-menu banners.
- Validate that Simple Mega Menu is installed correctly by rendering the example.
