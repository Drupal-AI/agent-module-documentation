<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Recur Modular provides friendlier form-entry widgets for the `date_recur`
(Recurring Dates Field) field type, plus a framework/starter code for building your own.

---

The Recurring Dates Field module (`date_recur`) stores an RFC 5545 RRULE, but its
stock widget is a bare RRULE textarea. Date Recur Modular ships three alternative
field widgets that render approachable, calendar-app-style recurrence UIs on top of the
same `date_recur` field type, so editors pick "weekly on Tue/Thu until…" instead of
typing `FREQ=WEEKLY;BYDAY=TU,TH`. The widgets are **Modular: Alpha** (`date_recur_modular_alpha`,
Drupal-states + CSS, supports non-recurring / multiday / weekly / monthly modes),
**Modular: Oscar** (`date_recur_modular_oscar`, an opening-hours variant where the range
stays on one day, with an optional all-day toggle), and **Modular: Sierra**
(`date_recur_modular_sierra`, an AJAX/modal Google-Calendar-style UI using a `date_recur`
interpreter to preview and exclude occurrences). You attach a widget by setting it as the
component widget for a `date_recur` field in an entity **form display** (Manage form
display, or `core.entity_form_display.*` config). The module deliberately keeps the widgets
minimal: its README states additional features are *not* intended to be added — instead you
copy a widget's code into your own module and customise it. Sierra adds a permission
(`date_recur_modular use sierra form`) and two modal-form routes; Oscar and Sierra expose a
few widget settings (all-day toggle; interpreter, date format, occurrences modal).

---

- Give content editors a calendar-app-style UI for a Recurring Dates Field instead of a raw RRULE box.
- Swap the default `date_recur` widget for **Modular: Alpha** on an event date field.
- Configure a field's Manage form display so a `date_recur` field uses `date_recur_modular_oscar`.
- Model opening hours / business hours with the Oscar widget (single-day ranges, all-day toggle).
- Let editors build "every week on selected weekdays until a date" without knowing RRULE syntax.
- Offer a monthly recurrence with ordinal (e.g. "third Thursday") through the Alpha widget.
- Provide a Google-Calendar-like modal recurrence editor via the Sierra widget.
- Preview generated occurrences (and exclude specific ones) with Sierra's occurrences modal.
- Show human-readable recurrence text in the widget by wiring Sierra to a `date_recur` interpreter.
- Restrict editors to a subset of frequencies at the field level and have the widget honour it.
- Enable an all-day/multi-day toggle on a recurring date entry form.
- Turn off Oscar's all-day toggle when every entry must have times.
- Add the recurrence widget to any entity type that has a `date_recur` field (node, media, custom entity).
- Use the bundled widgets as reference implementations when learning to build a `date_recur` widget.
- Copy a widget class into a custom module as the starting point for a bespoke recurrence UI.
- Reuse the module's shared traits/utilities (fields, options, occurrence helpers) in a custom widget.
- Grant the `date_recur modular use sierra form` permission so a role can use Sierra's modal.
- Keep recurrence entry consistent across content types by standardising on one modular widget.
- Pin the module to a specific version, since the README warns provided widgets may change/break.
- Configure widget settings (interpreter, date format type, occurrences modal) per form display.
- Migrate an existing raw-RRULE `date_recur` field to a friendlier editing experience without changing storage.
- Build an events content type where authors schedule repeating events through a guided UI.
- Set the recurrence widget via `core.entity_form_display` config for repeatable, deployable setup.
