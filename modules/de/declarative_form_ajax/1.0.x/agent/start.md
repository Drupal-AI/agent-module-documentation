<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declarative Form AJAX (declarative_form_ajax) — agent index

Declarative alternative to hand-wired `#ajax` in Form API: a dependent element declares
`#ajax => ['updated_by' => [[...parents...]]]`, and one form-level `#after_build` callback wires up the
rest. Mirrors core `#states` ergonomics for AJAX updates. Version **1.0.0**, core `^10 || ^11`.

- **Dependencies:** none outside Drupal core. No composer requirements.
- **Provides:** no config, no permissions, no services, no config schema, no routes (base module).
- **Public API — `\Drupal\declarative_form_ajax\FormAjax`:**
  - `ajaxAfterBuild($form, $form_state)` — set as `$form['#after_build'][]`; walks the form, promotes
    `updated_by` targets into AJAX triggers, installs the callback (chains any existing one via
    `prior_callback`).
  - `ajaxCallback(&$form, $form_state, $request)` — the wired AJAX callback; re-renders dependent
    elements and returns an `AjaxResponse` of `InsertCommand`s (plus status messages).
- **Helper — `\Drupal\declarative_form_ajax\Element::walkChildrenRecursive(&$element, callable)`** —
  applies a callback to a form element and all descendants.
- **Submodule `declarative_form_ajax_demo`** — example forms; documented separately (see below).

## How to use
- `agent/api/form-ajax.md` — the declarative syntax, the `#after_build` wiring, callback behaviour,
  and the `Element` helper.

## Submodule
- Demo module docs: `../../modules/declarative_form_ajax_demo/1.0.x/agent/start.md`
