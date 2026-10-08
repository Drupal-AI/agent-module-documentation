<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easepick integrates the lightweight, dependency-free easepick JavaScript date/range picker into Drupal forms.

---

Easepick is a thin, code-driven wrapper around the easepick JavaScript date-picker library. It ships Drupal asset libraries for the easepick bundle, core, datetime package, and every easepick plugin (amp, kbd, lock, range, preset, time) — all loaded from the jsDelivr CDN — plus a small initializer script and a demo form at `/easepick/example`. There is no admin UI, no settings, no field widget and no config: a developer enables the picker on a form by adding a value element `$form['easepick']['#value'] = TRUE`, and the module's `hook_form_alter()` implementation (`easepick_form_alter()`) attaches the `easepick/easepick.core` and `easepick/drupal.easepick` libraries. The bundled initializer (`assets/js/easepick.js`) instantiates easepick against the field whose HTML id is `edit-checkin`. To target other fields or enable range/time/lock plugins you supply your own initializer JS and attach the relevant easepick library. Useful as a reference/example integration and as a packaged, CDN-sourced easepick library for custom forms.

---

- Add a modern, dependency-free date picker to a custom Drupal form built with the Form API.
- Attach easepick to a form by setting `$form['easepick']['#value'] = TRUE` in a form builder or `hook_form_alter()`.
- View the shipped demo at `/easepick/example` (an `ExampleForm` with a check-in textfield and a guests select) to see the picker in action.
- Use the packaged `easepick/easepick.core` Drupal library to load the easepick core assets from the jsDelivr CDN without hand-writing script tags.
- Load the full easepick feature set via the `easepick/easepick.bundle` library (note: the module notes it can break Olivero and some themes — see drupal.org issue 3411027).
- Enable date-range selection in a custom initializer by attaching the `easepick/easepick.range-plugin` library.
- Add predefined ranges (today, last 7 days, etc.) with the `easepick/easepick.preset-plugin` library.
- Add a time picker alongside the date with the `easepick/easepick.time-plugin` library.
- Disable/lock specific days from selection with the `easepick/easepick.lock-plugin` library.
- Enable keyboard navigation of the calendar with the `easepick/easepick.kbd-plugin` library.
- Use AMP-style extra options via the `easepick/easepick.amp-plugin` library.
- Load only the datetime helper package with the `easepick/easepick.datetime` library.
- Provide a booking/reservation-style check-in date field, the scenario the demo form is modeled on (borrowed from the Bee Hotel module).
- Build a search or filter form where a visitor picks a date before submitting a query.
- Prototype date-input UX quickly by copying the demo `ExampleForm` and the `assets/js/easepick.js` initializer.
- Write a custom initializer that targets a specific field id (the shipped one targets `edit-checkin`) using `document.getElementById` inside a `Drupal.behaviors` attach handler.
- Attach easepick within a `Drupal.behaviors` behavior so it initializes correctly on AJAX-loaded form content (initializer uses `core/drupal` and `core/once`).
- Support Drupal 9.4, 10 and 11 sites (`core_version_requirement: ^9.4 || ^10 || ^11`) with a single date-picker integration.
- Ship a date picker without adding PHP or Composer dependencies — the module requires no other modules and no Composer packages.
- Serve the easepick JS/CSS from a CDN rather than hosting the assets locally, avoiding a build step for the front-end library.
- Study a minimal, real-world example of using `hook_form_alter()` to conditionally attach front-end libraries based on a form value flag.
- Uninstall cleanly when no longer needed: the module has no stored configuration or content to remove.
