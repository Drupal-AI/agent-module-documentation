<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API block — agent index

Provides one **Block plugin**, `search_api_form_block` (admin label "Search API form",
category "Forms"), that renders a search input submitting to an existing **Search API view
page**. No settings form, no configure route, no permissions, no Drush. It requires the
`search_api` module. All state lives on the placed block's config entity under
`settings` (schema `block.settings.search_api_form_block`).

- **Place & configure the block, every settings key, where it is stored** →
  [configure/search-block.md](configure/search-block.md)
- **How the form works (GET/POST, clean URL, tokens, theming)** →
  [api/form.md](api/form.md)

Key facts: the block does **not** search — it navigates to `action_url` (the Search page
path) carrying the keyword under `input_name` (default exposed filter name `keys`). Block
plugin id = `search_api_form_block`; settings keys: `action_url`, `action_method`
(`get`/`post`), `input_name`, `input_placeholder`, `submit_value`, `input_label`,
`input_label_visibility`, `pass_get_params`.
