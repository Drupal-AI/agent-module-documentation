<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Token Defaults supplies a fallback value for tokens that resolve to nothing, so a pattern such as `[node:field_summary]` does not silently produce an empty string. It hooks the token system via `hook_tokens_alter()` and fills in an administrator-configured default for any requested token that core left unresolved.

---

Tokens are used throughout a Drupal site's configuration — meta descriptions, path patterns, email bodies, scheduled messages — and they fail quietly: when a token has no value it becomes an empty string with no warning. Token Defaults closes that gap. Its `hook_tokens_alter()` implementation runs after core token replacement, compares the tokens that were requested (`$context['tokens']`) against the ones that actually got replaced, and for each token still missing it loads a matching **`token_default_token`** configuration entity and injects that entity's stored `replacement` string. Matching is by the token's owning entity — the manager reads the entity out of `$context['data']` (`entity`, or `token_type`) and matches on entity type plus token **pattern**, optionally narrowed to a single **bundle** (an empty bundle applies to any). The admin UI currently hard-codes the entity type to `node`, so in practice defaults are configured against node tokens and their content-type bundles, though the manager logic itself is entity-type agnostic. Defaults are managed at `/admin/config/search/token_default` behind the `administer token defaults` permission; a settings form there exposes a master **enabled** switch and a **recursive_limit** (default 5). Recursion matters because a replacement value may itself contain tokens: after injecting defaults the hook re-scans each replacement and runs `Token::replace()` again, guarded by the recursive limit and a logged warning to prevent an endless loop. Two design points to weigh: a fallback **hides the gap rather than fixing it**, so if the real problem is editors leaving a required field blank, a default masks the symptom while the content stays thin; and defaults **chain**, so a fallback that is itself a token can also resolve to nothing — keep the last link a literal string and test with genuinely empty content, not a well-populated example node. The module requires `token`, is version **2.0.0-rc2** (a release candidate) and supports core `^8` through `^11`.

---

- Provide a fallback meta description when a summary field is blank.
- Keep path-alias patterns from producing a bare or empty alias.
- Give a token-built email greeting a default when the name is missing.
- Fall back to the site name for an empty organisation token.
- Prevent blank meta tags on nodes without an intro field.
- Use a fixed string when `[node:field_summary]` resolves to nothing.
- Provide a default alt-text token for share images.
- Avoid empty bodies in token-driven scheduled messages.
- Diagnose which tokens silently resolve to nothing in a pattern.
- Provide a default social-share description for SEO consistency.
- Scope a default to a single content type (node bundle) only.
- Apply a default across all node bundles by leaving the bundle empty.
- Chain to another token as the fallback, capped by the recursive limit.
- Give a newsletter a fallback subject line.
- Standardise token output site-wide so generated text is never empty.
- Toggle all token defaults off at once with the enabled switch.
- Provide a default value token consumed by pathauto or metatag patterns.
- Keep the last link of a fallback chain a literal string to guarantee a value.
- Supply a default image token for view modes that reference one.
- Fill a missing author-name token in generated correspondence.
