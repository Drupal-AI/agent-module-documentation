Drupal Atomic Builder (DAB) is an in-admin workbench for building, previewing and scaffolding Single Directory Components (SDC) following the Atomic Design pattern.

---

DAB adds an administration section at `/admin/dab/components` that discovers every SDC on the site through core's `plugin.manager.sdc`, groups the components by their Atomic Design type (atoms, molecules, organisms, templates, pages, or a custom set), and renders each one in a live responsive iframe fed by the component's own prop/slot `examples`. Developers can scaffold brand-new components from a form — DAB writes the `<name>.component.yml`, `<name>.twig`, `README.md` and optional `<name>.js`/`<name>.css` files into a chosen custom module or theme — and can edit, duplicate or delete components. Create/edit/delete are limited to custom modules and themes (core and contrib components are read-only). A Markdown documentation tab (rendered with league/commonmark), an asset/Twig cache-reload button, filtering by name/extension/origin, a configurable component-type list, and a configurable CSS file extension (css, scss, sass, less, styl, pcss) round out the tool. It is intended as a local/development aid and is explicitly not recommended for production.

---

- Browse all Single Directory Components installed on the site from one admin page at `/admin/dab/components`.
- Group and navigate components by Atomic Design type: atoms, molecules, organisms, templates, pages and "other".
- Preview any component live in a sandboxed iframe using the examples declared in its `.component.yml`.
- Switch a preview between responsive breakpoints (base, desktop, tablet, mobile) to check layout.
- Cycle through multiple example "versions" of a component built from its prop and slot `examples` keys.
- Preview the same component name across different providers via the template/provider selector.
- Scaffold a new component from the UI, generating its `.component.yml`, `.twig` and `README.md` in one step.
- Optionally generate a starter `.js` (Drupal behavior) and `.css` file alongside a new component.
- Target a specific custom module or theme as the provider when creating a component.
- Assign a new component to an Atomic Design group so it is placed in the correct components sub-directory.
- Edit an existing custom component's name, group and description without hand-editing YAML.
- Add or remove a component's JS or CSS asset from the edit form.
- Rename or re-home a component by changing its machine name/provider (DAB moves the folder).
- Duplicate a custom component into another provider, wiring up an SDC `replaces:` reference automatically.
- Delete a custom component and its folder from a confirmation form.
- Keep core and contrib components read-only while still previewing them (CRUD restricted to custom code).
- Read per-component documentation rendered from Markdown in a dedicated Documentation tab.
- Filter the component list by name substring, by extension type (module/theme) and by origin (custom/contrib/core).
- Reset all active filters with one click.
- Reload the preview while flushing JS/CSS asset caches and the Twig cache via the built-in reload button.
- Configure the available component types (as `machine_name|Label` lines) at `/admin/dab/components/settings`.
- Configure the CSS file extension DAB generates (e.g. `.scss`) so components integrate with a Sass/PostCSS build.
- Expose components as navigation/toolbar menu links, each with View/Documentation/Edit/Duplicate/Delete tabs.
- Give front-end developers a components playground so they can build and test UI without creating full content.
