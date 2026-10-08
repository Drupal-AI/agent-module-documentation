<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form-title alter (enhanced_taxonomy_form_titles.module)

The module's entire behavior. Two procedural functions in
`enhanced_taxonomy_form_titles.module`; no OO code.

## Hook

`enhanced_taxonomy_form_titles_form_alter(&$form, FormStateInterface $form_state, $form_id)`

- **Bail-out:** if `\Drupal::request()->isXmlHttpRequest()` is TRUE it returns without touching the
  form (so AJAX rebuilds are untouched).
- Reads the current route via `\Drupal::routeMatch()->getRouteName()` and maps it to a
  `$form_action` word:

  | Route name | `$form_action` |
  | --- | --- |
  | `entity.taxonomy_term.delete_form` | `Delete` |
  | `entity.taxonomy_term.add_form` | `Add` |
  | `entity.taxonomy_term.edit_form` | `Edit` |
  | anything else | `""` (no change) |

- When `$form_action` is non-empty it calls `enhanced_taxonomy_form_titles_generate_title($form,
  $form_state, $form_action)`. Because the guard is the route name (not `$form_id`), it fires on
  whatever form those routes render, regardless of form id.

## Title builder

`enhanced_taxonomy_form_titles_generate_title(&$form, $form_state, $form_action)`

- Gets the routed term: `$term = \Drupal::routeMatch()->getParameter('taxonomy_term')`.
- Resolves the vocabulary id: `$vid = $form['vid']['#value'] ?? $term->vid->target_id ?? ''`
  (the add form supplies `vid` in the form; edit/delete fall back to the term's `vid`), then
  `$vocab = Vocabulary::load($vid)`.
- Sets the page title with `t()` and placeholders — output is auto-escaped by the translation
  system:
  - **Term present** (`$term instanceof TermInterface`, i.e. edit/delete):
    `t('@action term @term (Vocabulary : @vocab)', ['@action' => t($form_action), '@term' => $term->label(), '@vocab' => $vocab->label()])`
    → e.g. `Edit term Sofa (Vocabulary : Furniture)`.
  - **No term** (add form):
    `t('@action a term (Vocabulary : @vocab)', ['@action' => t($form_action), '@vocab' => $vocab->label()])`
    → e.g. `Add a term (Vocabulary : Furniture)`.

## Notes

- `t()` is called on the `$form_action` variable; the values are the hardcoded literals above, so
  the strings are still fixed at the call sites, though this pattern is not extractable by the
  string-extraction tooling.
- `$vocab->label()` is called without a null check on `$vocab`; if `$vid` cannot be resolved to a
  real vocabulary the load returns NULL and the title build would error — in practice the three
  routes always carry a valid `vid`.
- No new routes, permissions, services, config or libraries are introduced; the module only
  overrides `$form['#title']` on the matched forms.
