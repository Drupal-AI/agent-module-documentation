<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Section Classes lets a layout definition declare selectable CSS class options so that, in Layout Builder, each section gets dropdowns for choosing classes (and region classes / attributes) that are applied to the rendered section wrapper.

---

The module is a thin, developer-facing enhancement to core Layout Builder / Layout Discovery. It ships no UI of its own; instead, via `hook_layout_alter()`, it swaps the plugin class of any layout whose definition (in a `*.layouts.yml`) uses the default `LayoutDefault` class **and** declares a `classes:` key, replacing it with `Drupal\layout_section_classes\ClassyLayout`. `ClassyLayout` extends `LayoutDefault` and adds a configuration form: for each group under `classes:` it renders a `select` (single or `multiple`) built from that group's `options`, honoring `required`, `default`, `label`, and `description`. The chosen values are stored in the section's layout configuration under `additional.classes.<group>` and, at render time, `ClassyLayout::build()` appends them to the section wrapper's `#attributes['class']`. A class group can also define `region_classes` (map a chosen class to extra classes on specific regions) and `attributes` (map a chosen class to arbitrary HTML attributes like `data-*` on the section). So a themer defines the allowed classes once in YAML, and site builders pick from friendly labels per section in the Layout Builder UI — no free-text class entry, no custom layout plugin per style. It requires `layout_discovery`, has no configure route, permission, service, or Drush command, and defines no config schema of its own (values live inside Layout Builder's section config).

---

- Offer site builders a "Background style" dropdown on each Layout Builder section.
- Let editors pick spacing utility classes (e.g. top/bottom padding) per section from a select.
- Apply a design-system CSS class to a section wrapper without free-text class fields.
- Provide a curated, labeled list of allowed classes so editors can't type arbitrary CSS.
- Add multiple classes at once to a section via a multi-select class group.
- Set a required style choice with a sensible default on every section of a layout.
- Map a chosen style to extra classes on a specific region using `region_classes`.
- Add a `data-*` attribute to a section when a particular style is selected (via `attributes`).
- Turn an existing custom layout into a "classy" one just by adding a `classes:` key to its YAML.
- Give a theme's layouts brand-specific background/border/spacing options.
- Keep section styling in config (deployable) rather than inline styles.
- Let content teams choose "Light" vs "Dark" section themes from a dropdown.
- Provide alignment or width utility classes per section.
- Standardize section variants across a site through YAML-declared options.
- Avoid writing a separate layout plugin for each visual variant of a section.
- Combine several independent class groups (e.g. background + spacing) on one section.
- Expose a "container width" option that also toggles a region class.
- Add animation or scroll-behavior data attributes conditionally per section.
- Let a themer control which classes are available while site builders control which are used.
- Apply utility framework classes (Tailwind/Bootstrap-style) to Layout Builder sections.
- Offer an optional "- Select -" empty option so a section can have no extra class.
- Drive section styling from a component library's class vocabulary.
- Migrate hard-coded section wrappers to a configurable, labeled class picker.
