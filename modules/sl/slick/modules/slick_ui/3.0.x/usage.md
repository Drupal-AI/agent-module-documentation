Slick UI is the administrative interface for the Slick module, giving site builders forms to create, edit, duplicate, and delete Slick carousel optionsets without editing YAML.

---

Slick UI is an optional submodule of Slick that supplies the management screens for the `slick` optionset configuration entity. Once enabled it exposes the optionset collection at `/admin/config/media/slick`, add/edit/duplicate/delete forms, and a global settings page at `/admin/config/media/slick/ui`. It registers the list builder and entity forms via `hook_entity_type_build()`, adds admin menu, task, and action links, and gates everything behind the single `administer slick` permission. It carries no rendering logic of its own — the runtime carousel behavior, field formatters, and theming all live in the parent Slick module. You enable Slick UI on a working site to build optionsets by hand, then can leave it off in production and deploy the resulting `slick.optionset.*` config. It also renders the module's help/README docs on the help page. In short, it is the point-and-click front end for configuring Slick.

---

- Create a new carousel optionset through a web form instead of writing YAML.
- Edit an existing optionset's slides-to-show, autoplay, arrows, and dots settings.
- Duplicate an optionset as a starting point for a new variant.
- Delete optionsets that are no longer used.
- Browse the full list of configured optionsets at `/admin/config/media/slick`.
- Set the responsive breakpoints for a carousel visually.
- Pick a skin for an optionset from a dropdown.
- Configure sitewide Slick settings (library choice, auto-attach) at the UI settings page.
- Choose between the Slick and Accessible Slick JavaScript libraries.
- Grant a content team the `administer slick` permission to manage carousels.
- Enable the UI on staging, export optionsets, then disable it in production.
- Verify optionset config before deploying it between environments.
- Read the module's README/FAQ/troubleshooting docs from the admin help page.
- Add a new autoplay slideshow optionset for a homepage hero.
- Configure a thumbnail (asNavFor) optionset for a product gallery.
- Toggle center mode or vertical mode on an optionset without code.
- Rename or relabel an optionset for clarity.
- Group optionsets for easier selection in formatter forms.
- Enable the "optimized" flag to trim default values from stored config.
- Quickly access add/edit forms via the admin action and task links.
