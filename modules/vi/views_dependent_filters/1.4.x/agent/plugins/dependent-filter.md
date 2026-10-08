<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Global: Dependent filter" handler

Machine id: **`views_dependent_filter`** (registered on the `views` table by
`views_dependent_filters_views_data_alter()`; UI label "Dependent filter"). Class:
`Drupal\views_dependent_filters\Plugin\views\filter\ViewsDependentFilter`.

It is a **fake filter**: `query()` does nothing, `acceptExposedInput()` returns TRUE (so the
view never filters on it), and it is always exposed. Its only job is to attach an
`#after_build` callback to the exposed form that sets Form API `#states` on the dependent
filter elements, showing/hiding them based on the controller filter's current value.

## Placement rule (important)

Order in the view's filter list decides roles:
- The controller filter must come **before** the Dependent filter handler.
- The dependent filter(s) must come **after** it.

So the order is: **controller filter → Dependent filter handler → dependent filter(s)**. Use
one handler per controller; add several handlers if several filters each control their own
dependents.

## Configure in the Views UI

Add filter → *Global: Dependent filter*. Two settings screens:

1. **Extra options** (`buildExtraOptionsForm`): pick the **Controller filter** (radios) — only
   exposed filters earlier in the order are offered.
2. **Options** (`buildOptionsForm`):
   - **Condition mode** (`condition`): `values` ("Filter is set to specific values") or
     `not_empty` ("Filter is selected / not empty").
   - **Controller values** (`controller_values`): shown only for `condition = values`. The
     module borrows the controller filter's own value widget, so you pick from its real
     options. (For a Facets controller it's a comma-separated raw-values textfield instead.)
   - **Dependent filters** (`dependent_filters`): checkboxes of the exposed filters that come
     after this handler; the chosen ones are shown only when the condition is met.
   - **Negate** (`negate`): invert — hide the dependents when the condition is met.

## Config shape written to `views.view.<id>`

Inside `display.<display>.display_options.filters`, the handler looks like:

```yaml
views_dependent_filter:
  id: views_dependent_filter
  table: views
  field: views_dependent_filter
  plugin_id: views_dependent_filter
  exposed: true
  condition: values          # or 'not_empty'
  controller_filter: type    # the id of the earlier exposed filter
  controller_values:         # required options-checkboxes crud filtered out at runtime
    article: article
  dependent_filters:
    title: title             # ids of later exposed filters to show/hide
  negate: false
```

Programmatic creation (drush php:eval), added to an existing view's filters between the
controller (`type`) and dependent (`title`):

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = &$view->getDisplay('default');
$filters = $display['display_options']['filters'];
// Insert the handler after 'type' and before 'title' (array order = filter order).
$new = [];
foreach ($filters as $k => $v) {
  $new[$k] = $v;
  if ($k === 'type') {
    $new['views_dependent_filter'] = [
      'id' => 'views_dependent_filter', 'table' => 'views',
      'field' => 'views_dependent_filter', 'plugin_id' => 'views_dependent_filter',
      'exposed' => TRUE, 'condition' => 'values',
      'controller_filter' => 'type', 'controller_values' => ['article' => 'article'],
      'dependent_filters' => ['title' => 'title'], 'negate' => FALSE,
    ];
  }
}
$display['display_options']['filters'] = $new;
$view->save();
```

## Runtime behaviour

`views_dependent_filters_exposed_form_after_build()` builds a `#states` array per dependent
element from the controller widget type:
- `textfield` → `filled`
- `checkboxes` → `checked` for each triggering value
- `radios` / single `select` → `value` = each triggering value
- multi `select` → OR-list of values (works around core issue 1149078)

Unsupported widget types raise a warning message. When `condition = not_empty`, *any*
controller value triggers visibility. The `negate` option flips `visible` to `invisible`.
Hidden dependents are ignored on submit, so they don't constrain the result set.

## Compatibility

Works with the standard Views exposed form and with **Better Exposed Filters**. **Facets**
controllers are supported via a raw comma-separated values textfield (facet options only exist
after the search query runs).
