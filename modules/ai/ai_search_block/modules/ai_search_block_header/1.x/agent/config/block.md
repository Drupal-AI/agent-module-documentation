<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Header block, form & auto-run

Install: `drush en ai_search_block_header`, place the "AI Search Block Header (redirects to ai
search)" block (`ai_search_block_header_block`) in your header region.

## Block (`src/Plugin/Block/AiSearchHeaderBlock`)
- `defaultConfiguration()`: `destination_path` = `/basic-page/fancy-search`.
- `blockForm()`: one required textfield `destination_path` (the path that hosts the full AI Search
  block). `blockSubmit()` normalizes it to a leading-slash path.
- `build()`: gets `AiSearchHeaderForm` (passing the destination), attaches the
  `ai_search_block_header/autorun` library, and wraps everything in core `search-block-form` classes
  with `role="search"`. Cache contexts: `url.path`, `user.roles`.

## Form (`src/Form/AiSearchHeaderForm`, id `ai_search_block_header_form`)
- `#method` POST; fields: hidden `destination_path`, `search` input `q` (maxlength 128, required),
  submit. Styled to match the core search block.
- `submitForm()`: `$url = Url::fromUserInput('/' . ltrim($dest, '/'), ['query' =>
  ['ai_search_block_q' => $query]])` and `setRedirectUrl($url)`. Drupal builds the query string
  safely.

## Auto-run (`js/autorun.js`)
`Drupal.behaviors.aiSearchHeaderAutoRun` reads `ai_search_block_q` from `window.location.search`
(`URLSearchParams`), finds the AI Search input (`[data-drupal-selector="edit-query"]` /
`input[name="query"]`), sets `input.value = term` (property assignment — not `innerHTML`), dispatches
`input`/`change`, and triggers the submit button once. `aiSearchHeaderCapture` logs the captured term.

No routes, permissions, services, hooks, or config objects are defined by this submodule.
