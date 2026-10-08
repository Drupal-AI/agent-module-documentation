<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enhanced taxonomy form titles (enhanced_taxonomy_form_titles) — agent index

A one-file utility module that rewrites the **page title** (`$form['#title']`) of the three core
**taxonomy term** forms so it names the action + term + vocabulary. Core requirement
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x (installed 1.0.4).

- **The single hook, the exact titles it produces, and the routes it targets** →
  [api/form-alter.md](api/form-alter.md)

## What it actually is

- No classes, no plugins, no services, no routes, no permissions, no config, no schema, no
  settings form, no Drush. The whole module is `enhanced_taxonomy_form_titles.module` (plus
  `enhanced_taxonomy_form_titles.info.yml`, `README.txt`, `LICENSE.txt`).
- Implements `hook_form_alter()` once. It early-returns on AJAX/XHR requests, then switches on the
  current route name and, for the taxonomy term add/edit/delete routes only, sets a new
  `$form['#title']`.
- Uses core **taxonomy** entity classes (`Vocabulary`, `Term`/`TermInterface`) at runtime, so
  taxonomy must be enabled. Note: `enhanced_taxonomy_form_titles.info.yml` does **not** declare a
  formal `dependencies:` entry for taxonomy — the dependency is implicit.

## Mechanism (from source)

- `enhanced_taxonomy_form_titles_form_alter(&$form, $form_state, $form_id)` — returns immediately
  when `\Drupal::request()->isXmlHttpRequest()`. Maps the route name to an action word:
  `entity.taxonomy_term.delete_form` → "Delete", `…add_form` → "Add", `…edit_form` → "Edit";
  any other route → no action, no change. When an action matches it calls the helper.
- `enhanced_taxonomy_form_titles_generate_title(&$form, $form_state, $form_action)` — resolves the
  vocabulary id from `$form['vid']['#value']` (add form) or the routed `taxonomy_term` param's
  `vid`, loads the `Vocabulary`, and sets `$form['#title']` via `t()` with `@action`, `@term`,
  `@vocab` placeholders. With a routed term it renders "@action term @term (Vocabulary : @vocab)";
  on the add form (no term) it renders "@action a term (Vocabulary : @vocab)".

## Install / operate

- `drush en enhanced_taxonomy_form_titles`. Nothing to configure; effect is immediate on the term
  forms. To revert, uninstall — no data or config is left behind.
