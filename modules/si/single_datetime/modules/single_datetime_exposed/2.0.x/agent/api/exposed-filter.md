<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it attaches the picker to exposed Views filters

The whole submodule is `single_datetime_exposed.module`: one hook, no config, no plugin, no
service, no permissions. Enabling the module is the entire setup.

## The hook

`single_datetime_exposed_form_views_exposed_form_alter(&$form, FormStateInterface $form_state, $form_id)`
— an implementation of `hook_form_BASE_FORM_ID_alter()` for the `views_exposed_form` base form.

It runs on any View's exposed form (page, block, attachment, …) but **skips Views live-preview**
(`if ($view->preview === NULL)`).

## Which exposed filters it enhances

It loops over `$view->getHandlers('filter')` and enhances a filter **only when all** of:

- `$filter['exposed']` is truthy (the filter is exposed), and
- `$filter['plugin_id'] === 'date'` **or** `$filter['plugin_id'] === 'search_api_date'`, and
- `$filter['value']['type'] === 'date'` — i.e. an **absolute-date** filter, not a relative/offset one.

So a Views generic Date filter (e.g. an exposed *Authored on* / *Updated* filter, or a datetime
field surfaced through the `date` filter plugin) and a Search API date filter are eligible; a
relative-date/offset exposed filter is not.

## What it does to a matching filter

The picker attributes come from `\Drupal\single_datetime\AttributeHelper::defaultWidget()`
(`data-hour-format`, `data-first-day`, `data-allow-times`, `data-single-date-time`,
`data-datetimepicker-theme`, …).

- **`between` / `not between`** operator → attributes applied to **both** `$form[$id]['min']` and
  `$form[$id]['max']`, and their titles are relabelled `… ( From )` / `… ( To )`. As a usability
  fix, if the user submits only `min` and leaves `max` empty, it sets `max = min + 86400s` so the
  range filter still returns results.
- **any other operator** → attributes applied to the single `$form[$id]` input.

If at least one matching filter was found, it attaches the library:
`$form['#attached']['library'][] = 'single_datetime/datetimepicker';`

## Making an exposed filter eligible (what to configure on the View)

There is nothing to configure on this module. To get the picker you configure the **View**:

1. Add a filter on a date/datetime field (or on the node *Authored on* / *Changed* date), using a
   handler whose Views `plugin_id` is `date` (or `search_api_date` for Search API views).
2. **Expose** the filter.
3. Ensure the exposed value is an **absolute date** (`value.type: date`) rather than an offset.

The resulting config lives in `views.view.<id>` at
`display.<display>.display_options.filters.<key>` with `exposed: true`, `plugin_id: date`
(or `search_api_date`) and `value.type: date`. Those three keys are exactly what the module tests.

## Customising

The README suggests copying this form alter into your own module if you need different behaviour
(e.g. only some views, or different picker settings) — there are no hooks or settings to override.
