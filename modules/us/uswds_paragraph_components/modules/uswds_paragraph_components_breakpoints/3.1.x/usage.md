Shared grid-helper submodule of USWDS Paragraph Components: supplies the responsive-breakpoint taxonomy and helper paragraph type that the Cards and Columns components use to build USWDS `grid-col-*` classes.

---

This is not a directly-usable component — it is a dependency of `uswds_paragraph_components_cards` and `uswds_paragraph_components_columns`. On install it creates a `uswds_breakpoints` taxonomy vocabulary and seeds its terms via `hook_install()` (`uswds_paragraph_components_breakpoints_install()`): `mobile`, `tablet`, `desktop` are created **enabled** (status 1) and `mobile-lg`, `tablet-lg`, `desktop-lg`, `widescreen`, `card`, `card-lg` are created **disabled** (status 0), so only the three main breakpoints are active by default. It also imports the `uswds_card_breakpoints` paragraph type (fields `field_uswds_breakpoints` → term reference, `field_number_of_columns` → integer) and a `uswds_entity_references` view. The base module's field widget (`UswdsParagraphsBreakpoints`) reads the enabled terms to pre-seed breakpoint rows, and this submodule's `hook_field_widget_uswds_paragraph_components_paragraphs_form_alter()` sets each breakpoint row's default term and honors the widget's `disable_breakpoints` setting. Card/column templates read the term name + column count from these rows to emit classes like `desktop:grid-col-4` (term `mobile` maps to the base `grid-col-N`).

---

- Provide the `uswds_breakpoints` taxonomy that Cards and Columns reference for responsive grids.
- Enable/disable which viewport breakpoints (mobile, tablet, desktop, widescreen, card…) are offered.
- Define per-breakpoint column counts for card groups and column layouts.
- Seed sensible default breakpoints (mobile/tablet/desktop enabled) on install.
- Reorder or re-weight breakpoint terms to change how grid rows appear in the editor.
- Add a custom breakpoint term (matching a USWDS grid prefix) for a bespoke layout.
- Satisfy the dependency required before enabling Cards or Columns.
- Let the USWDS widget auto-populate one grid row per enabled breakpoint on new paragraphs.
- Disable the breakpoints field per widget instance via the `disable_breakpoints` setting.
- Map the `mobile` breakpoint to the base (prefix-less) `grid-col-N` class.
- Support the `uswds_card_breakpoints` helper paragraph type used inside card items.
- Keep responsive-grid configuration data-driven (taxonomy) rather than hard-coded.
- Provide the `uswds_entity_references` view that ships with the breakpoints helper.
- Share one breakpoint taxonomy across both Cards and Columns for consistent responsive behavior.
- Change a breakpoint's weight to reorder the auto-seeded grid rows in the editor.
- Turn on additional breakpoints (e.g. widescreen, tablet-lg) that ship disabled by default.

