<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Duet Date Picker adds the accessible Duet date-picker web component to Drupal date fields as field widgets and to Views exposed date filters.

---

Duet Date Picker integrates the framework-agnostic, accessibility-focused Duet Date Picker web component (`duetds/date-picker`) into Drupal. It provides two field widgets that replace core's date input on `datetime` and `daterange` fields, three Views filter handlers (extending the core date, core datetime, and Search API date filters) that add an optional Duet picker to exposed date filters, and a `NoPastDates` validation constraint that rejects dates earlier than now/today. The picker component and its CSS are loaded from a locally-installed asset library (`/libraries/duetds--date-picker`, via `npm-asset/duetds--date-picker` on asset-packagist), and calendar strings are localized through Drupal's translation system. The installed release is a pre-release beta.

---

- Replace the default date input on a `datetime` field with the Duet picker.
- Replace the default input on a `daterange` field with paired Duet start/end pickers.
- Offer an accessible, keyboard-navigable, screen-reader-friendly date picker to content editors.
- Keep core's time input while using Duet only for the date portion of a datetime field.
- Customize the picker's visible label per widget (e.g. "Choose a date").
- Set separate start-date and end-date labels on a daterange widget.
- Disallow past dates on a date field via the "Disallow past dates" widget setting.
- Enforce no-past-dates server-side with the `NoPastDates` constraint (rejects both start and end).
- Feed today's date as the picker's `min` attribute when past dates are disallowed.
- Add a Duet picker to an exposed core date filter in a View.
- Add a Duet picker to an exposed core datetime filter in a View.
- Add a Duet picker to an exposed Search API date filter (single, or min/max range).
- Provide a consistent date-entry UX across node forms and Views exposed filters.
- Localize the picker UI (day/month names, button labels) via Drupal translations.
- Store standard Drupal date values (`DrupalDateTime`) unchanged in the database.
- Improve i18n by switching the picker locale (e.g. French) based on the current language.
- Provide a template-overridable `<duet-date-picker>` element via `duet-date-picker.html.twig`.
- Serve the picker assets locally rather than from an external CDN.
- Support multi-value date fields (suppresses extra blank Duet inputs).
- Use it on any bundle's date field through Manage form display, no code required.
