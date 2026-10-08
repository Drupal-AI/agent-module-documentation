<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recurrence, cron and form callbacks

## The date_recur field

`localgov_event_date` is a `date_recur` field, not a plain datetime. That means:

- The stored value is a start/end datetime **plus an RRULE**.
- `date_recur` materialises **occurrences** into its own table, which is what the listing view
  queries — so a weekly event appears on each of its dates.
- Changing the rule regenerates occurrences on save.

```php
$node = \Drupal\node\Entity\Node::create([
  'type' => 'localgov_event',
  'title' => 'Weekly coffee morning',
  'localgov_event_date' => [
    'value'     => '2026-09-01T10:00:00',
    'end_value' => '2026-09-01T11:00:00',
    'rrule'     => 'FREQ=WEEKLY;COUNT=12',
    'timezone'  => 'Europe/London',
  ],
]);
$node->save();
```

Use `COUNT` or `UNTIL` where you can. Infinite rules are supported but rely on the cron guard
below to stay bounded.

## The daily cron guard

```php
function localgov_events_cron(): void {
  $last_run = \Drupal::state()->get('localgov_events.infinite_cache_last_run', 0);
  if ((\Drupal::time()->getRequestTime() - $last_run) < 86400) { return; }   // once per day
  \Drupal::state()->set('localgov_events.infinite_cache_last_run', $request_time);

  $fieldDefinitions = \Drupal::service('entity_field.manager')->getFieldDefinitions('node', 'localgov_event');
  if (!isset($fieldDefinitions['localgov_event_date'])
      || $fieldDefinitions['localgov_event_date']->getType() !== 'date_recur') { … }
  // …manages DateRecurOccurrences for infinitely recurring events.
}
```

Points that matter operationally:

- It runs **once per 24h** regardless of how often cron fires; forcing it means clearing the state
  key:

  ```bash
  drush sdel localgov_events.infinite_cache_last_run && drush cron
  ```

- It defends against the field having been changed or removed — if `localgov_event_date` is no
  longer a `date_recur` field it bails out rather than erroring.
- If far-future occurrences stop appearing for an infinite rule, this is the code to look at
  first.

## Form callbacks

`hook_form_node_localgov_event_form_alter()` and `…_edit_form_alter()` both call
`EventsAddEditCallbacks::configureNodeForm($form)`, which adapts the `date_recur_modular` widget
for the LocalGov editorial flow. Extend it from your own module with a later-weighted
`hook_form_alter()` rather than editing the class.

## Listing filter adjustments

`hook_views_pre_view()` mutates the **exposed input** before the query runs:

```php
if ($view->id() == 'localgov_events_listing') {
  $filters = $view->getExposedInput();
  if (!empty($filters['end'])) {
    $filters['end'] = date('Y-m-d', strtotime($filters['end'] . ' + 1 days'));
    $view->setExposedInput($filters);
  }
  if (empty($filters['start'])) {
    $filters['start'] = date('Y-m-d');
    $view->setExposedInput($filters);
  }
}
```

Consequences worth knowing:

- The URL query string still shows the user's chosen end date; only the query is shifted. Do not
  "fix" an apparent off-by-one by adjusting the view filter as well, or you will double-count.
- Because the start default is applied at pre-view, a saved link with no `start` parameter always
  means "from today", not "all time". To list past events you must pass an explicit `start`.

## Theming

`hook_theme()` registers the module's event templates and `localgov_events.libraries.yml` provides
`events-styling` plus the date-picker JS (`js/localgov_events_date_picker.js`). Override templates
in your theme; use `libraries-override` to replace the CSS/JS.
