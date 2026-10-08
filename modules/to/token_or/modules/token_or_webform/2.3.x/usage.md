Token Or Webform extends token_or's "OR"/fallback token syntax to Webform's own token manager, so `[a|b|"literal"]` fallback tokens work inside Webform emails, confirmations, and other Webform-rendered text.

---

Webform does not replace tokens through Drupal's core `token` service directly — it uses its own `webform.token_manager` service (`WebformTokenManager`). Because token_or swaps the core `token` service, its OR syntax would otherwise be bypassed inside Webform. This submodule fixes that by **decorating** `webform.token_manager` (decoration priority 50) with `TokenOrWebformTokenManager`, a subclass of `WebformTokenManager`. Its overridden `replace()` detects when the text contains a `|`, forces the `clear` option on so unresolved OR groups are removed, and then delegates to the parent — which runs through token_or's replacement and honours the pipe/fallback syntax. It also adds special handling for anonymous users: when the text contains `[current-user:…|…]` and the current user is anonymous, it strips the leading `current-user:` candidate (which would otherwise render "Anonymous") so the next candidate — often a literal fallback string — is used, and cleans up any leftover single quoted-string token. Text without a `|`, and array input, pass straight through to the normal Webform token manager unchanged. It requires both Webform and token_or, and adds no configuration, permissions, or plugin type.

---

- Use `[a|b|"literal"]` fallback tokens inside Webform email handler subjects and bodies.
- Provide a default confirmation message when a preferred token is empty.
- Fall back from a submitted field value to a literal string in a Webform email.
- Give anonymous submitters a safe literal fallback for `[current-user:*]` tokens.
- Avoid the literal text "Anonymous" leaking into emails for logged-out users.
- Fall back from `[current-user:display-name|"Guest"]` to "Guest" for anonymous users.
- Fall back from `[current-user:email|"no-reply@example.com"]` in reply-to headers.
- Chain multiple submission tokens, using the first non-empty one, in a handler.
- Keep normal (non-piped) Webform tokens working exactly as before.
- Process arrays of Webform text values while preserving fallback behaviour.
- Force removal of unresolved OR groups in Webform text (clear is applied automatically).
- Default a Webform-generated PDF/email field to a literal when the token is blank.
- Populate handler remote-post payloads with fallback token values.
- Provide fallback values in Webform computed tokens elements.
- Reuse the same token_or syntax across both site tokens and Webform tokens consistently.
- Migrate Webform "if empty use X" email logic into declarative fallback tokens.
- Fall back from a preferred contact field to a site default address string.
- Ensure Webform confirmation URLs default to a literal when a token is empty.
- Let contrib-provided Webform tokens participate in OR chains automatically.
- Provide language-safe fallbacks in multilingual Webform emails.
