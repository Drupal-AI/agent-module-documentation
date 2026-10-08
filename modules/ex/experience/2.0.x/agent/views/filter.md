<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration (experience filter)

Files: `experience.views.inc`, `src/Plugin/views/filter/ExperienceFilter.php`, `config/schema/experience.views.filter.yml`. Requires core Views.

## Views data

`experience_field_views_data()` implements `hook_field_views_data()`. It starts from `views_field_default_views_data($field_storage)` and, for the field's `<field>_value` column, sets both `filter']['id']` and `argument']['id']` to `experience`. (Only a filter plugin ships with `@ViewsFilter("experience")`; there is no matching `@ViewsArgument("experience")` class in this release.)

## Filter plugin (`ExperienceFilter`)

`ExperienceFilter extends NumericFilter implements ContainerFactoryPluginInterface`, `@ViewsFilter("experience")`.

- **Extra options** (`hasExtraOptions()` / `buildExtraOptionsForm()` / `defineOptions()`): `label_position` (`above`, default), `include_fresher` (0), `year_start` (0), `year_end` (30) — same UI as the field settings; these control how the value form's selects are built.
- **Operators**: inherits `NumericFilter::operators()` but removes `regular_expression`.
- **Value form** (`valueForm()`): reuses the year/month select widget (classes `.year-entry` / `.month-entry`, `container-inline` fieldset) for single-value operators, plus `min`/`max` textfields for the two-value (between) operators; attaches library `experience/drupal.experience`. Handles both admin-config and exposed-filter contexts.
- **Value conversion**: `valueSubmit()`, `getFilterValue()` and `acceptExposedInput()` convert submitted `year`/`month` (or `fresher`) into the stored month integer (`year*12 + month`, `fresher`→0, both empty→NULL) before it reaches the query.
- **Query** (`opSimple()`): when the value is not NULL, `$this->query->addWhere($group, $field, $this->value['value'], $this->operator)` — a parameterized numeric comparison via the Views query builder.
- **Admin summary**: `valueFormatter()` / `adminSummary()` format the stored integer back to "X Year(s) Y Month(s)" / "Fresher" for the filter summary line.

## Config schema

`config/schema/experience.views.filter.yml` declares `views.filter.experience` (`type: views_filter`) and `views.filter_value.experience` (mapping of `min` / `max` / `value` strings). The extra options (`label_position`, `include_fresher`, `year_start`, `year_end`) inherit the base `views_filter` schema.
