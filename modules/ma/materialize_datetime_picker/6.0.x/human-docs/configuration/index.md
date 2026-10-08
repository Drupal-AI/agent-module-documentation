# Configuration

There are two levels of configuration: the **per‑field widget settings** (set on a
field's *Manage form display*, and the ones you will use most) and a **site‑wide
config form** that provides global defaults and per‑field‑ID overrides.

## Apply and configure the widget on a field

1. Go to **Structure → *(content type)* → Manage form display**.
2. For a **date** or **datetime** field, choose **Materialize DateTime Picker** as
   the widget.
3. Click the field's gear icon to open its settings and set:

   - **Hours format** — 12‑hour or 24‑hour time entry.
   - **Minutes granularity** — the step for the minute picker (for example 5, 10,
     15, 30, or 60 minutes).
   - **Disabled weekdays** — days of the week the calendar will not allow (for
     example weekends).
   - **Start of week** — which day the week begins on in the calendar.
   - **Disabled dates** — a comma‑separated list of specific dates in
     `YYYY-MM-DD` format to block out (holidays, blackout days).

4. Save the form display. The widget stores the picked value in the correct
   timezone and formats it for date‑only or date‑and‑time storage automatically.

The widget works for both date and datetime fields, is responsive, and localises
the date and time pop‑ups.

## Site‑wide defaults

A global config form lets you set defaults and per‑field overrides in one place:

1. Go to **Configuration → Materialize → DateTime Picker Config**
   (`/admin/config/materialize/datetime_picker_config`). This route requires the
   **Access administration pages** permission.
2. Set the global **date type** (date vs date‑and‑time behaviour), **hours
   format**, **granularity**, **disabled days**, **disabled dates**, and **start of
   week**.
3. Use the **per‑field‑ID** overrides to change the behaviour for specific field
   IDs globally, without editing each form display individually.
4. Save. These act as the defaults the picker uses.

> The config route is gated by the broad *Access administration pages* permission,
> but the form only writes this module's own configuration — it performs no other
> action.

## Using the picker in a custom form (developers)

The module also registers a render element you can use directly in code:

```php
$form['dateAndTime'] = [
  '#type' => 'materialize_date_time',
  '#title' => t('Start Date'),
  '#date_format' => 'Y-m-d H:i',
  '#default_value' => \Drupal\Core\Datetime\DrupalDateTime::createFromTimestamp(time()),
];
```

The same per‑field options are available on the element via properties such as
`#hour_format`, `#allow_times`, `#disable_days`, `#week_start`, and `#exclude_date`.
