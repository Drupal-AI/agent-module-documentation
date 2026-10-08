<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Autocomplete adds jQuery-style typeahead suggestions to any input field on a Drupal site, driven by reusable "autocompletion configuration" entities that map a CSS selector to a suggestion source (a callback URL or a view).

---

The module defines a config entity type, `autocompletion_configuration` (config prefix `search_autocomplete.autocompletion_configuration.*`), where each entity ties a target field (`selector`, a CSS selector) to a suggestion `source` and tunes the behavior: `minChar` (characters before suggesting), `maxSuggestions`, `autoSubmit`, `autoRedirect`, custom "no results" and "view all results" labels/links, a `theme` (CSS file), and `editable`/`deletable` flags. Three configurations ship enabled out of the box — `search_block` (the core search block, source `autocompletion_callbacks_nodes::nodes_autocompletion_callback`), `search_form_content` (source `autocompletion_callbacks_words::words_autocompletion_callback`), and `search_form_users` (source `autocompletion_callbacks_users::users_autocompletion_callback`) — backed by optional Views (`autocompletion_callbacks_nodes/users/words`). A `source` written as `view_id::display_id` is resolved to the view's path and its exposed filters at render time; otherwise it is treated as a direct callback URI. On the Views side the module provides three plugins used to build those JSON suggestion endpoints: a display plugin `AutocompletionCallback`, a row plugin `CallbackFieldRow`, and a style plugin `CallbackSerializer`. Configurations attach to a form element either through the element property `#autocomplete_configuration` (processed by `process_search_autocomplete()`) or, on the front end, by matching the stored CSS selector. The admin UI lives at `/admin/config/search/search_autocomplete` (entity list + add/edit/delete). Two permissions gate it: `administer search autocomplete` and `use search autocomplete`. A single settings value, `search_autocomplete.settings:admin_helper`, toggles an in-page helper tool that assists building configurations by clicking fields.

---

- Add typeahead suggestions to the core search block (works out of the box via the `search_block` config).
- Autocomplete a custom search form by pointing a configuration's selector at its input.
- Suggest matching node titles as a user types in a site search box.
- Suggest usernames in an admin or members-directory search field.
- Autocomplete free-text keywords/words for a search-as-you-type experience.
- Drive suggestions from a View by setting the source to `view_id::display_id`.
- Build a JSON suggestion endpoint from a view using the Autocompletion callback display + serializer.
- Limit when suggestions appear by raising `minChar` (e.g. only after 3 characters).
- Cap the number of suggestions shown with `maxSuggestions`.
- Auto-submit the form when a suggestion is picked (`autoSubmit`).
- Redirect straight to the selected suggestion's page (`autoRedirect`).
- Show a custom "No results found for [search-phrase]" message with a link to full search.
- Offer a "View all results for [search-phrase]" entry linking to the search results page.
- Theme the suggestion dropdown by selecting a CSS `theme` file.
- Lock down a shipped configuration from editing/deletion with `editable`/`deletable` flags.
- Attach autocompletion to a form element in code via `#autocomplete_configuration`.
- Restrict who can configure autocompletion with the `administer search autocomplete` permission.
- Allow autocompletion usage on configured fields for a role via `use search autocomplete`.
- Enable the admin helper tool (`admin_helper`) to configure fields by clicking them.
- Export autocompletion configurations as config for consistent deployment across environments.
- Provide autocomplete for an e-commerce product search input.
- Add suggestions to a taxonomy/term filter field on a listing page.
- Point multiple search inputs at the same suggestion source by reusing one configuration's selector.
