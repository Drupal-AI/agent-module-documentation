Provides a Drupal field type that stores a CSS size as a number plus a CSS length unit (e.g. `20px`, `1.5rem`, `100%`).

---

CSS Size Field adds a `css_size` field type whose value is two properties — `number` (a decimal, validated by a numeric regex and stored as a `numeric(19,6)` column) and `unit` (one of the standard CSS length units: `cm`, `mm`, `Q`, `in`, `pc`, `pt`, `px`, `em`, `rem`, `vw`, `vh`, `%`). The default widget shows a number input and a unit `<select>`; a field can be configured with a default unit and a restricted list of allowed units (when only one unit is allowed the selector collapses to a suffix label). The default formatter outputs the two properties concatenated into a ready-to-use CSS length string. The module also exposes a reusable `css_size` render/form element and a `SizeUnit` value-object class (`getLabels()`, `getAllUnits()`, `assertExists()`) so the same size input can be embedded in custom forms and config forms independent of the Field API. It has no dependencies beyond Drupal core, defines no routes, permissions, services or admin settings page, and ships only a small widget stylesheet.

---

- Add a "CSS Size" field to a content type to let editors enter a length + unit (e.g. a max-width or spacing value).
- Store per-node layout dimensions (banner height, sidebar width) that a template or CSS var consumes.
- Capture a font-size override on a paragraph or block with a proper unit selector instead of a free-text string.
- Let editors set a margin/padding value with a constrained unit list (only `px` and `rem`, say).
- Restrict a field to a single unit (e.g. `%`) so the widget renders as a number input with a fixed suffix.
- Provide a default unit (e.g. `px`) so new field values start pre-populated.
- Feed a stored `20px`-style value straight into an inline `style` attribute or a CSS custom property in a template.
- Model responsive breakpoint widths using viewport units (`vw`, `vh`).
- Record print-oriented measurements (`cm`, `mm`, `in`, `pt`, `pc`, `Q`) for PDF/print theming.
- Give a media or image field a companion "display width" size field.
- Build a design-token style entry form where each token is a validated size value.
- Add a size field to a custom config entity via the standard Field API.
- Reuse the `css_size` form element in a custom configuration form to collect a size without creating a field.
- Reuse the `css_size` element in a custom module's build form with a `#default_value` of `['number' => '1.90', 'unit' => 'px']`.
- Limit a custom `css_size` element to specific units with `#available_units`.
- Validate that a user-entered number is a valid decimal (positive, negative, or fractional) before saving.
- Call `SizeUnit::getLabels()` to render your own unit dropdown consistent with the field.
- Call `SizeUnit::assertExists($unit)` to guard a unit value coming from an import or API.
- Enumerate all supported units programmatically with `SizeUnit::getAllUnits()`.
- Present spacing/typography controls in a component builder where each control is a size + unit.
- Store slider or gauge dimensions that theme code renders as CSS.
- Keep numeric value and unit as separate, queryable columns (rather than parsing a combined string).
- Export/import size settings cleanly via config, thanks to the provided config schema.
- Show a size value on the rendered entity as a plain CSS string using the default formatter.
