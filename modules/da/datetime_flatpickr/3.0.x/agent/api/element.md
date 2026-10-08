<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `datetime_flatpickr` render/form element

Source: `src/Element/DateTimeFlatPickr.php` (`#[FormElement('datetime_flatpickr')]`, extends core
`Textfield`) + `js/datetime-flatpickr.js`. Use it to get a flatpickr-powered field in any custom form
without a Field API field — this is what the BEF and Webform submodules reuse.

## Using it in a form array

```php
$form['event_date'] = [
  '#type' => 'datetime_flatpickr',
  '#title' => $this->t('Event date'),
  // Any flatpickr widget setting is passed as a #-prefixed property:
  '#dateFormat' => 'Y-m-d H:i',
  '#enableTime' => TRUE,
  '#time_24hr' => TRUE,
  '#minuteIncrement' => 15,
  '#minDate' => 'today',
];
```

## How it wires up

- `getInfo()` adds a `#process` callback that sets an `flatpickr-name` HTML attribute to the element
  `#name` (the JS keys off this).
- `preRenderTextfield()` attaches the `datetime_flatpickr/flatpickr-init` library, auto-attaches the
  matching `flatpickr_<lang>` locale library for the current interface language, and emits the resolved
  settings to `drupalSettings.datetimeFlatPickr[<name>].settings`.
- `getElementSettings()` (in `DateTimeFlatPickrWidgetTrait`) collects the `#`-prefixed properties that
  match known setting keys, defaults the rest, sanitizes strings (`Html::escape`), and normalizes them
  (`processFieldSettings` / `fieldSettingsFinalNullCleanType`) into the flatpickr option object.
- `js/datetime-flatpickr.js` reads `drupalSettings.datetimeFlatPickr[name].settings` and calls
  `flatpickr()` on the element with attribute `flatpickr-name="<name>"`.

## Settings you can pass

Same keys as the field widget (see [../configure/widget.md](../configure/widget.md)): `dateFormat`,
`altInput`/`altFormat`, `enableTime`, `enableSeconds`, `time_24hr`, `minDate`/`maxDate`,
`minTime`/`maxTime`, `minuteIncrement`, `position`, `weekNumbers`, `disabledWeekDays`, `disabledDates`,
`inline`, `allowInput`, `mode`, `jumpToDate`, `defaultDate`.

## Value handling

The element renders as a textfield and submits a string in `dateFormat`; unlike the field widget there
is no automatic timezone/storage conversion (`massageFormValues` lives on the widgets), so convert the
submitted string yourself if you need a `DrupalDateTime`.
