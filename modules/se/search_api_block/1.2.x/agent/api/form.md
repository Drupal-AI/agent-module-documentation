<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the form works

`Drupal\search_api_block\Form\SearchApiForm` (form id `search_api_form`, marked
`@internal`) is built by the block's `build()` with the block settings passed as arguments.
Key behaviours:

- **Action & method.** `$form['#action']` is set to the internal `action_url`
  (`Url::fromUri('internal:' . $action_url)`), and `$form['#method']` to `action_method`
  (`get` by default). The form has **no server-side submit logic** — `submitForm()` is
  empty; navigation to the search page is what performs the search.
- **The search input** is a `#type => 'search'` element keyed by `input_name` (so the query
  string parameter matches the target view's exposed filter). It seeds its default value
  from the current request's same-named query arg, and adds cache context
  `url.query_args:<input_name>`. The element carries `#search_api_block => TRUE`.
- **Clean URLs.** `search_api_block_form_search_api_form_alter()` sets `#access = FALSE` on
  `form_build_id`, `form_token` and `form_id`, so a GET submit does not push those into the
  resulting URL.
- **Pass GET parameters.** When `pass_get_params` is TRUE, any query string already present
  in `action_url` is parsed and re-emitted as `#type => 'hidden'` fields (arrays become
  `name[key]` hidden fields), preserving pre-set filters through submission.
- **Tokens.** `SearchBlock::replaceTokenValue()` runs `action_url`, `input_name`,
  `input_placeholder`, `submit_value` and `input_label` through the `token` service (with
  `clear => TRUE`) when the Token module is present, using the block's optional `entity`
  context as token data.
- **Disabled state.** If `action_url` is empty the form renders only the message
  "Search is currently disabled".

## Theming

The input provides a theme suggestion via
`search_api_block_theme_suggestions_input_alter()`: elements flagged `#search_api_block`
get the suggestion **`input__search_api_block`**, so a theme can override
`input--search-api-block.html.twig` to style just this search field.

## Block plugin essentials

`Drupal\search_api_block\Plugin\Block\SearchBlock` — id `search_api_form_block`, category
"Forms", `blockAccess()` returns allowed (visibility is controlled by standard block
conditions). It declares an optional context definition `entity` used only for token
replacement. `defaultConfiguration()` defines all settings keys (see
[configure/search-block.md](../configure/search-block.md)).
