# Theming Active Filters

## Theme hooks & templates

| Hook | Template | Renders |
|---|---|---|
| `active_filters` | `active-filters.html.twig` | The whole (ungrouped) chip list: `<dl>` with title + `active_filters`, optional clear button. |
| `active_filters_grouped` | `active-filters-grouped.html.twig` | Extends the above; groups chips under each exposed filter. |
| `active_filter` | `active-filter.html.twig` | One chip: `<dd><button>{{ label }}</button></dd>`. |
| `active_filter_group` | `active-filter-group.html.twig` | A group's label row. |

Variables (see the `template_preprocess_*` in `active_filters.module`): `title`, `clear_text`,
`active_filters`, `configuration`, `view`, plus prebuilt `attributes` / `title_attributes` /
`clear_attributes` (`Attribute` objects). All user-derived values (labels, values) pass through Twig
autoescaping and `Attribute` — safe by default.

## Theme suggestions (from `hook_theme_suggestions_alter`)

Container hooks get: `__<view_id>`, `__<view_id>__<display>`.
Chip/group hooks additionally get: `__<view_id>`, `__<view_id>__<display>`, `__<name>`,
`__<name>__<value>`, `__<view_id>__<name>`, `__<view_id>__<display>__<name>`,
`__<view_id>__<name>__<value>`, `__<view_id>__<display>__<name>__<value>` (`<name>` = exposed filter
identifier, `<value>` = raw value). So e.g. `active-filter__frontpage__category__news.html.twig`.

## Data attributes (required for removal JS)

The remove behavior (`js/active-filters.js`) keys off these — keep them if you override templates:

- Container: `data-active-filters`, `data-active-filters-clearable` (when a clear button exists).
- Clear button: `data-active-filters-clear-all`.
- Chip button: `data-active-filter-name`, `data-active-filter-value`, and
  `data-active-filter-removable` (only on removable chips).

## Removal behavior & custom widgets

Clicking a removable chip finds the matching exposed input under the nearest `.view` /
`.views-element-container` / `main`, unsets it (checkbox/radio/select/multiselect/text handled), and
resubmits the exposed form. Clear-all removes every removable chip then submits once.

For JS-enhanced widgets that the built-in logic can't reset, attach an `activeFilterRemove` method to
the input element; Active Filters calls it with the triggering chip button instead of its default
logic:

```js
Drupal.behaviors.myWidgetRemove = {
  attach: (context) => {
    once('af-remove', '[name="my_input"]', context).forEach((input) => {
      input.activeFilterRemove = (chipButton) => { /* reset widget */ };
    });
  },
};
```

## CSS/JS libraries

- `active_filters/css` — minimal chip styling (`css/active-filters.css`), attached automatically.
- `active_filters/js` — attached only when at least one removable chip is present.
