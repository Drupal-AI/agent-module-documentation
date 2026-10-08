Views Striping adds `odd`/`even` CSS classes to the rows of a table-style View so a theme can
zebra-stripe them, without writing a template preprocessor. You enable its "Row striping" display
extender in the global Views advanced settings, then per view pick a striping type in the table
Format settings.

---

Under the hood the module ships a Views display extender (`views_striping`) plus a small plugin
type, `ViewsStripingType`, that decides which class each row gets. Two strategies come built in:
`alternating` flips `odd`/`even` on every row, and `field_value` keeps the same class until a
chosen field's rendered value changes between adjacent rows (useful for grouping visually by a
sorted column). Classes are added at preprocess time via `Attribute::addClass()` on the table and
on the contrib Views Aggregator results table style — those are the only two supported styles, and
you supply the CSS for `.odd`/`.even` yourself. It carries no config, permissions, drush commands,
or routes, and other modules can register additional striping strategies as plugins or retarget the
built-ins through `hook_views_striping_type_info_alter`.

---

- Zebra-stripe a table View's rows with alternating `odd`/`even` classes.
- Improve readability of a long table listing.
- Turn on row striping without editing a Twig template.
- Enable the "Row striping" display extender site-wide in Views advanced settings.
- Choose a striping type per view display in the table Format settings.
- Flip the stripe every row with the `alternating` type.
- Keep one stripe until a column's value changes, using the `field_value` type.
- Visually group adjacent rows that share the same sorted-column value.
- Stripe a Views Aggregator results table the same way as a core table.
- Style alternating rows purely from theme CSS on `.odd`/`.even`.
- Apply consistent row striping across several views.
- Prototype row styling from the Views UI instead of in code.
- Add a custom striping strategy as a `ViewsStripingType` plugin.
- Stripe every Nth row by writing a small plugin.
- Add a class derived from a field's value via a custom plugin.
- Retarget a built-in striping type to your own class with the alter hook.
- Give a design system's table treatment stable row classes to hook onto.
- Support a site still on Drupal 8 through 11 with one presentational module.
- Remove striping cleanly by unticking the display extender before uninstall.
- Choose different striping strategies for different table views on the same site.
