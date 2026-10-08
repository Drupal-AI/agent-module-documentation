<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Date recur interactive widget"

## Install & enable

```bash
composer require drupal/date_recur_interactive
drush en date_recur_interactive -y
```

Requires **`date_recur`** (Recurring Dates Field 3.x); it is a hard dependency in
`date_recur_interactive.info.yml` (`date_recur:date_recur`). `date_recur_entity_test` is a
test-only dependency. No sub-modules, no permissions, no Drush, no config of its own.

## Enable it on a field

The widget (plugin id **`date_recur_interactive_widget`**, label *"Date recur interactive
widget"*) applies to **`date_recur`** fields (`field_types = { "date_recur" }`) — the field type
provided by Recurring Dates Field. It does not apply to core datetime/daterange fields.

UI path: create/choose a **Date Recur** field on a bundle, then
*Structure → (bundle) → Manage form display* → set that field's **Widget** to
**Date recur interactive widget**.

Config equivalent (form display):

```bash
drush cset core.entity_form_display.node.event.default \
  content.field_when.type date_recur_interactive_widget -y
drush cr
```

## What the widget plugin does

`DateRecurInteractiveWidget` (in `src/Plugin/Field/FieldWidget/DateRecurInteractiveWidget.php`)
extends date_recur's **`DateRecurBasicWidget`** and overrides only `formElement()`:

1. Calls `parent::formElement()` — so the start-date, end-date, time, timezone and rrule sub-elements,
   their default values and **all server-side validation come from the basic widget** unchanged.
2. Generates one shared id with `Html::getUniqueId('date-recur')` and stamps it as data-attributes:
   - `value` → `data-date-recur-start`
   - `timezone` → `data-date-recur-timezone`
   - `rrule` → `data-date-recur-rrule`
3. Attaches library **`date_recur_interactive/widget`**.
4. Sets `first_occurrence['#weight'] = -10` so the first-occurrence preview sits above the editor.

There are **no widget settings added** by this module; `defaultSettings()`, `settingsForm()` and
`settingsSummary()` are inherited from `DateRecurBasicWidget`.

## Client-side behaviour

`js/date_recur_rrule.js` — `Drupal.behaviors.dateRecurRruleWidget` (uses `core/once` on
`textarea[data-date-recur-rrule]`):

- Reads the shared id, locates the start-date, start-time and timezone inputs by the matching
  data-attributes.
- **Hides** the real rrule textarea and its label, inserts a *"Repeat?"* checkbox (checked if a
  rule already exists) and a `.date-recur-widget` div.
- Ticking *Repeat?* lazily initialises the jQuery UI editor with options
  `{ rrule, dtstart, startTime, timeZone }` derived from the current field values; unticking hides
  the editor and clears the rrule value.
- Listens for the editor's `rrule-update` event and writes the editor's `.rrule-output` text back
  into the hidden textarea (that is the value actually saved).
- Re-pushes options to the editor whenever start date/time or timezone change, and disables
  *Repeat?* until a start date is set.
- On form submit, removes the `name` attribute from all of the editor's own inputs so only the
  real `rrule` value is posted (the editor controls are UI-only, never submitted).

`js/date_recur_rrule.widget.js` — defines jQuery UI widget **`rrule.recurringinput`** (adapted from
Josh Levinger's rrule editor, relicensed GPL-2.0+). It builds the DOM controls, recomputes the
RRULE on every change (`_refresh` → `_getRRule`), and renders both a human-readable summary
(`.text-output`, via rrule.js `toText()`) and the raw rule (`.rrule-output`). It uses the **bundled**
rrule.js; if the browser lacks native `<input type="date">` it attaches a jQuery UI datepicker
(`dateFormat: 'yy-mm-dd'`).

## Editor controls → RRULE

| Control (name) | RRULE part |
|---|---|
| Repeat (`freq`) | `FREQ` — yearly/monthly/weekly/daily/hourly/minutely/secondly |
| every N (`interval`) | `INTERVAL` (omitted when `1`) |
| On / On the … weekday (`byweekday`) | `BYDAY` (weekly + monthly views) |
| first/second/…/last (`byweekday-pos`) | positional `BYDAY` (e.g. `1MO`, `-1FR`), combined with the checked weekdays |
| Only in … months (`bymonth`) | `BYMONTH` (monthly view) |
| Only at (`byhour` / `byminute` / `bysecond`) | `BYHOUR` / `BYMINUTE` / `BYSECOND` (hourly/minutely/secondly views) |
| End = Never / After N / On date | nothing / `COUNT` / `UNTIL` |
| Exclude/Include dates | `EXDATE` / `RDATE` lines added to the rule set |

Only the controls for the selected frequency are shown; switching frequency clears the
now-hidden fields (`_refresh`). The rule is assembled as an `RRule.RRuleSet` so include (`rdate`)
and exclude (`exdate`) dates are emitted alongside the `RRULE`.

## Timezone handling

Include/exclude dates are date-only in the UI but must land at the right instant. `_parseExincDate()`
combines the picked date with the field's start-time and, when a timezone is selected, adjusts the
UTC timestamp using `Intl.DateTimeFormat` offsets (`_getTimeZoneOffsetMilliseconds`), recalculating
once so DST is resolved for the actual date. `_formatExincDateInputValue()` formats stored dates back
to the field timezone for display. This is the area the project's own notes call out as historically
bug-prone — test include/exclude dates and DST edges before relying on them in production.

## Libraries (`date_recur_interactive.libraries.yml`)

- **`rrule`** — bundled `lib/rrule.js/rrule.js` and `lib/rrule.js/nlp.js` (BSD-3-Clause, from
  jkbrzt/rrule). Vendored in-repo; nothing to install.
- **`widget`** — `js/date_recur_rrule.widget.js`, `js/date_recur_rrule.js`, `css/widget.css`;
  depends on `date_recur_interactive/rrule`, `core/jquery.ui.datepicker`, `core/jquery.ui.widget`,
  `core/once`.

## Gotchas

- The rrule textarea is only **hidden**, not removed; the value saved is whatever the editor mirrors
  into it. If JavaScript is disabled the editor never initialises and the raw textarea stays hidden —
  editors get no recurrence UI, so this widget needs JS.
- *Repeat?* is disabled until a start date is entered (a rule needs `DTSTART`).
- A new (empty) rule defaults to **weekly** on the start date's weekday.
- The module ships **no config schema**; all widget settings come from `DateRecurBasicWidget`, so
  strict schema tooling behaves exactly as it does for date_recur's basic widget.
- Recurrence data is hard to correct after saving — validate rules against the first-occurrence
  preview before publishing.
