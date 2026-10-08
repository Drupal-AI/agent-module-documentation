# Views Field Compare — agent index

Two Views *Global*-category filter plugins that compare two of the view's own fields. Depends on `views`.
No config schema, no permissions, no Drush, no settings form — configured entirely inside a View.

- **The two filter plugins (`field_comparison`, `field_contained`): what they offer, operators, how the SQL is built, and constraints** →
  [plugins/filters.md](plugins/filters.md)

Key facts:
- Registered in `views_field_compare.views.inc` (`hook_views_data`) on the `views` (Global) table:
  `field_comparison` (*Field comparison*) and `field_contained` (*Field contained*).
- Both are non-exposable (`canExpose()` = FALSE) and non-groupable; operands are selected from fields
  already in the display. Only click-sortable fields are offered as operands (Field contained additionally
  requires a multi-valued field for the right operand).
- Filters add raw `addWhereExpression()` clauses over resolved table aliases/columns (and, for
  `field_contained`, a reconstructed correlated sub-SELECT). No end-user input reaches the SQL.
