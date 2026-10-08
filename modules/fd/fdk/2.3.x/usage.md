<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Display Kit adds a per-display "Field Display Kit Settings" section to every field's formatter so you can fine-tune the field's label, wrapper elements, classes, attributes, item linking, and delimiter without writing a custom formatter or template.

---

Field Display Kit (FDK) hooks into the field formatter third-party settings (`hook_field_formatter_third_party_settings_form`) so that on each field's Manage display formatter you gain controls to: override the field label text; choose the HTML element for the label, the whole-field wrapper, and each individual field item (from a select list — `div`, `span`, `p`, `h1`–`h6`, `strong`, a link `a`, or a validated custom tag); add free-form CSS classes and `attribute|value` attribute lines (tokens supported when the Token module is enabled); wrap each field item in a link with a token-aware `href`; force the field wrapper to render even when the field has a single value; and add a comma delimiter between items with an optional "and" before the last one. These settings are stored as third-party settings on the entity view display (config schema `field.formatter.third_party.fdk`) and are applied by `fdk_preprocess_field()` together with FDK's own `field.html.twig`, which the module swaps in for core's copy through `hook_theme_registry_alter` — but only when the field template still comes from core, so genuine theme overrides keep precedence. Because of that swap, a theme that overrides `field.html.twig` must base its override on FDK's version; the module ships a read-only report at `/admin/reports/fdk` (permission `administer site configuration`) that scans all active themes and lists field templates missing FDK's variables. FDK has no settings form, no permissions of its own, and no entities; it works for fields rendered normally and through Layout Builder.

---

- Change a field's label text for one specific view mode without affecting other displays.
- Render a field label as an `h2`, `h3`, `span`, or any other element instead of the default `div`.
- Wrap an entire field's output in a custom HTML element with your own classes and attributes.
- Wrap each individual field item value in a chosen element (e.g. `<span>`, `<strong>`, `<p>`).
- Turn every value of a field into a link, building the destination with tokens such as `[node:url]`.
- Add CSS classes to a field wrapper, label, or item wrapper for targeted styling.
- Add arbitrary HTML attributes (one `attribute|value` per line) to a field, item, or label wrapper.
- Use tokens inside attribute values (for example a `data-*` attribute built from an entity token).
- Display a comma-separated list of multi-value field items with an "and" before the last item.
- Force a field's wrapper element to appear even when the field only has a single value.
- Give the same field different markup in the teaser view versus the full view mode.
- Style a taxonomy or entity-reference field's terms as inline linked chips without a custom formatter.
- Add semantic heading tags around field labels to improve document outline / accessibility.
- Apply per-item wrapper markup to fields displayed inside a Layout Builder layout.
- Avoid writing a bespoke Twig template just to tweak a field's surrounding markup.
- Build a "Name and title" style output by overriding a field's label and wrapping its value.
- Add microdata / schema.org attributes to field output via the attributes textarea.
- Check which of your active themes' field templates are incompatible with FDK via `/admin/reports/fdk`.
- Migrate a theme's field.html.twig override to FDK's variables so FDK settings take effect site-wide.
- Configure field markup entirely from the admin UI so it travels with exported configuration.
- Prototype field markup changes quickly without a theme deploy.
- Add a wrapper `<a>` around image or media field items using a token-built link href.
- Keep field markup adjustments in configuration (per display) rather than in theme templates.
- Standardise field wrapper elements and classes across many bundles from the display screens.
