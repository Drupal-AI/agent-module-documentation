<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views user input field — agent start

**What**: Global Views field `views_user_input_field` that outputs a request query-string
value (by key) for reuse in calculations or Twig. Depends on `views`.

## Set up
1. `drush en views_user_input_field -y`.
2. Edit a view → add field **User input field** (group *Custom Global*).
3. Set **Query string key** = the HTML form element `name`, Webform key, or exposed filter's
   *Filter identifier*.

## Key facts
- Class: `Drupal\views_user_input_field\Plugin\views\field\ViewsUserInputField`.
- `query()` is empty — no join/column added, **no SQL surface**.
- `render()` returns `Html::escape($request->query->get($key))` as `#markup` with cache
  context `url.query_args:<key>` — output is escaped (not an XSS vector).
- Typical use: operand for *Views Simple Math Field* or a Twig rewrite.
- No routes/permissions; config is per view.
