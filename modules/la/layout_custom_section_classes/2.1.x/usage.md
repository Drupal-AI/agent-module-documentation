<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Custom Section Classes lets editors add HTML attributes — ID, CSS classes (free-text or from a predefined list), inline styles, and `data-*` attributes — to Layout Builder **sections** and to each **region** within a section, from the section-configuration form.

---

The module extends Layout Builder's "Configure section" form (via
`hook_form_layout_builder_configure_section_alter()`) with fields for a section's **ID**
(`custom_id`), **classes** (`custom_classes`), a **checkbox list of predefined classes**
(`custom_class_choose`), **inline styles** (`custom_styles`), and **`data-*` attributes**
(`custom_data_attributes`), plus the same set per **region** (`regions.<id>.region_*`). A global
settings form (route `layout_custom_section_classes.settings`, path
`/admin/config/content/layout-builder-section-attributes`, config
`layout_custom_section_classes.settings`) controls which of those attribute types are offered
(`allowed_section_attributes` / `allowed_section_region_attributes`, each with `id`, `class`,
`class_list`, `style`, `data` booleans), defines the **predefined class list** (`class_list`,
newline-separated, optional `class|Friendly name` syntax), and a **`relax_css_validation`**
toggle. Values are validated (CSS identifiers via `Html::cleanCssIdentifier()`, inline CSS via
the bundled `neilime/php-css-lint`, `data-*` names must start with `data-`) and applied at render
time by `hook_preprocess_layout()`, which pushes them onto the layout's `attributes` /
`region_attributes`. If the contrib **Token** module is installed, the free-text attribute fields
support tokens (with a token browser). Three permissions gate the settings form, section
attributes, and region attributes respectively. **Important:** the chosen layout template must
actually print `{{ attributes }}` (and `{{ region_attributes.REGION }}`) for the classes to appear.

---

- Add a background/utility CSS class to a specific Layout Builder section.
- Give a section a unique HTML `id` so it can be linked to with an anchor.
- Let editors pick from a curated list of theme classes (a "class list") instead of free-typing.
- Add inline CSS styles to a section (e.g. a one-off background colour).
- Attach `data-*` attributes to a section for JavaScript or CSS hooks.
- Apply classes/attributes to an individual **region** inside a section, not just the whole section.
- Constrain editors to only set classes (disable id/style/data) via the global settings.
- Predefine friendly-named classes (`bg-dark|Dark background`) for a nicer editor dropdown.
- Add a `data-aos="fade-up"` style animation hook to a section for a JS library.
- Namespace a section with an id used by anchor navigation or smooth-scroll.
- Add spacing/utility classes (`py-5`, `container-fluid`) to layout sections.
- Use tokens (with the Token module) so a section id/class derives from the host entity.
- Enforce valid CSS class names, or relax validation to allow underscores/uppercase.
- Add a `style="--accent: #f00"` CSS custom property to a section for themed components.
- Give each region in a two-column section its own alignment class.
- Add a `role`/`data-*` hook to a region for accessibility or analytics.
- Apply a print-only class to a section via editor configuration.
- Reproduce a design system's section modifiers without writing custom code per layout.
- Let content teams tweak section styling within guardrails set by site builders.
- Add JS-targeted `data-*` flags to specific regions for interactive widgets.
- Standardise section styling options across many landing pages.
- Add a scroll-snap or grid utility class to a section wrapper.
- Restrict who can edit section vs region attributes using the three permissions.
