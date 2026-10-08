<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Demo/test submodule of Declarative Form AJAX providing two example forms that show the declarative AJAX update syntax.

---

Declarative Form Ajax Demo is the example submodule shipped with the Declarative Form AJAX project. It
depends on the base `declarative_form_ajax` module and exposes two routes, `/demo/declarative-ajax-form`
and `/demo/declarative-ajax-element-form`, each rendering a `FormBase`. The first form
(`DeclarativeAjaxDemoForm`) has a controlling checkbox and several dependent elements — a container, a
`details`, a standalone textfield and a standalone checkbox — that declare `#ajax => ['updated_by' =>
[['clickme']]]` and re-render (their titles include `time()`, so a change is visible) when the checkbox
changes. The second form (`DeclarativeAjaxElementDemoForm`) uses a custom render element,
`declarative_form_ajax_demo_select` (class `TestSelect`), which already ships its own `#ajax` callback,
to demonstrate that the base module chains a pre-existing callback. This submodule is reference/example
code only and should not be enabled on production sites.

---

- Enable it (with the base module) to see declarative form AJAX working end to end.
- Visit `/demo/declarative-ajax-form` for the simple-element demo.
- Visit `/demo/declarative-ajax-element-form` for the custom-element demo.
- Read `DeclarativeAjaxDemoForm` to learn the `updated_by` container/details/textfield/checkbox patterns.
- Read `DeclarativeAjaxElementDemoForm` to see updates targeting an element inside a custom render element.
- Study `TestSelect` (`declarative_form_ajax_demo_select`) as an example render element with built-in AJAX.
- Confirm the base module chains an element's pre-existing AJAX callback (`prior_callback`).
- Use the forms as copy-paste starting points for your own declarative AJAX forms.
- Observe how dependent elements re-render (the `time()` in titles changes) after a controlling change.
- See how a dependency address into a nested custom element is written (`['clickme','container','select']`).
- Verify status messages are prepended near the triggering element after an update.
- Use it in local/dev environments to validate the base module on Drupal 10 or 11.
