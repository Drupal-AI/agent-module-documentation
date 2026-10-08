<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a Views date filter with `date_filter`

There is nothing to configure globally (`configure: null`, no `config/install/*`). All state
lives inside a **view config entity**.

## Admin UI

*Structure → Views → edit view → Filter criteria → Add* a date field
(e.g. **Authored on** = `created`, or any Date/time field), then in the filter modal:

1. **Filter type** (radios added by `DateBase::buildOptionsForm()`) — `Date` or `Date and time`.
   Replaces core's *Value type: A date in any machine readable format / An offset from the
   current time* radios. Disabled with the note *"This is a date-only field."* when the
   Date/time field's `datetime_type` is `date`.
2. **Operator** — core numeric operators minus `regular_expression`
   (`=`, `!=`, `<`, `<=`, `>`, `>=`, `between`, `not between`, `empty`, `not empty`).
3. **Value** — in the Views UI this is still a text box; its description now reads
   *"A date in any machine readable format (CCYY-MM-DD HH:MM:SS is preferred) or an offset
   from the current time such as `+1 day` or `-2 hours -30 minutes`."* For `between` the two
   boxes are labelled **from** / **to** (core says min / max).
4. **Expose this filter** — the exposed settings form no longer offers
   `placeholder` / `min_placeholder` / `max_placeholder` (unset in `buildExposeForm()` and
   `defineOptions()`).

The **exposed** (front-end) form is where the module pays off: `DateBase::valueForm()` swaps
the text boxes for `#type => 'date'` render elements —
`<input type="date">`, plus `<input type="time" step="1">` when *Filter type* is
`Date and time`. An admin default that is an offset (`-1 month`) is parsed and shown as a
concrete date.

## Config shape (what to write / read with drush)

```yaml
# views.view.<id>: display.<display>.display_options.filters.<key>
created:
  id: created
  table: node_field_data
  field: created
  entity_type: node
  entity_field: created
  plugin_id: date          # unchanged — date_filter never adds a plugin id
  operator: between
  value: { min: '', max: '', value: '' }
  exposed: true
  expose:
    operator_id: created_op
    label: 'Authored on'
    identifier: created_range
    required: false
  type: datetime           # <-- date_filter's option: 'date' | 'datetime'
```

- For a Date/time **field** the filter is `plugin_id: datetime`,
  `table: node__field_<name>`, `field: field_<name>_value`.
- `type` sits **next to** `operator`/`value`, not inside `value`. Core's own
  `value.type: date|offset` is a different key; `date_filter` never writes it.
- Defaults: `type` defaults to `date` (`DateBase::defineOptions()`).

Read it:

```bash
drush config:get views.view.myview display.default.display_options.filters.created
```

Write it (no UI needed) — this is the reliable way to set the option:

```bash
drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("myview");
  $d = $v->get("display");
  $f = &$d["default"]["display_options"]["filters"]["created"];
  $f["operator"] = "between";
  $f["type"] = "datetime";      // date_filter Filter type
  $f["exposed"] = TRUE;
  $f["expose"]["identifier"] = "created_range";
  $f["expose"]["operator_id"] = "created_op";
  $f["expose"]["label"] = "Authored on";
  $v->set("display", $d)->save();
'
drush cr
```

## Exposed URL parameters

Because the value element is a nested `date` (+ `time`) group, exposed input arrives as
`?<identifier>[date]=2026-07-24` (single-value operators) or
`?<identifier>[min][date]=…&<identifier>[max][date]=…` for `between`, with `[time]` added when
`type: datetime`. `DateBase::acceptExposedInput()` accepts the filter as soon as **one** of
min/max carries a `date` key, so a half-filled range still filters.

## Gotchas

- Enabling the module does **not** rewrite existing views; already-saved filters keep working
  and simply gain the new UI.
- If another module also implements `hook_views_plugins_filter_alter()` on `date`/`datetime`
  (e.g. `views_year_filter`), the last implementation wins and `date_filter`'s classes may not
  be active — see [../extend/plugin-swap.md](../extend/plugin-swap.md). The `type` key you
  wrote into config survives either way.
- `views.filter.datetime_proper` in `config/schema/date_filter.views.schema.yml` is unused.
