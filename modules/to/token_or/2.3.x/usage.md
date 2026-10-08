Token Or adds "OR"/fallback logic inside a single Drupal token: `[token_a|token_b|"literal"]` resolves to the first candidate that is not empty. It extends the Token module so the syntax works anywhere tokens are replaced.

---

Token Or lets you chain several tokens (and optional quoted literal strings) with the pipe `|` character inside one bracketed token, e.g. `[node:field_og_image:entity:url|node:field_header_image:entity:url|"https://example.com/default.png"]`. When the string is replaced, each candidate is evaluated left to right and the first one that produces a non-empty result wins; a candidate wrapped in double quotes is treated as a literal fallback string rather than a token. It works by swapping Drupal's core `token` service for a subclass (via `TokenOrServiceProvider`) that fires a new `hook_tokens_pre` alter before normal replacement and overrides `scan()` so validation still recognises the piped tokens. The pipe-parsing itself lives in the `token_or.tokens_pre_alter` service, which rewrites each `[a|b|"c"]` group into whichever candidate resolves first. If nothing resolves and the caller passes the `clear` option, the whole group is removed; otherwise the original `[a|b]` text is left in place. There is no admin UI, no configuration, and no plugin type — the module is pure syntax on top of the existing Token API, so any token registered by core or contrib (through `hook_token_info()` / `hook_tokens()`) can participate in an OR expression automatically. The `token_or_webform` submodule extends the same fallback behaviour to Webform's own token manager. It depends only on the Token module.

---

- Show an Open Graph image token, falling back to a header image token, then a hard-coded default URL.
- Display a node's summary token, or its full body token if the summary is empty.
- Use a field value token, otherwise a site-wide default string wrapped in quotes.
- Provide a fallback author name: `[node:author:field_display_name|node:author:name]`.
- Build a meta description from a dedicated field, falling back to the teaser.
- Chain three or more tokens so the first non-empty one is used.
- Supply a literal string default when every token in the chain is empty (`|"N/A"`).
- Clear an unresolved OR token group entirely by passing the `clear` option.
- Add fallback logic to Metatag values without writing custom PHP.
- Provide default email subjects/bodies where a preferred token may be missing.
- Fall back from a translated field token to the untranslated original.
- Use a user profile field token, or the username if the profile field is blank.
- Populate Pathauto patterns with a preferred token and a safe fallback.
- Fall back from a custom media field to a default asset URL string.
- Combine several address-part tokens, using the first that has data.
- Keep existing single tokens working unchanged (non-piped tokens are untouched).
- Let any contrib-provided token participate in an OR chain with no extra code.
- Register your own token with the standard Token API and use it in fallbacks.
- Provide fallback values inside Webform email handlers via `token_or_webform`.
- Give anonymous users a safe literal fallback for `[current-user:*]` tokens in Webform.
- Validate piped tokens without false "invalid token" errors (overridden `scan()`).
- Author fallback tokens directly in any text field that supports token replacement.
- Avoid empty gaps in rendered templates by defaulting to a literal string.
- Migrate legacy "if empty use X" logic into a single declarative token expression.
