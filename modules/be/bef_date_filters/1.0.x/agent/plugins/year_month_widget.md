<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Year-and-month range widget (`bef_year_month_between`)

The module's entire behavior. It is a Better Exposed Filters *filter widget* plugin — an instance of
BEF's `@BetterExposedFiltersFilterWidget` plugin type, not a new plugin type — that renders a Views
date **"Is between"** exposed filter as two dropdowns (Year, Month) and computes the underlying
date range for the visitor.

| | |
|---|---|
| Plugin id | `bef_year_month_between` |
| Label | "Year and month for date range" |
| Class | `Drupal\bef_date_filters\Plugin\better_exposed_filters\filter\YearMonthBetween` |
| Base | `Drupal\better_exposed_filters\Plugin\better_exposed_filters\filter\FilterWidgetBase` |
| Discovery | `src/Plugin/better_exposed_filters/filter/YearMonthBetween.php` |
| Options | none of its own (only BEF's inherited widget advanced settings) |

## When it is offered (`isApplicable`)

Returns TRUE only when the Views filter handler is a `Drupal\views\Plugin\views\filter\Date`
(or any handler with a non-empty `date_handler` property) **and** is not a grouped filter
(`!$filter->isAGroup()`). So it appears in the BEF widget dropdown only for date filters.
It does **not** itself check the operator, but the widget only makes sense with an operator that
exposes `min` and `max` elements — i.e. **"Is between" / "Is not between"** on the date filter.

## What it renders (`exposedFormAlter`)

Called on the exposed form. It locates the filter's element (handling the `<field_id>_wrapper`
wrapper from core issue 2625136), runs `parent::exposedFormAlter()`, then:

- attaches library `bef_date_filters/year-month-between` and adds class `bef-date-filter` to the form;
- adds `year_between` — `#type: select`, options `-- Year --` plus `range(date('Y'), date('Y') - 10)`
  (the current year through the ten prior years, 11 values, newest first);
- adds `month_between` — `#type: select`, options `-- Month --` plus `01`…`12`
  (translated long month names, translation context `Long month name`);
- pushes the filter's field id (underscores replaced with dashes) onto
  `drupalSettings.bef_date_filters.ids[]`;
- hides the filter's native `min` and `max` date inputs by adding the `visually-hidden` class and
  unsetting their `#title`. The min/max are kept in the DOM — the JS writes the actual submitted
  values into them.

The value the visitor selects in Year/Month is **not** what is submitted to Views. Year/Month only
drive the hidden `min`/`max` date inputs client-side; Views receives the normal `min`/`max` date-range
value and processes it through its standard `filter\Date` handler (parameterized query — no raw SQL
here). If JS is disabled the two selects have no effect and the hidden min/max stay empty.

## Range logic (`js/year-month-between.js`, behavior `befDateFilterYearMonthBetween`)

On `change` of either select the behavior sets ISO `YYYY-MM-DD` strings into the hidden `min`/`max`
(the max is the exclusive first day of the next period):

| Year | Month | `min` | `max` |
|---|---|---|---|
| set | set | `YYYY-MM-01` | first day of the following month (rolls the year over after December) |
| set | empty | `YYYY-01-01` | `YYYY+1-01-01` (whole year) |
| empty | set | current year assumed for `min` = `CUR-MM-01` | first day of following month |
| empty | empty | `''` | `''` (cleared) |

Selectors are `[data-drupal-selector=edit-<fieldId>-year-between|-month-between|-min|-max]`; guarded
with `core/once` so it binds a filter only once.

## Enable it on a view

No admin settings page ships with this module — you configure it inside the view.

1. Add a **date** filter to the view (an entity date/created/changed field or a datetime field).
2. Set its operator to **Is between** and expose it.
3. On the display, set **Exposed form → Exposed form style = Better Exposed Filters** and open its settings.
4. Under that filter, choose the widget **"Year and month for date range"**.

In config this is stored by BEF on the display, not by this module — under
`display_options.exposed_form.options.bef.filter.<filter_id>` with `plugin_id: bef_year_month_between`
(the same structure BEF uses for every widget). Example fragment of a view's YAML:

```yaml
display:
  default:
    display_options:
      exposed_form:
        type: bef
        options:
          bef:
            filter:
              created:            # the exposed filter's identifier
                plugin_id: bef_year_month_between
```

## Config schema

This module ships **no** `config/schema` and defines no widget options, so it adds nothing to the
BEF exposed-form schema. `provides_config_schema` is false.

## Caching (operational note)

Exposed input varies the result set, so a display using this filter needs the right cache contexts
(BEF/Views handle the URL argument). A range that includes the current period is time-dependent —
the `empty year / set month` branch and any "current year" default resolve against `date('Y')` /
`new Date()` at request time — so a page cached for a long `max-age` can show a stale idea of the
current year; set `max-age` accordingly where "now" matters.
