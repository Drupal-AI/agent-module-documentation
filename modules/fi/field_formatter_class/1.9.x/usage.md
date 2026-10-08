Field Formatter Class adds a "Field Formatter Class" text setting to every field formatter (and field widget) so site builders can attach one or more CSS classes to a field's outer HTML wrapper straight from Manage display — no theme code required.

---

The module implements Drupal's field-formatter and field-widget third-party-settings hooks to inject a single `class` textfield into the gear-icon settings of *every* formatter and widget, for content types, users, taxonomy, and any other fieldable entity. Whatever you type is stored as a third-party setting (`field_formatter_class.class`) on the entity view display (or form display), so it travels with configuration export/import like any other display setting. At render time a `hook_preprocess_field()` (and a generic `hook_preprocess()`) reads that stored value, runs it through the token system (`clear => TRUE`), splits it on spaces, HTML-escapes each token, and appends the classes to the field template's wrapper `attributes`. Because the value passes through `Token::replace()`, you can use entity tokens (e.g. `[node:field_...]`) to build dynamic classes, and if the Token module is installed a token-browser link appears beside the setting. The settings summary shown on the Manage display row is extended (via `hook_field_formatter_settings_summary_alter()` / the widget equivalent) to print `Class: <value>`. It requires only core's `field` module, needs no per-field configuration to activate, defines no permissions or routes of its own, and ships a D7 migration so classes stored under the Drupal 7 version are carried forward. It is a lightweight styling helper, especially handy for CSS grid systems and jQuery plugins that key off wrapper classes.

---

- Add a CSS class to a single field's wrapper `<div>` from Manage display without touching Twig.
- Attach grid-system classes (e.g. `col-md-6`) to fields so they lay out in a CSS grid.
- Give a field a hook class that a jQuery plugin (slider, masonry, tabs) can target.
- Add multiple space-separated classes to one field wrapper at once.
- Style the same field differently per view mode (Teaser vs. Full) by setting a different class in each.
- Mark a field with a utility class like `text-center` or `visually-hidden` for quick styling.
- Add a JavaScript hook class used only by custom front-end behaviors.
- Apply a class to a field's *widget* wrapper on the Manage form tab to style the edit form.
- Build a dynamic class from an entity token, e.g. `status-[node:field_state]`, via Token replacement.
- Use the token browser link (when Token module is enabled) to discover available tokens for the field.
- Keep field-styling decisions in exportable configuration instead of hard-coded theme overrides.
- Deploy field wrapper classes between environments through config export/import.
- Confirm at a glance which class a field carries via the `Class: …` summary on the Manage display row.
- Add BEM-style block/element classes to fields to fit an existing design system.
- Target a field for print or email styling with a dedicated class.
- Namespace a field so component CSS/JS only affects that field's output.
- Add a class to fields on users, taxonomy terms, media, or any fieldable entity type.
- Give an image or media field a wrapper class for lightbox or lazy-load libraries.
- Add responsive helper classes (e.g. `d-none d-md-block`) to control field visibility by breakpoint.
- Prototype layout tweaks quickly during theming without a deployment cycle.
- Reuse a shared component class across many fields for consistent spacing.
- Carry legacy Drupal 7 field_formatter_class values forward via the bundled D7 migration.
- Let site builders (not just front-end developers) manage field wrapper classes safely (input is XSS-filtered/escaped).
- Add an animation trigger class read by scroll or intersection-observer scripts.
