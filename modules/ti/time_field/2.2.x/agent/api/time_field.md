# Time Field — programmatic API & integrations

## Data model

A time is an **integer number of seconds past midnight** (0–86400). `time` has one column
`value`; `time_range` has `from` (required) and `to` (nullable). Read/write raw:

```php
$node->field_start->value;          // e.g. 32400  (= 09:00:00)
$node->field_hours->from;           // int seconds
$node->field_hours->to;             // int|null
$node->set('field_start', ['value' => 9 * 3600]); // 09:00
```

## The `Time` value object — `Drupal\time_field\Time`

Final, immutable helper wrapping hour/minute/second. All widgets, formatters, tokens and
the Feeds target use it. Constructor throws `\InvalidArgumentException` on out-of-range
components (hour 0–23, minute/second 0–59).

```php
use Drupal\time_field\Time;

$t = new Time(9, 30, 0);
$t->getHour();          // 9
$t->getMinute();        // 30
$t->getSecond();        // 0
$t->getTimestamp();     // 34200  (seconds past midnight)
$t->format('h:i a');    // '09:30 am'  (any PHP DateTime format)
$t->formatForWidget();  // 'H:i:s' -> '09:30:00'  (pass FALSE for 'H:i')

// Factories:
Time::createFromTimestamp(34200);        // from seconds past midnight (asserts 0–86400)
Time::createFromHtml5Format('09:30');    // from '9:30' or '9:30:20' (seconds optional)
Time::createFromDateTime(new \DateTime());

// Attach the time to a specific day:
$dt = $t->on(new \DateTime('2026-07-09')); // \DateTime at 2026-07-09 09:30:00
```

Note: `getTimestamp()` returns seconds-past-midnight, not a Unix timestamp.

## Reusable form element `#type => 'time'`

`Drupal\time_field\Element\TimeElement` (`@FormElement("time")`) renders a native HTML5
time input and is usable in any form:

```php
$form['start'] = [
  '#type' => 'time',
  '#title' => $this->t('Start time'),
  '#required' => TRUE,
  '#show_seconds' => TRUE,   // optional; default FALSE
];
```

Its value callback converts the submitted `HH:MM[:SS]` string to a seconds-past-midnight
integer (as a string). Theme hook `input__time`; template `templates/input--time.html.twig`.
The `time_field/field-icon-time` library only styles the field-type picker icon in Field UI.

## Validation constraint `time`

`TimeConstraint` / `TimeConstraintValidator` (`@Constraint(id = "time")`) is attached
automatically to the `time` field type (via `ComplexData` on the `value` property). It adds
the violation "This value is not a valid time." whenever `Time::createFromTimestamp()`
rejects the value (outside 0–86400).

## Token integration (`time_field.tokens.inc`)

Requires the Token/core token system. Token types `time` and `time_range`:

- `[time:<format>]` — the value formatted with any PHP date format; `[time:value]`
  defaults to `g:i a`.
- `[time_range:from]`, `[time_range:to]` — each defaults to `g:i a`.
- `[time_range:from:<format>]`, `[time_range:to:<format>]` — from/to with a custom format.

## Feeds integration

`Drupal\time_field\Feeds\Target\Time` (`@FeedsTarget(id = "time_feeds_target",
field_types = {"time"})`) maps an incoming value to the `time` field's `value` property.
String inputs are parsed with `Time::createFromHtml5Format()`, then stored as the
seconds-past-midnight integer. (Feeds is an optional dev/test dependency, not required.)

## Install/update note

`time_field_update_10200()` migrates legacy `time_range` data so the `to` column allows
`NULL` (converting an old `86401` sentinel to `NULL`). Relevant only when upgrading an
older site; run `drush updatedb`.
