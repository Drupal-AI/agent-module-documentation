<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `flatpickr_date` Webform element

Source: `modules/datetime_flatpickr_webform/src/Plugin/WebformElement/FlatpickrDate.php`
(`@WebformElement(id = "flatpickr_date")`).

## Add it via the UI

At *Structure → Webforms → (your form) → Build → Add element*, choose **Flatpickr Date** (category
"Date/time elements"). The element edit form shows a **Flatpickr settings** details group (built from the
parent module's `DateTimeFlatPickrWidgetTrait::getSettingsForm()`) with the usual options
(`dateFormat` default `Y-m-d`, `altInput`/`altFormat`, `enableTime`, `enableSeconds`, `time_24hr`,
`minDate`/`maxDate`, `minTime`/`maxTime`, `minuteIncrement`, `position`, `weekNumbers`,
`disabledWeekDays`, `disabledDates`, `inline`, `allowInput`, `mode`). It also supports Webform's standard
`multiple` value settings.

## Where it lives in config

A webform stores its elements as a YAML string in `webform.webform.<id>:elements`. An instance looks like:

```yaml
event_date:
  '#type': flatpickr_date
  '#title': 'Event date'
  '#dateFormat': 'Y-m-d H:i'
  '#enableTime': true
  '#time_24hr': true
```

## How it renders

`prepare()` sets the element `#type` to the parent module's `datetime_flatpickr` render element (and
defaults `#dateFormat` to `Y-m-d` if unset). That render element attaches
`datetime_flatpickr/flatpickr-init` + the matching locale library and passes the settings to
`drupalSettings.datetimeFlatPickr`, where `js/datetime-flatpickr.js` instantiates flatpickr — see the
parent module's `agent/api/element.md` (at `modules/da/datetime_flatpickr/3.0.x/`).

## Add it with Drush (example)

```php
// drush php:eval — append a flatpickr_date element to an existing webform
$w = \Drupal\webform\Entity\Webform::load('contact');
$els = $w->getElementsRaw();
$els .= "\nevent_date:\n  '#type': flatpickr_date\n  '#title': 'Event date'\n  '#enableTime': true\n";
$w->setElements(\Drupal\Component\Serialization\Yaml::decode($els));
$w->save();
```

No configuration exists at the module level — everything is per-element inside each webform.
