<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Pattern" Views **style** plugin so a View's result set is rendered through a UI Patterns component (pattern), mapping the group title and the rendered rows onto the pattern's slots/fields.

---

The module registers a single Views style plugin `pattern` (`Pattern`, extends
`StylePluginBase`, `usesRowPlugin = TRUE`) available under a display's **Format** setting. Its
options form is built from UI Patterns' `PatternDisplayFormTrait`: you choose a pattern, a variant,
and map source fields to pattern destinations. At render time each Views group is turned into a
pattern render element — `#options['pattern']`, `variant`, a `PatternContext` (`views_style`) with
the view id/display/storage, and a `fields` array populated from the mapping (source `title` →
the group title or view title; source `rows` → the group's rendered rows). If the optional
`ui_patterns_settings` module is enabled, per-pattern settings are preprocessed and merged in. A
companion UI Patterns **source** plugin `view_style` (`ViewStyleSource`) exposes exactly two source
fields, `title` and `rows`, that the mapping UI offers. Rendering goes through the
`view--pattern.html.twig` template, which calls Twig's `pattern()` function with the assembled
settings. There is no config UI, no permissions, and no Drush; an `hook_update_N` (update 9101)
migrates old pattern-style option structures (variant + mapping) to the current shape. Note this
1.x branch targets the **UI Patterns 1.x** API.

---

- Render a View's rows with a reusable UI Patterns component instead of a core Views style.
- Map the View title into a pattern's heading/title slot.
- Map the rendered View rows into a pattern's main content slot.
- Pick a pattern variant per View display.
- Set per-pattern settings (when `ui_patterns_settings` is installed) on a View.
- Present a listing (cards grid, slider, tabs) defined once as a component across many Views.
- Keep Views markup consistent with the rest of a component-based (SDC/UI Patterns) design system.
- Build a "featured items" block View that outputs a design-system component.
- Reuse a themer-authored pattern for search results, catalog listings, or teasers.
- Swap the presentation of a View by changing only the selected pattern/variant.
- Pass Views context (view id, current display, view storage) into a pattern via `PatternContext`.
- Avoid writing a bespoke `views-view--*.html.twig` for each styled listing.
- Combine with row plugins (fields or entity rows) since the style uses a row plugin.
- Hide unmapped sources with the `_hidden` destination in the mapping form.
- Give site builders a dropdown of components to style any View.
- Migrate legacy pattern-style Views config automatically via the provided update hook.
- Standardise grouped Views output (each group rendered as its own pattern instance).
- Let a design system's grid/list components drive Views listings without theme overrides.
- Prototype listing layouts quickly by pointing a View at different patterns.
- Bridge UI Patterns components and Views without custom code.
