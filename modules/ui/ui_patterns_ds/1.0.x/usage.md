<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns DS lets a Display Suite field use a UI Patterns component — or a Single Directory Component (SDC) — as its template, instead of Display Suite's own field markup.

---

Display Suite and UI Patterns solve adjacent problems that do not natively meet. Display Suite controls how an entity's fields are arranged and wrapped; UI Patterns (and, increasingly, core's SDC) define reusable components with declared props and slots. A site using both ends up with components for everything except the field level, where Display Suite's field templates take over and the design system stops applying.

This module bridges the gap. It registers a Display Suite field template plugin (`ui_pattern_ds_component`) that appears in the *Manage display* field-settings form; when chosen for a field, Display Suite renders that field through a UI Patterns component instead of its stock markup. A dedicated UI Patterns source plugin (`ds_field`) exposes the field's rendered value so it can be mapped onto a component slot, and a `hook_preprocess_field__component()` implementation wires up the entity, field-name and pre-built field render array as source contexts at render time. A one-line Twig template (`templates/component.html.twig`) prints the resulting component render array.

Because the field's value is handed to the component as a render array through Drupal's normal render pipeline, the same component the rest of the site uses can now also render Display Suite fields — so a change to the component propagates everywhere rather than only outside Display Suite regions. The module also registers a schema for the field-template's stored settings and, via `hook_config_schema_info_alter()`, patches the schema for components used as Display Suite *layouts*.

It depends on `ui_patterns`, `ui_patterns_layouts` and `ds_extras`, so it is only meaningful where that whole stack is already in place. The current release is an alpha (1.0.0-alpha3) on a rendering integration, so verify it against the specific Display Suite (`^3.28`) and UI Patterns (`^2.0`) versions in use.

---

- Render a Display Suite field through a UI Patterns component.
- Use a Single Directory Component (SDC) as a Display Suite field template.
- Apply a site-wide design system at the field level inside Display Suite.
- Map a field's rendered value onto a component slot with the `ds_field` source.
- Render a Display Suite pseudo-field (e.g. the "Title" field) through a component.
- Keep component changes propagating into Display Suite field regions.
- Avoid duplicating markup between Display Suite field templates and components.
- Reuse one card/media component across Display Suite and Layout Builder displays.
- Bring a legacy Display Suite site onto a component-based front end incrementally.
- Standardise field markup across multiple view modes via a shared component.
- Select the "FIeld template for UI pattern" option on a field's *Manage display* gear.
- Pass component props/slots configured per view display and stored as `ds.ft` settings.
- Use tokens like `[plain:node:title]` in component attributes, resolved from the entity context.
- Fix components used as Display Suite *layouts* whose settings resolve under `layout_plugin.settings.ds.*`.
- Plan a migration from Display Suite field templates to UI Patterns / SDC components.
- Audit which fields still bypass the design system by using stock DS templates.
- Verify field rendering after upgrading Display Suite or UI Patterns.
- Confirm the full UI Patterns stack (`ui_patterns`, `ui_patterns_layouts`, `ds_extras`) is installed.
- Export a view display's component field-template configuration as config.
- Provide a fallback message ("Unable to render field…") when field settings are incomplete.
