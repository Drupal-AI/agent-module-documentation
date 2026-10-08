Language Switcher Extended adds extra processors to Drupal core's Language Switcher block so that links to languages with no translation of the current content entity can be hidden, redirected to the front page, or shown as plain text instead of dead links.

---

The module implements `hook_language_switch_links_alter()` and routes every language switcher block's links through a single service (`language_switcher_extended.link_processor`). A one-page settings form at Admin → Configuration → Regional and language → Language Switcher Extended writes to one config object, `language_switcher_extended.settings`, whose top-level `mode` key selects the overall behaviour: `default` (leave core untouched), `always_link_to_front` (point every switcher item at its language's front page), or `process_untranslated` (inspect the current content entity and handle languages it isn't translated into). In `process_untranslated` mode the `untranslated_handler` key decides what happens to a missing-translation link — `hide_link` removes it, `link_to_front` repoints it to `<front>`, or `no_link` renders the language name as an un-clickable `<nolink>` with a `language-link--untranslated` CSS class. Additional keys refine this: `translation_detection` chooses whether a translation counts only when the user can view it (`default`) or specifically when it is published (`is_published`); `hide_single_link` drops the whole switcher when hiding leaves fewer than two links, and `hide_single_link_block` can hide the block entirely in that case; `current_language_mode` (`default` / `hide_link` / `no_link`) controls the link to the language you are already viewing; and `show_langcode` swaps full language names for their language codes. The module depends only on core `block` and `language` (with `content_translation` needed in practice to have translations to detect), ships no Drush commands and no plugin types, and defines one permission, `administer language_switcher_extended`, that gates the settings form. It works by mutating the block's link array at render time, so no template or theme override is required.

---

- Hide language switcher links for languages the current node/entity has no translation in.
- Replace a missing-translation switcher link with a link to that language's front page instead of a broken link.
- Show the language name as plain, un-clickable text (`<nolink>`) when no translation exists, keeping the switcher visually complete.
- Make every language switcher item always point at the corresponding language front page regardless of the current page.
- Improve SEO by not emitting `<a>` links to translations that do not exist.
- Detect "no translation" strictly by published status, so unpublished translations are treated as missing.
- Detect "no translation" by view access, so drafts the user can see still count as translated.
- Remove the switcher entirely when hiding untranslated links would leave only the current language.
- Hide the whole language switcher block (not just the link list) when only a single language link remains.
- Hide the link to the language currently being viewed so the switcher only offers other languages.
- Render the current language as un-clickable text with an `is-active` class instead of a self-link.
- Display language codes (EN, FR, DE) instead of full language names to save space in a compact switcher.
- Style untranslated languages differently via the `language-link--untranslated` class the module adds.
- Give editors a clear signal that a page is untranslated by showing greyed, link-less language names.
- Keep a multilingual header switcher tidy on entity pages that are only partially translated.
- Configure all of this from one admin form without writing a custom `hook_language_switch_links_alter()`.
- Export the behaviour as configuration (`language_switcher_extended.settings`) and deploy it across environments.
- Apply the untranslated handling to any content entity type surfaced as a route parameter (nodes, terms, media, etc.).
- Combine "always link to front" with "hide current language" for a minimal cross-language navigation menu.
- Avoid sending visitors to a fallback-language page they cannot read by hiding the link instead.
- Provide a language switcher that degrades gracefully on 403/404 and non-entity pages (processing simply does nothing there).
- Set the behaviour site-wide via `drush config:set` in a deployment script instead of clicking through the UI.
- Turn the core switcher into a "front pages of each language" menu with `always_link_to_front`.
- Ensure a partially translated campaign or landing page never links to empty translations.
- Present the current language distinctly while still processing untranslated links in the same block.
