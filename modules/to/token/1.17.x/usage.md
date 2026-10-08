Token provides a browsable UI for Drupal's Token API and fills in tokens missing from core, so site builders and developers can insert dynamic placeholders (like `[node:title]` or `[user:mail]`) into text that get replaced at render time.

---

Tokens are small placeholder strings such as `[node:title]`, `[site:name]`, or `[user:account-name]` that Drupal replaces with real values when content is rendered. Drupal core ships the token *engine*, but no user-facing way to discover which tokens exist; Token adds the "Browse available tokens" tree widget you see across the admin UI and on many contrib modules' forms. It also registers a number of tokens that core omits — for entities, fields, menu links, book hierarchy, arrays, and more — and adds token support to field values. For developers it exposes helper services and functions to render token trees, validate tokens, map entity types to token types, and clear the token cache. The module itself has no configuration screen and no permissions of its own; it is pure infrastructure that other modules build on. It is one of the most widely installed contrib modules because Pathauto, Metatag, Webform, Rules, and countless others depend on it. Enabling it is usually all you do — the value shows up inside other modules' forms as the token browser and as a richer set of available tokens.

---

- Add a "Browse available tokens" popup/tree to a custom configuration form.
- Let site builders discover valid tokens for a content type without reading code.
- Provide the token layer that Pathauto uses to build URL alias patterns.
- Supply tokens for Metatag patterns (meta title/description per entity).
- Feed dynamic values into Webform email templates and confirmation messages.
- Insert per-user or per-node placeholders into automated emails.
- Expose entity field values as tokens (e.g. `[node:field_subtitle]`).
- Use menu-link tokens to build breadcrumb- or hierarchy-aware text.
- Use book tokens to render a page's parent/ancestor titles.
- Render an array of values as a token-friendly list via `token_render_array()`.
- Validate user-entered tokens in a form and reject invalid ones.
- Programmatically list which token types are "global" (need no context).
- Map an entity type to its token type when writing integrations.
- Clear the token info cache after adding tokens (`drush cache:clear token`).
- Add "missing" core tokens for date formats and field configs.
- Give editors a reference of available placeholders inside CKEditor-adjacent forms.
- Build reusable message templates in contrib modules (Rules, ECA, Message).
- Standardize dynamic text in commerce order emails and receipts.
- Populate default field values with tokens that resolve per entity.
- Drive conditional/automated content with token-based patterns.
- Provide token autocomplete/reference for editorial teams.
- Let a module declare new tokens and immediately see them in the browser.
- Debug token replacement by browsing the live token tree at `/token/tree`.
- Support multilingual token replacement for translated menu links and terms.
- Act as a hard dependency for SEO, automation, and messaging module stacks.
- Render safe, sanitized token output in themed markup.
