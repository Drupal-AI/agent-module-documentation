# How it works (mechanism)

The whole module is one hook plus a small class and a JS behavior. There is no service you
call, no config, and no plugin type. This is a **render-element alteration**, not a widget.

## The hook

`datetime_now.module` implements `hook_element_info_alter()`:

```php
function datetime_now_element_info_alter(array &$info) {
  if (isset($info['datetime'])) {
    \Drupal::classResolver(DatetimeElementInfoAlter::class)->alter($info);
  }
}
```

It only touches the core **`datetime`** element type. `DatetimeElementInfoAlter::alter()`
appends its `process()` method to `$info['datetime']['#process']`.

## The process callback

`Drupal\datetime_now\ElementInfoAlter\DatetimeElementInfoAlter::process()` runs on every
built `datetime` element and:

- adds the class `datetime-now-wrapper` to the element,
- adds a child `now` render array of `#type => button`, `#value => t('Now')`, with class
  `datetime-now` and a `data-date-selector` attribute copied from the element's date input
  `data-drupal-selector`,
- attaches the `datetime_now/datetime_now` library.

## The JavaScript (`js/datetime_now.js`)

`Drupal.behaviors.datetime_now_button` binds a click handler (via `once`) to each
`.datetime-now` button. On click it reads the sibling date and time inputs (by
`data-drupal-selector` `…-date` / `…-time`), sets the date input to today and the time input
to the current time. It reads the time input's `step` attribute: **if `step` is a multiple
of 60 it returns `HH:MM`** (no seconds), otherwise `HH:MM:SS`. Times are computed in the
browser's local timezone.

## Which widgets get the button — and which don't

Because the trigger is the `datetime` **element**, the button appears on any widget that
renders it:

- ✅ `datetime_default` ("Date and time") — core Date/time widget.
- ✅ `daterange_default` — Datetime Range widget (the button is added to both the start and
  end `datetime` sub-elements).
- ❌ `datetime_datelist` ("Select list") — renders the `datelist` element, **not** altered.
- ❌ Date-only fields still get a Now button on the date input (there is simply no time
  input to fill).

## Introspecting it on a live site

To confirm the module is wiring the button in, inspect the element info:

```php
$info = \Drupal::service('plugin.manager.element_info')->getInfo('datetime');
// $info['#process'] contains a callback whose object is
// Drupal\datetime_now\ElementInfoAlter\DatetimeElementInfoAlter
```

## Extension seam

`DatetimeElementInfoAlter` implements `ElementInfoAlterInterface` (a one-method `alter()`
contract) and is instantiated through the class resolver, so it is service-injectable, but
the module defines no services.yml entry and invites no hooks of its own — there is nothing
to subclass or alter in practice.
