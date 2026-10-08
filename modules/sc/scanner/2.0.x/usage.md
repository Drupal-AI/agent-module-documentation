Search and Replace Scanner performs administrator-driven find-and-replace across the text of
chosen entity fields (nodes, paragraphs, Commerce products/variations, and any entity type a
Scanner plugin supports), with a preview of matches and an undo of the last replace.

---

Scanner adds a two-step search-and-replace tool at **Admin → Content → Search and Replace
Scanner** (`/admin/content/scanner`). An administrator first chooses on the settings page
(**Admin → Config → Content authoring → Search and Replace Scanner**,
`/admin/config/content/scanner`, route `scanner.admin_config`) which entity type/bundle
**fields** may be scanned and the default matching options. Editors then enter a search term
and a replacement, tune the match (case sensitivity, whole-word, regular expression, a
"preceded by"/"followed by" context, published-only, language), run a **Search** that lists
every matching entity and highlights the hits, then **confirm** to replace across all matches
in one batch. Each replace writes a new revision (on revisionable entities) with a log
message and can be reverted from the **Undo** tab. The engine is a plugin system: each
supported entity type is a `Scanner` plugin (`Plugin/Scanner`) extending a shared `Entity`
base that does the query-building (ICU / Henry Spencer word boundaries for MySQL/MariaDB
compatibility) and `preg_replace`-based rewriting of text, string, and link field values.
Ships plugins for Node, Paragraph, Commerce Product and Product Variation; more can be added
or altered via a plugin and `hook_scanner_info_alter()`. Access is gated by three
permissions: search-only, search-and-replace, and administer-settings. There are no Drush
commands — everything runs through the UI or the `plugin.manager.scanner` service.

---

- Rename a company, product, or brand everywhere it appears across all article bodies at once.
- Fix a misspelling repeated across hundreds of nodes without editing each by hand.
- Update an old phone number, address, or email domain across published content site-wide.
- Swap a legacy URL or path for a new one inside link fields and body copy.
- Replace a deprecated shortcode or token string across many pages.
- Migrate inline markup (e.g. change `<b>` to `<strong>`) across long-text fields with a regex.
- Normalise inconsistent terminology (e.g. "e-mail" → "email") across an editorial corpus.
- Update copyright years or dated boilerplate embedded in content.
- Replace a discontinued SKU or part number across Commerce product descriptions.
- Rewrite text inside Paragraphs components attached to landing pages.
- Do a case-sensitive replacement that only touches an exact-case acronym (e.g. "IT" not "it").
- Use whole-word matching to change "cat" without touching "category" or "cats".
- Apply a "preceded by"/"followed by" context so a term is only replaced in a specific phrase.
- Restrict a replacement to a single language on a multilingual site.
- Restrict a search to published content only, leaving drafts untouched.
- Preview how many entities and matches a change will affect before committing it.
- Roll back an over-broad replacement using the Undo tab (restores the prior revision).
- Bulk-strip an unwanted string (replace with empty) from many fields at once.
- Clean up tracking parameters or campaign codes left in link fields.
- Reword calls-to-action consistently across marketing content.
- Perform the replace programmatically from custom code via the `plugin.manager.scanner` service.
- Add search-and-replace support for a custom entity type by writing a `Scanner` plugin.
- Swap in a custom Node scanner class by implementing `hook_scanner_info_alter()`.
- Give non-editors a safe "search only" role to audit where a term appears without edit rights.
- Fix data-entry artifacts (double spaces, stray HTML entities) across a content set with regex.
