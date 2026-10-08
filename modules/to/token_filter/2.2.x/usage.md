Token Filter is a text-format input filter that replaces global and entity tokens (like `[site:name]` or `[node:title]`) with their real values when a field is rendered.

---

Token Filter integrates the Token module with Drupal's text-format (input filter) system. After enabling it you add the "Replaces global and entity tokens with their values" filter to any text format at `/admin/config/content/formats`, and thereafter any token typed into a field using that format is expanded at render time. It supports global tokens (site name, current date, logged-in user) and, when the field belongs to a content entity, entity tokens for that entity (the module captures the rendered entity via a field preprocess hook). When the Token module is installed it also provides a CKEditor 5 "Token browser" button so editors can pick tokens from the standard token tree instead of memorizing them. It ships a filter plugin (`TokenFilter`) and a CKEditor 5 plugin, plus a migration mapping so Drupal 7 `filter_tokens` filters convert to `token_filter`. Ordering matters: place the filter appropriately relative to other filters (e.g. before "Convert line breaks"). It is a lightweight, dependency-light building block used widely for dynamic snippets in body text, blocks, and custom fields.

---

- Insert the site name with `[site:name]` inside body copy.
- Show the current date in a page using a date token.
- Display the logged-in user's name via `[current-user:name]`.
- Render a node's author or title inline in its own body field.
- Put a support email `[site:mail]` into a reusable custom block.
- Add dynamic copyright year to a footer block.
- Personalize a greeting with the current user's display name.
- Insert entity field values into other fields of the same entity.
- Build email-template-like content with tokens in a text field.
- Give editors a "Browse available tokens" button in CKEditor 5.
- Standardize contact details across pages by referencing site tokens.
- Show the current node's URL or ID inside its content.
- Keep marketing snippets DRY by referencing global config via tokens.
- Display taxonomy term names on term description fields.
- Insert the base URL into embedded instructions.
- Provide dynamic values inside Views text areas that use a filtered format.
- Convert legacy Drupal 7 token filters during migration automatically.
- Add per-entity dynamic text without custom code.
- Include the current path or query values through tokens.
- Combine with a restricted text format so only trusted roles use tokens.
- Render dynamic values inside webform confirmation or email markup fields.
- Show the site slogan `[site:slogan]` on a landing block.
