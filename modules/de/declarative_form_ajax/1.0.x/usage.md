<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Declarative Form AJAX lets Form API elements declare AJAX update dependencies on other elements so they refresh automatically when a controlling element changes.

---

Declarative Form AJAX provides a declarative alternative to hand-wired `#ajax` callbacks in Drupal Form API. Instead of adding an `#ajax` callback plus a wrapper to each triggering element, a dependent element declares `#ajax => ['updated_by' => [[...parents...]]]` naming the element(s) that control it, and the whole form gets a single `#after_build` callback: `\Drupal\declarative_form_ajax\FormAjax::ajaxAfterBuild`. That callback walks the form, promotes the named controlling elements into AJAX triggers, and installs `FormAjax::ajaxCallback`. When a controlling element's value changes, the callback re-renders each dependent element and returns `InsertCommand`s that replace them in place; it also re-runs and chains any AJAX callback the triggering element already had. This mirrors core's `#states` ergonomics for the AJAX case and is aimed at developers building interdependent forms. The project ships a `declarative_form_ajax_demo` submodule with two example routes, and is presented by its author as a proof of concept for a core issue that also works as a contrib dependency. It has no configuration UI, no permissions, no services, and no config schema; the AJAX callbacks run within the normal form-rebuild flow with the current user's privileges and render only elements the form itself defined.

---

- Refresh a container automatically when a checkbox elsewhere on the form is toggled.
- Update a field's rendered markup when a dependency field changes, without writing an `#ajax` callback.
- Declare a `details` element as `updated_by` another element so its contents re-render on change.
- Wire dependent-field behaviour by listing controlling-element parents in `#ajax => ['updated_by' => ...]`.
- Attach one form-level `#after_build` (`FormAjax::ajaxAfterBuild`) to enable all declared dependencies.
- Have several elements all depend on the same controlling element and update together.
- Update a standalone `textfield` or `checkbox` when a controlling element changes.
- Reduce Form API boilerplate versus per-element `#ajax` callback + wrapper wiring.
- Keep AJAX dependencies co-located with the elements that need them, like core `#states`.
- Let a controlling element that had no AJAX of its own become an AJAX trigger automatically.
- Preserve and chain an existing `#ajax` callback on a controlling element (via `prior_callback`).
- Refresh elements nested inside a custom render element that has its own built-in AJAX.
- Target elements that live inside a `#group` (the callback strips `#group` so they render).
- Prepend status messages next to the triggering element after an AJAX update.
- Build proof-of-concept dependent forms without a contrib forms/AJAX framework.
- Use it as a lightweight contrib dependency for a module that needs declarative form AJAX.
- Study the demo submodule routes `/demo/declarative-ajax-form` and `/demo/declarative-ajax-element-form`.
- Learn the `Element::walkChildrenRecursive()` helper for applying a callback to a form and all descendants.
- Migrate hand-written dependent-field AJAX to a declarative form-array syntax.
- Support Drupal 10 and 11 (`core_version_requirement: ^10 || ^11`) with no non-core module dependencies.
