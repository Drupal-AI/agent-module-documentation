# USWDS Breakpoints (grid helper) — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). A **dependency** of the
Cards and Columns components, not a standalone content component. No settings page, no permissions, no
template of its own. Hooks in `src/Hook/UswdsParagraphComponentsBreakpointsHooks.php`.

## What it installs

- **`uswds_breakpoints` taxonomy vocabulary** + terms seeded by `hook_install()`
  (`.install` → `uswds_paragraph_components_breakpoints_install()`):
  - Enabled (status 1): `desktop`, `tablet`, `mobile`.
  - Disabled (status 0): `widescreen`, `desktop-lg`, `tablet-lg`, `mobile-lg`, `card-lg`, `card`.
  - Term names double as USWDS grid prefixes (`desktop:grid-col-4`, etc.); `mobile` → base `grid-col-N`.
- **`uswds_card_breakpoints`** paragraph type: `field_uswds_breakpoints` (term reference to the vocab)
  + `field_number_of_columns` (integer 1-12). Used as child rows inside card items.
- **`views.view.uswds_entity_references`** — supporting view (`uswds_entity_references`).

## Widget integration

- `#[Hook('field_widget_uswds_paragraph_components_paragraphs_form_alter')]`
  (`fieldWidgetUswdsParagraphComponentsParagraphsFormAlter`): for breakpoint sub-paragraph types
  (`uswds_card_breakpoints`, `uswds_2_column_breakpoints`, `uswds_3_column_breakpoints`) it
  (a) disables `field_uswds_breakpoints` when the widget setting `disable_breakpoints` is on, and
  (b) defaults each row's term from `form['#custom_tids'][delta]` (the enabled term ids the base
  widget `UswdsParagraphsBreakpoints::formMultipleElements()` collected).

Net effect: enabling this lets Cards/Columns auto-generate one grid row per enabled breakpoint, and
their templates turn `<term name> + <column count>` into responsive `grid-col-*` classes.
