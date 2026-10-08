<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity View Display Template Suggestions lets you toggle extra Twig template suggestions on an entity render from its view display configuration.

---

Entity View Display Template Suggestions (entity_vdts) adds a "Template suggestions" section to each entity view display edit form (the *Manage display* tab provided by Field UI). The setting is stored as a third-party setting on the `entity_view_display` config entity, so it is per entity type + bundle + view mode. Currently it exposes one option, an "Add bare template suggestion" checkbox: when enabled, the module appends an `ORIGINAL_THEME_HOOK--bare` suggestion (for example `node--bare.html.twig`) to the entity's theme suggestions during rendering. The intent is to let a theme ship one generic, view-mode-agnostic template and opt individual view displays into it, rather than duplicating markup per view mode. Providing the actual `*--bare.html.twig` template is the theme's responsibility; the module only makes the suggestion available. It has no routes, permissions, services, plugins, or dependencies beyond Drupal core (Field UI must be enabled to see the form option).

---

- Enable a shared "bare" template for a specific content type's default view display.
- Opt a single view mode (e.g. teaser) into a generic stripped-down template without touching others.
- Ship one `node--bare.html.twig` in a theme and toggle which displays use it from the UI.
- Give themers a per-display switch for markup variants instead of editing preprocess code.
- Reduce duplicate Twig templates across many view modes that need the same "bare" markup.
- Provide a minimal wrapper-free rendering of an entity for embedding in another layout.
- Toggle a bare template for a taxonomy term view display.
- Toggle a bare template for a user profile view display.
- Toggle a bare template for a media entity view display.
- Toggle a bare template for a custom (config or content) entity view display.
- Let site builders enable the suggestion via the admin UI with no code.
- Keep view-mode-specific templates while adding an alternate suggestion on top.
- Export the toggle in configuration (third-party setting) and deploy it across environments.
- Standardize a "bare" markup convention across bundles by enabling it per display.
- Combine with Twig debug to confirm the `*--bare.html.twig` suggestion appears.
- Prototype an alternate entity template quickly by adding a bare variant.
- Provide a fallback generic template that multiple displays can share.
- Decouple template selection from view mode naming.
- Enable the suggestion on the default display and let other view modes inherit or not per display.
- Support component-style theming where one generic template serves several displays.
