<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Studio core (formerly Cohesion, `cohesion`) is the base module of Acquia Site Studio: a low-code page-building system with its own entity types, component builder, style manager, template layer, sync/export tooling and Drush commands.

---

Site Studio replaces hand-built themes and Layout Builder with a visual system: site builders define **components**, **styles**, **templates** and **website settings** in the browser, and Site Studio compiles them into CSS and Twig. This module supplies the foundation — the base entity classes (`CohesionConfigEntityBase`, JSON-values entities, content-integrity interfaces), the API layer that talks to Site Studio's build service, the administration controllers, and the Drush commands (`cohesion:import`, `cohesion:rebuild`, `sitestudio:cleanup-orphans`) that import definitions and rebuild generated assets after a deploy. Roughly seventeen submodules layer the actual features on top: `cohesion_elements` (components and helpers), `cohesion_templates` (the Twig template layer), `cohesion_custom_styles` and `cohesion_base_styles` (style management), `cohesion_style_guide`, `cohesion_website_settings`, `cohesion_sync` (package export/import between environments), `sitestudio_page_builder` (the in-page editor), `sitestudio_governance`, `sitestudio_data_transformers`, `sitestudio_claro` and legacy CKEditor support, plus example modules. Around 460 routes and a large permission set reflect that surface. Both new (`hook_sitestudio_*`) and legacy (`hook_dx8_*`) alter hooks are provided for API payloads, token contexts and field prefixes/variables. It requires `contextual`, `imce`, `token`, `entity_reference_revisions`, `rest`, `ckeditor5` and `jquery_ui`, and — being an Acquia product — a licence/API key for the build service.

---

- Build pages visually without writing front-end code.
- Define reusable components for an editorial team.
- Manage a design system's styles from the browser.
- Create templates that apply to specific content types.
- Give editors a drag-and-drop page builder.
- Export a Site Studio configuration package between environments.
- Rebuild generated CSS and templates after a deployment.
- Import Site Studio definitions on a new environment.
- Clean up orphaned Site Studio entities.
- Enforce governance rules on who can edit what.
- Provide a style guide for a brand.
- Manage website-wide settings such as colours and fonts.
- Transform data for display with data transformers.
- Use the in-page editor to build a landing page.
- Keep component definitions in configuration.
- Migrate a legacy CKEditor 4 Site Studio site.
- Alter Site Studio API payloads from a custom module.
- Add custom tokens to Site Studio field contexts.
- Extend components with custom elements.
- Standardise layouts across a large multisite estate.
- Reduce theme development for marketing pages.
- Give designers control without developer round-trips.
- Package a set of components for reuse on another site.
- Audit component usage across a site.
