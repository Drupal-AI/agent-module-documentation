<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
No Markup strips the wrapper HTML around a rendered field (and optionally around a referenced entity) so a field outputs just its raw value — useful when mapping Drupal data into a component library.

---

The module adds a per-formatter **"Remove field markup"** third-party setting to every field on any entity's *Manage display* page (`hook_field_formatter_third_party_settings_form`). When enabled it swaps the field's theme suggestion to its own bare template `field--nomarkup.html.twig` (via `hook_theme_suggestions_field_alter`), which prints only the field's value(s) with no `field`/`label`/`item` wrappers. For multi-value fields it joins values with a configurable **separator** (default `|`, the `NoMarkupInterface::DEFAULT_SEPARATOR`). A third option appears only for the *Rendered entity* (`entity_reference_entity_view`) formatter on entity-reference fields: **"Remove markup on the referenced entity"**, which additionally renders the referenced entity through the bare `entity--nomarkup.html.twig` template. The choice is stored as a third-party setting on that field's formatter component in the `entity_view_display` config entity (`third_party_settings.nomarkup.enabled: true`, plus `separator` and `referenced_entity`). It also ships a Views **style** plugin (`nomarkup`) that renders rows with no additional markup (`views-view-nomarkup.html.twig`). There is no settings page (`configure: null`), no permission, and no dependency — it is a pure display-layer helper for headless/decoupled and component-driven theming.

---

- Output a field's raw value with no `<div class="field ...">` wrapper for a component library.
- Feed clean field values into a Twig component / design-system template.
- Remove label and item wrappers from a text field in a custom view mode.
- Join a multi-value field's values with a custom separator instead of markup.
- Change the multi-value separator from the default `|` to a comma or space.
- Render an entity-reference field's target entity with no wrapping markup.
- Strip markup from both the reference field and the referenced entity at once.
- Produce a bare string for a field used inside an aggregated/mapped template.
- Simplify markup for a field consumed by JavaScript on the page.
- Configure the behavior per view mode (e.g. clean output only in a "teaser_api" mode).
- Keep the default view mode's markup while stripping it in a headless view mode.
- Render a view's rows with no extra wrappers using the `nomarkup` Views style.
- Map field data to a front-end framework without fighting Drupal's default markup.
- Reduce DOM noise for fields injected into emails or exports.
- Store the setting in exported config (`third_party_settings.nomarkup.enabled: true`).
- Toggle markup removal per environment by overriding the display config.
- Avoid writing a custom formatter just to drop a field's wrapper HTML.
- Output an image or media field's rendered value without the field chrome.
- Present a single-value field as plain inline text.
- Combine with component libraries where the wrapper markup would break layout.
- Provide clean field output for a Layout Builder / Paragraphs component.
- Standardise stripped output across many fields by enabling the setting on each.
